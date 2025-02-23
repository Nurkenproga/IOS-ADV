import Foundation

struct Post: Identifiable {
    let id: UUID
    let authorId: UUID
    var content: String
    var likes: Int
    var imageUrl: URL?
}
