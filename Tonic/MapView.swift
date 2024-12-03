import SwiftUI
import MapKit
import FirebaseDatabase
import FirebaseCore

struct MapView: View {
    var user_id = 1

    @State private var userLocation: CLLocationCoordinate2D? = nil
    @State private var otherUserLocations: [CLLocationCoordinate2D] = []
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        // default location -- SF
        let defaultLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)

        Map(position: $cameraPosition){
            Annotation("You", coordinate: userLocation ?? defaultLocation){
                Image("UserLocationArrow")
                    .imageScale(.large)
            }
            ForEach(otherUserLocations, id: \.self.latitude) { location in
                Annotation("", coordinate: location) {
                    Image("PurpleDot") // You can use a different image for other users
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                        .padding(10)
                }
            }
        }

            .onAppear {
                fetchLocations()
            }
    }

    private func fetchLocations() {
        let databaseRef = Database.database().reference()
        databaseRef.child("users").observeSingleEvent(of: .value) { snapshot in
            if let users = snapshot.value as? [String: [String: Any]] {
                var tempLocations: [CLLocationCoordinate2D] = []
                
                // Create a DispatchGroup to track geocoding completion
                let dispatchGroup = DispatchGroup()
                
                // Loop through the users to find the matching user_id
                for (_, userData) in users {
                    if let address = userData["location"] as? String {
                        // Enter the DispatchGroup for each geocoding request
                        dispatchGroup.enter()
                        
                        // Call geocoding to get coordinates
                        getCoordinates(from: address) { result in
                            switch result {
                            case .success(let coordinates):
                                // Update userLocation state to trigger map update
                                if let id = userData["user_id"] as? Int, id == self.user_id {
                                    DispatchQueue.main.async {
                                        self.userLocation = coordinates
                                    }
                                } else {
                                    tempLocations.append(coordinates)
                                    print("got other user loc: \(coordinates)")
                                }
                            case .failure(let error):
                                print("Error geocoding address: \(error.localizedDescription)")
                            }
                            
                            // Leave the DispatchGroup when geocoding completes
                            dispatchGroup.leave()
                        }
                    }
                }
                
                // Notify when all geocoding tasks are complete
                dispatchGroup.notify(queue: .main) {
                    // Now that all geocoding is complete, update the state
                    self.otherUserLocations = tempLocations
                    print("Final other user locations: \(tempLocations)")
                }
            } else {
                print("No users found or data format is incorrect.")
            }
        }
    }

    func getCoordinates(from address: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                completion(.failure(error)) // Return the error
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                completion(.success(location.coordinate)) // Return the coordinates
            } else {
                let noLocationError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No matching location found."])
                completion(.failure(noLocationError)) // Return a custom error
            }
        }
    }
}
