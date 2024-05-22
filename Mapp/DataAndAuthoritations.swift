//
//  DataAndAuthoritations.swift
//  Mapp
//
//  Created by Chiara Giorgia Ricci on 22/05/24.
//

import Foundation
import CoreLocation


class LocationDataManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    //singleton design pattern
    static let shared = LocationDataManager()
    
    //The location manager
    private let locationManager = CLLocationManager()
    
    //Non so a che serve
    @Published var userLocation: CLLocation?
    
    @Published var location: CLLocationCoordinate2D?
    
    //Constructor, sets the locationManager as the (single) instance of this class as the location manager delegate
    override init() {
        super.init()
        
        locationManager.delegate = self
        
        //Non so se aiuta coccos
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    //I will get back at you when I understand what this does
    func ciao() {
        locationManager.requestWhenInUseAuthorization()
    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization
//                         status: CLAuthorizationStatus) {
//        switch status {
//        case .notDetermined:
//            print("DEB Not determinded")
//        case .restricted:
//            print("DEB restricted")
//        case .denied:
//            print("DEB denied")
//        case .authorizedAlways:
//            print("DEB Authorized always")
//        case .authorizedWhenInUse:
//            print("DEB Authorized when in use")
//        @unknown default:
//            print("DEB WAAA")
//            break
//        }
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation = location
    }
}




//Dati pizza 🍕
class Location: ObservableObject, Identifiable, Decodable, Encodable {
    var id = UUID()
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    init(position: CLLocationCoordinate2D) {
        self.latitude = position.latitude
        self.longitude = position.longitude
    }
    
    func position() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

//Data percistency
import SwiftUI

class DataPersistence: ObservableObject {
    //The data
    @Published var locations: [Location] = []
    
    //I'm assuming this function connects with the data
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("nexa.data")
    }
    
    //This is to load data when the app starts running
    @MainActor
    func load() async throws {
        let task = Task<[Location], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else { return [] }
            let dailyThreads = try JSONDecoder().decode([Location].self, from: data)
            return dailyThreads
        }
        self.locations = try await task.value
    }
    
    //This is to save data and it's called within another function which catches errors
    @MainActor
    func save(scrums: [Location]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(scrums)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}

