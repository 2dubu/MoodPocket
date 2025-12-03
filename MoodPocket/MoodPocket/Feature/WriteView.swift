//
//  WriteView.swift
//  MoodPocket
//
//  Created by 이건우
//

import SwiftUI

struct WriteView: View {
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isFocused: Bool
    @State private var content: String = ""
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    private func saveEntry() {
        DiaryManager.shared.saveEntry(imageUrl: imageUrl, content: content, date: Date())
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                imageView
                textField
                Spacer(minLength: 200)
            }
            .scrollIndicators(.never)
            
            saveButton
                .padding(.bottom, 12)
        }
    }
    
    private var imageView: some View {
        LoadableImageView(imageUrl: imageUrl)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(maxWidth: .infinity)
            .padding(20)
            .myShadow2()
    }
    
    private var textField: some View {
        TextField("Write your today's story", text: $content)
            .focused($isFocused)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 20)
    }
    
    private var saveButton: some View {
        Button {
            saveEntry()
            dismiss()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                .foregroundStyle(.black)
                .overlay {
                    Text("기록하기")
                        .foregroundStyle(.white)
                }
        }
    }
}

