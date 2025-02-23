import Foundation

class FeedManager {
    
    static let shared = FeedManager()
    
    private var feedPosts: [Post] = []
    
    var onFeedUpdated: (([Post]) -> Void)?

    private init() {}

    func fetchPosts() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            
            let post1 = Post(
                id: UUID(),
                authorId: UUID(),
                content: "Hello, world!",
                likes: 10,
                imageUrl: URL(string: "https://picsum.photos/200/300") 
            )
            
            let post2 = Post(
                id: UUID(),
                authorId: UUID(),
                content: "Swift is awesome! 🚀",
                likes: 25,
                imageUrl: nil
            )
            
            self.feedPosts = [post2, post1]
            
            DispatchQueue.main.async {
                self.onFeedUpdated?(self.feedPosts)
            }
        }
    }

    func addPost(content: String) {
        let newPost = Post(id: UUID(), authorId: UUID(), content: content, likes: 0)
        feedPosts.insert(newPost, at: 0)
        onFeedUpdated?(feedPosts)
    }
    
    func likePost(postId: UUID) {
        if let index = feedPosts.firstIndex(where: { $0.id == postId }) {
            feedPosts[index].likes += 1
            onFeedUpdated?(feedPosts)
        }
    }
}
    
