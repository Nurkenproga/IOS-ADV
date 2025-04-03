import SwiftUI
import UIKit

final class HeroRouter {
    var rootViewController: UINavigationController?

    func showDetails(for id: Int) {
        let detailVC = makeDetailViewController(id: id)
        rootViewController?.pushViewController(detailVC, animated: true)
    }

    private func makeDetailViewController(id: Int) -> UIViewController {
        let heroService = HeroServiceImpl()
        let heroDetailViewModel = HeroDetailViewModel(heroId: id, service: heroService)
        let mockVC = UIHostingController(rootView: HeroDetailView(viewModel: heroDetailViewModel))
        return mockVC
    }
}
