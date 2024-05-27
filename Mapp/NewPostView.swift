//
//  NewPostView.swift
//  Mapp
//
//  Created by Chiara Giorgia Ricci on 29/05/24.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @State var description: String = ""
    @State var showImagePicker: Bool = false
    @State var pickedItem: PhotosPickerItem? = nil
    @State var pickedPhoto: Data? = nil
    
    
    @Binding var posts: [Post]
    let saveAction: () -> Void
    
    let userPosition: CLLocationCoordinate2D
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            if pickedItem == nil {
                Image("FedericaSullaMappa")
                    .resizable()
                    .scaledToFit()
            } else {
                if let pickedPhoto,
                let image = UIImage(data: pickedPhoto) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()

                }
            }
        }
        .onTapGesture {
            showImagePicker.toggle()
        }
        TextField("Description", text: $description)
        
        .photosPicker(isPresented: $showImagePicker, selection: $pickedItem)
        
        .task(id: pickedItem) {
            pickedPhoto = try? await pickedItem?.loadTransferable(type: Data.self)
        }
        
        .toolbar {
            ToolbarItem {
                Button("Done") {
                    posts.append(Post(position: userPosition, image: pickedPhoto!, description: description))
                    saveAction()
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NewPostView(description: "", posts: .constant([]), saveAction: {}, userPosition: CLLocationCoordinate2D())
}
