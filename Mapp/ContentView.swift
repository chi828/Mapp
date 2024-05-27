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
    @Binding var posts: [Post]
    @State var uaaa = "Non sono entrato in task"
    
    let map = MKMapView()
    
    let saveAction: () -> Void
    
    @State var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.6, longitude: 14.37), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)))
    
    var mapCamera = MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: 40.6, longitude: 14.37), distance: 100, pitch: 1000)
    
    
    var body: some View {
        if locationManager.locationServicesAuthorized() {
            NavigationStack {
                Map(position: $cameraPosition, content: {
                    UserAnnotation()
                    ForEach(posts) { posto in
                        Annotation("Ciao", coordinate: posto.position(), anchor: .bottom, content: {
                            
                            NavigationLink(destination: PostView(post: posto)) {
                                Image("FedericaSullaMappa")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                            }
                        }
                        )
                        .annotationTitles(.hidden)
                    }
                })
                .mapControls {
                    MapCompass()
                }
                .mapStyle(MapStyle.standard(elevation: MapStyle.Elevation.realistic, pointsOfInterest: PointOfInterestCategories.including([MKPointOfInterestCategory.airport, MKPointOfInterestCategory.amusementPark, MKPointOfInterestCategory.aquarium, MKPointOfInterestCategory.museum, MKPointOfInterestCategory.nationalPark, MKPointOfInterestCategory.stadium, MKPointOfInterestCategory.theater, MKPointOfInterestCategory.university, MKPointOfInterestCategory.zoo])))
                
                
                //            Map(initialPosition: MapCameraPosition.camera(mapCamera), content: {
                //                UserAnnotation()
                //                ForEach(posts) { posto in
                //                Marker("giovanni", coordinate: posto.position())
                //                    .annotationTitles(Visibility.hidden)
                //                    Annotation("Ciao", coordinate: posto.position(), anchor: .bottom, content: {
                
                //                        NavigationLink(destination: PostView(post: posto)) {
                //                            Image("FedericaSullaMappa")
                //                                .resizable()
                //                                .frame(width: 100, height: 100)
                
                //                        }
                //                    }
                //                    )
                //                    .annotationTitles(.hidden)
                //                }
                //            })
                
                NavigationLink(destination: NewPostView(posts: $posts, saveAction: saveAction, userPosition: locationManager.userLocation?.coordinate ?? CLLocationCoordinate2D())) {
                    Text("Nuovo Post")
                }
                
                Text(posts.count.description)
                //            Button("Stampa posizione") {
                //                if let location = locationManager.userLocation {
                //                    nomePosto = "\(location.coordinate.latitude)   \(String(describing: location.coordinate.longitude))"
                //                    locations.append(Post(position: location.coordinate))
                //                    saveAction()
                //
                //                } else {
                //                    nomePosto = "E non lo so fratm"
                //                }
                //            }
                Text(nomePosto + uaaa)
            }
            //        .task(id: locationManager.userLocation) {
            //            if let location = locationManager.userLocation {
            //                cameraPosition =
            //                MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)))
            //                MapCameraPosition.camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), distance: 100, heading: location.course, pitch: 1000))
            //                uaaa = "uaaaaa"
            //            }
            //        }
            .onAppear {
                if let location = locationManager.userLocation {
                    locationManager.ciao()
                    cameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), distance: 100, heading: location.course, pitch: 1000))
                    uaaa = "pizza"
                }
            }
        } else {
            Text("Please authorize location services")
            Button("Go to settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
}

#Preview {
    ContentView(posts: .constant([Post(position: CLLocationCoordinate2D(latitude: 40.6, longitude: 14.3), image: UIImage(named: "FedericaSullaMappa")!.pngData()!, description: "cipolle")]), saveAction: {})
}
