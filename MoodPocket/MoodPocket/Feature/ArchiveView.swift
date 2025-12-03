//
//  ArchiveView.swift
//  MoodPocket
//
//  Created by 이건우
//

import SwiftUI

struct ArchiveView: View {
    @StateObject private var diaryManager = DiaryManager.shared
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }
    
    private func deleteEntry(at offsets: IndexSet) {
        offsets.forEach { index in
            withAnimation {
                diaryManager.deleteEntry(at: index)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if diaryManager.entries.isEmpty {
                    noEntriesView
                } else {
                    entryListView
                }
            }
            .onAppear {
                withAnimation {
                    diaryManager.loadEntries()
                }
            }
            .navigationTitle("Archived")
            .refreshable {
                withAnimation {
                    diaryManager.loadEntries()
                }
            }
        }
    }
    
    private var noEntriesView: some View {
        Text("No diary has been recorded yet.\nTry writing a new diary!")
            .foregroundColor(.gray)
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(.bottom, 40)
    }
    
    private var entryListView: some View {
        List {
            ForEach(diaryManager.entries.indices, id: \.self) { index in
                let entry = diaryManager.entries[index]
                entryRow(entry: entry)
            }
            .onDelete(perform: deleteEntry)
        }
        .animation(.easeInOut, value: diaryManager.entries)
    }
    
    private func entryRow(entry: DiaryEntry) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 10) {
                if let url = entry.imageUrl {
                    LoadableImageView(imageUrl: url)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                VStack(alignment: .leading, spacing: 6) {
                    Text(entry.content)
                        .font(.body)
                    Text(dateFormatter.string(from: entry.date))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
