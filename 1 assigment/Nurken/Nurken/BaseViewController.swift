import UIKit

class  BaseViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheme()
        NotificationCenter.default.addObserver(forName: Notification.Name("ThemeChanged"), object: nil, queue: .main) { _ in
            self.updateTheme()
        }
    }
    func updateTheme() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }
}
