//
//  API.swift
//  blankAPI
//
//  Created by Farman Ali on 3/18/25.
//
import Foundation

// MARK: - Codable Models
struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable, Identifiable {  // Ensure this struct exists
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
}

// MARK: - Fetching Data Function
func fetchCharacters() async throws -> [Character] {
    let urlString = "https://rickandmortyapi.com/api/character"
    guard let url = URL(string: urlString) else { throw URLError(.badURL) }

    let (data, _) = try await URLSession.shared.data(from: url)
    let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
    return characterResponse.results
}
