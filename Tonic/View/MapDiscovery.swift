import SwiftUI
import MapKit
import FirebaseDatabase
import FirebaseCore

struct MapDiscovery: View {
    @EnvironmentObject var tonicViewModel: TonicViewModel
    @State private var selectedUser: Person?
    private var location: [Double]
    private var user: Person

    // Map region
    @State private var region: MKCoordinateRegion

    init(user: Person) {
        self.user = user
        self.location = user.location

        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location[0], longitude: location[1]),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        ))
    }

    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: tonicViewModel.users) { mapUser in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: mapUser.location[0], longitude: mapUser.location[1])) {
                    annotationContent(for: mapUser)
                }
            }
            .ignoresSafeArea()
            .frame(maxHeight: .infinity)
        }
        .onAppear(perform: fetchLocations)
        .sheet(item: $selectedUser) { user in
            ProfilePage(user: user, isCurrentUser: user.id == tonicViewModel.currentUser.id)
        }
    }

    private func annotationContent(for mapUser: Person) -> some View {
        VStack {
            if mapUser.id == user.id {
                Image("UserLocationArrow")
                    .imageScale(.large)
            } else {
                let commonInterests = Set(tonicViewModel.currentUser.interests).intersection(mapUser.interests)
                    let commonCount = commonInterests.count
        
                    // Determine the return value
                    if commonCount <= 3 {
                        Image("orangedot") // You can use a different image for other users
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10)
                            .padding(10)
                    } else {
                        Image("biggerdot") // You can use a different image for other users
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(10)
                    }
            }
            
            Text(mapUser.username)
                .font(.caption)
                .foregroundColor(mapUser.id == user.id ? .purple : .orange)
        }
        .onTapGesture {
            selectedUser = mapUser
        }
    }


    private func fetchLocations() {
        let databaseRef = Database.database().reference()
        databaseRef.child("users").observeSingleEvent(of: .value, with: { snapshot in
            guard let users = snapshot.value as? [String: [String: Any]] else {
                print("No users found or data format is incorrect.")
                return
            }

            let dispatchGroup = DispatchGroup()

            for (_, userData) in users {
                if let address = userData["location"] as? String {
                    dispatchGroup.enter()
                    getCoordinates(from: address) { result in
                        switch result {
                        case .success(let coordinates):
                            if let userId = userData["user_id"] as? Int,
                                  let firstName = userData["firstName"] as? String,
                                  let lastName = userData["lastName"] as? String,
                                  let gender = userData["gender"] as? String,
                                  let birthday = userData["birthday"] as? String,
                                  let bio = userData["bio"] as? String,
                                  let username = userData["username"] as? String,
                                  let interests = userData["interests"] as? [String],
                                  let friends = userData["friends"] as? [String] {
                                   tonicViewModel.create(
                                       id: userId,
                                       firstName: firstName,
                                       lastName: lastName,
                                       gender: gender,
                                       birthday: birthday,
                                       bio: bio,
                                       username: username,
                                       location: [coordinates.latitude, coordinates.longitude],
                                       interests: interests,
                                       friends: friends
                                   )

                                   if user.id == userId {
                                       DispatchQueue.main.async {
                                           TonicViewModel.shared.currentIndex = TonicViewModel.shared.users.count - 1
                                       }
                                   }
                               } else {
                                   print("Missing or invalid user data.")
                               }
                        case .failure(let error):
                            print("Error geocoding address: \(error.localizedDescription)")
                        }
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                print("All geocoding tasks are complete.")
            }
        })
    }

    private func getCoordinates(from address: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let placemark = placemarks?.first, let location = placemark.location {
                completion(.success(location.coordinate))
            } else {
                let noLocationError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No matching location found."])
                completion(.failure(noLocationError))
            }
        }
    }
}

struct MapDiscovery_Previews: PreviewProvider {
    static var previews: some View {
        MapDiscovery(user: TonicViewModel.shared.currentUser)
            .environmentObject(TonicViewModel.shared)
    }
}
