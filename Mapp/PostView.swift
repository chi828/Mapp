//
//  PostView.swift
//  Mapp
//
//  Created by Chiara Giorgia Ricci on 29/05/24.
//

import SwiftUI
import CoreLocation

struct PostView: View {
    
    let post: Post
    
    var body: some View {
        Image(uiImage: UIImage(data: post.image)!)
            .resizable()
            .scaledToFit()
        Text(post.description)
    }
}

#Preview {
    PostView(
        post: Post(position: CLLocationCoordinate2D(latitude: 40, longitude: 14), image: UIImage(named: "FedericaSullaMappa")!.pngData()!, description: "questa è una description")
        )
}
