import SwiftUI

struct ContentView: View {
    @State private var characters: [Character] = []  // Ensure Swift can find Character

    var body: some View {
        ScrollView {
            VStack {
                ForEach(characters) { character in
                    HStack {
                        Text(character.name)
                            .font(.headline)
                        Text(character.species)
                        Text("\(character.id)")
                        Text(character.status)
                            .foregroundColor(character.status == "Alive" ? .green : .red)
                        Text(character.species)
                        AsyncImage(url: URL(string: character.image))
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())

                    }
                    .padding()
                }
            }
        }
        .task {
            do {
                characters = try await fetchCharacters()
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

