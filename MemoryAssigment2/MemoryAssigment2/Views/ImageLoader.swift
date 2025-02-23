import UIKit

class ImageLoader {
    
    private var task: URLSessionDataTask?
    
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        task?.cancel()
        
        task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task?.resume()
    }
}
