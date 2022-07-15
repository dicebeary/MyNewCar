import Foundation

struct MakeCellModel {
    let id: String
    let name: String
    let imageUrl: URL?
    let isFavorite: Bool
    
    init(_ make: Make, isFavorite: Bool) {
        self.id = make.id
        self.name = make.name
        self.imageUrl = URL(string: make.imageUrl)
        self.isFavorite = isFavorite
    }
}
