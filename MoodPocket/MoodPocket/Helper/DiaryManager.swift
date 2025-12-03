//
//  DiaryManager.swift
//  MoodPocket
//
//  Created by 이건우
//

import SwiftUI

struct DiaryEntry: Codable, Equatable {
    let imageUrl: URL?
    let content: String
    let date: Date
}

class DiaryManager: ObservableObject {
    static let shared = DiaryManager()
    private let key = "DiaryEntries"
    
    @Published var entries: [DiaryEntry] = []
    
    init() {
        loadEntries()
    }
    
    func loadEntries() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decodedEntries = try? JSONDecoder().decode([DiaryEntry].self, from: data) {
                entries = decodedEntries.sorted(by: { $0.date > $1.date })
            } else {
                entries = []
            }
        }
    }

    func saveEntry(imageUrl: URL?, content: String, date: Date) {
        let newEntry = DiaryEntry(imageUrl: imageUrl, content: content, date: date)
        entries.append(newEntry)
        saveEntries()
    }

    func deleteEntry(at index: Int) {
        guard index >= 0 && index < entries.count else { return }
        entries.remove(at: index)
        saveEntries()
    }

    private func saveEntries() {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
