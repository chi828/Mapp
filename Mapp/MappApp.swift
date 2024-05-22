//
//  MappApp.swift
//  Mapp
//
//  Created by Chiara Giorgia Ricci on 22/05/24.
//

import SwiftUI

@main
struct MappApp: App {
    
    
    @StateObject private var dataPersistence = DataPersistence()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(locations: $dataPersistence.locations) {
                Task {
                    do {
                        try await dataPersistence.save(scrums: dataPersistence.locations)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await dataPersistence.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
