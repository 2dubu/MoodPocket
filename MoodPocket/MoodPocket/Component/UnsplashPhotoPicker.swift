//
//  UnsplashImagePicker.swift
//  MoodPocket
//
//  Created by 이건우
//

import SwiftUI
import UnsplashPhotoPicker

struct UnsplashImagePicker: UIViewControllerRepresentable {
    @Binding private var selectedImageUrl: URL?
    private var completion: () -> Void?

    init(
        selectedImageUrl: Binding<URL?>,
        completion: @escaping () -> Void = {}
    ) {
        self._selectedImageUrl = selectedImageUrl
        self.completion = completion
    }
    
    private var configuration = UnsplashPhotoPickerConfiguration(
        accessKey: Bundle.main.infoDictionary?["ACCESS_KEY"] as? String ?? "",
        secretKey: Bundle.main.infoDictionary?["SECRET_KEY"] as? String ?? "",
        allowsMultipleSelection: false
    )
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<UnsplashImagePicker>) -> UnsplashPhotoPicker {
        let unsplashPhotoPicker = UnsplashPhotoPicker(configuration: configuration)
        unsplashPhotoPicker.photoPickerDelegate = context.coordinator
        return unsplashPhotoPicker
    }
    
    func makeCoordinator() -> UnsplashImagePicker.Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: UnsplashPhotoPickerDelegate {
        
        var parent: UnsplashImagePicker
        
        init(_ parent: UnsplashImagePicker) {
            self.parent = parent
        }
        
        func unsplashPhotoPicker(
            _ photoPicker: UnsplashPhotoPicker,
            didSelectPhotos photos: [UnsplashPhoto]
        ) {
            guard let photoURL = photos.first?.links[.download] else { return }
            parent.selectedImageUrl = photoURL
            parent.completion()
            print(photoURL)
        }
        
        func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
            print("Unsplash photo picker did cancel")
        }
    }
    
    func updateUIViewController(
        _ uiViewController: UnsplashPhotoPicker,
        context: UIViewControllerRepresentableContext<UnsplashImagePicker>
    ) { }
}
