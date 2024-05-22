//
//  ContentView.swift
//  Mapp
//
//  Created by Chiara Giorgia Ricci on 22/05/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @ObservedObject var locationManager = LocationDataManager.shared
    @State var nomePosto = ""
    @Binding var locations: [Location]
    let saveAction: () -> Void
    
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.6, longitude: 14.37), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)))
    
    var mapCamera: MapCamera = MapCamera(centerCoordinate: CLLocationCoordinate2D.init(latitude: 40, longitude: 14), distance: 50000)
    
    var body: some View {
        
        Map(initialPosition: startPosition, content: {
            UserAnnotation()
            ForEach(locations) { posto in
                Marker("giovanni", coordinate: posto.position())
            }
        })
        
        Button("Ciao") {
            locationManager.ciao()
        }
        Button("Stampa posizione") {
            if let location = locationManager.userLocation {
                nomePosto = "\(location.coordinate.latitude)   \(String(describing: location.coordinate.longitude))"
                locations.append(Location(position: location.coordinate))
                saveAction()
                
            } else {
                nomePosto = "E non lo so fratm"
            }
        }
        Text(nomePosto)
    }
}

#Preview {
    ContentView(locations: .constant([]), saveAction: {})
}
