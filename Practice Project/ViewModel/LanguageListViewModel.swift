//
//  LanguageListViewModel.swift
//  Practice Project
//
//  Created by Tharik Batcha on 04/03/26.
//

import Foundation
import Combine

class LanguageListViewModel {

    @Published var searchText: String = ""
    @Published private(set) var filteredLanguages: [Language] = []

    private var languages: [Language] = []
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadLanguages()
        bindSearch()
    }

    private func loadLanguages() {

        languages = [
            Language(name: "English (US)", nativeName: "English", countryCode: "US"),
            Language(name: "English (UK)", nativeName: "English", countryCode: "GB"),
            Language(name: "Hindi", nativeName: "हिन्दी", countryCode: "IN"),
            Language(name: "French", nativeName: "Français", countryCode: "FR"),
            Language(name: "Japanese", nativeName: "日本語", countryCode: "JP"),
            Language(name: "Chinese", nativeName: "中文", countryCode: "CN"),
            Language(name: "German", nativeName: "Deutsch", countryCode: "DE"),
            Language(name: "Spanish", nativeName: "Español", countryCode: "ES"),
            Language(name: "Portuguese", nativeName: "Português", countryCode: "PT"),
            Language(name: "Vietnamese", nativeName: "Tiếng Việt", countryCode: "VN"),
            Language(name: "Gujarati", nativeName: "ગુજરાતી", countryCode: "IN"),
            Language(name: "Tamil", nativeName: "தமிழ்", countryCode: "IN"),
            Language(name: "Marathi", nativeName: "मराठी", countryCode: "IN"),
            Language(name: "Telugu", nativeName: "తెలుగు", countryCode: "IN"),
            Language(name: "Malayalam", nativeName: "മലയാളം", countryCode: "IN"),
            Language(name: "Bengali", nativeName: "বাংলা", countryCode: "IN"),
            Language(name: "Kannada", nativeName: "ಕನ್ನಡ", countryCode: "IN"),
            Language(name: "Russian", nativeName: "Русский", countryCode: "RU"),
            Language(name: "Korean", nativeName: "한국어", countryCode: "KR"),
            Language(name: "Arabic", nativeName: "العربية", countryCode: "AE")
        ]

        filteredLanguages = languages
    }

    private func bindSearch() {

        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { [weak self] text -> [Language] in

                guard let self else { return [] }

                if text.isEmpty { return self.languages }

                return self.languages.filter {
                    $0.name.lowercased().contains(text.lowercased()) ||
                    $0.nativeName.lowercased().contains(text.lowercased())
                }
            }
            .assign(to: &$filteredLanguages)
    }

    func language(at index: Int) -> Language {
        filteredLanguages[index]
    }

    func numberOfRows() -> Int {
        filteredLanguages.count
    }
}
