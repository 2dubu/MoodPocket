//
//  MainView.swift
//  MoodPocket
//
//  Created by 이건우
//

import SwiftUI
import UIKit
import UnsplashPhotoPicker

struct MainView: View {
    @State private var isPickerPresented = false
    @State private var selectedImageUrl: URL?
    @State private var showWriteView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                headerView
                navigationButton
            }
            .navigationTitle("Home")
            .navigationDestination(isPresented: $showWriteView) {
                WriteView(imageUrl: selectedImageUrl)
            }
            .sheet(isPresented: $isPickerPresented) {
                UnsplashImagePicker(selectedImageUrl: $selectedImageUrl) {
                    showWriteView = true
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 12) {
            Text("How was your day?")
                .font(.system(size: 30, weight: .regular))
            
            Text("Please keep track of your day today.")
                .fontWeight(.light)
                .padding(.bottom, 40)
        }
    }
    
    private var navigationButton: some View {
        Button("Go to Write →") {
            isPickerPresented.toggle()
        }
        .foregroundStyle(.black.opacity(0.6))
    }
}
