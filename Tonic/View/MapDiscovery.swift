//
//  SwiftUIView.swift
//  Tonic
//
//  Created by Student on 11/28/24.
//

import SwiftUI
import MapKit

struct MapDiscovery: View {
    @EnvironmentObject var tonicViewModel: TonicViewModel
    @State private var selectedUser: Person?
    private var location: [Double]
    
    private var user: Person
    
    // Map region
    @State private var region: MKCoordinateRegion
    
    init(user: Person) {
        self.user = user
        location = user.location
        
        _region = State(initialValue: MKCoordinateRegion(
            // Map centered in LA
            center: CLLocationCoordinate2D(latitude: location[0], longitude: location[1]),
            // Define the span (zoom level) of the map
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        ))
    }
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: tonicViewModel.users) { mapUser in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: mapUser.location[0], longitude: mapUser.location[1])) {
                    VStack {
                        Circle()
                            .fill(mapUser.id == user.id ? Color.blue : Color.red)
                            .frame(width: mapUser.id == user.id ? 20 : 15, height: mapUser.id == user.id ? 20 : 15)
                        Text(mapUser.username)
                            .font(.caption)
                            .foregroundColor(mapUser.id == user.id ? .blue : .red)
                    }
                    .onTapGesture {
                        selectedUser = mapUser
                    }
                }
            }
            .ignoresSafeArea()
            .frame(maxHeight: .infinity)
        }
        .sheet(item: $selectedUser) { user in
            ProfilePage(user:user, isCurrentUser: user.id == tonicViewModel.currentUser.id)
        }
    }
}

struct MapDiscovery_Previews: PreviewProvider {
    static var previews: some View {
        MapDiscovery(user: TonicViewModel.shared.currentUser)
            .environmentObject(TonicViewModel.shared)
    }
}
