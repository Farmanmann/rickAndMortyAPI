# Rick and Morty API Integration in Swift

This project fetches character data from the **Rick and Morty API** and displays it in a SwiftUI-based app. The API fetch logic is handled in **`API.swift`**, while the UI is built using **`ContentView.swift`**.

---

## API Overview
- **Base URL:** `https://rickandmortyapi.com/api/character`
- **Data Structure:**
  - The API returns a list of characters, each containing:
    - `id`: Unique identifier
    - `name`: Character's name
    - `status`: Alive, Dead, or Unknown
    - `species`: The species of the character
    - `image`: URL to the character's image

---

##File Breakdown

###API.swift (Handles Data Fetching)
- Defines `CharacterResponse` and `Character` models using `Codable` for JSON decoding.
- Uses `fetchCharacters()` to fetch and parse character data asynchronously.

#### **Code Breakdown**
```swift
struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
}

func fetchCharacters() async throws -> [Character] {
    let urlString = "https://rickandmortyapi.com/api/character"
    guard let url = URL(string: urlString) else { throw URLError(.badURL) }

    let (data, _) = try await URLSession.shared.data(from: url)
    let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
    return characterResponse.results
}
```

###ContentView.swift (Displays Data)
- Calls `fetchCharacters()` and displays the list of characters in a SwiftUI view.
- Uses `@State` to manage fetched data.

#### **Code Breakdown**
```swift
import SwiftUI

struct ContentView: View {
    @State private var characters: [Character] = []

    var body: some View {
        NavigationView {
            List(characters) { character in
                HStack {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.headline)
                        Text(character.status)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Rick and Morty Characters")
            .task {
                do {
                    characters = try await fetchCharacters()
                } catch {
                    print("Error fetching characters: \(error)")
                }
            }
        }
    }
}
```

## How They Are Connected

1. **`ContentView.swift` calls `fetchCharacters()`** when the view loads.
2. **`fetchCharacters()` (from `API.swift`) makes an API request** and decodes the JSON response.
3. **The fetched data is stored in `characters`** and displayed in a list with images and names.








