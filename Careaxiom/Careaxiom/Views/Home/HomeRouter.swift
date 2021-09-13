//
//  HomeRouter.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import UIKit

class HomeRouter: Router {
    // MARK: - Instance Properties

    var viewController: BaseViewController?

    // MARK: - Init Methods

    required init(viewController: HomeViewController) {
        self.viewController = viewController
    }

    // MARK: - Public Methods

    func presentVC(routeType: RouteType, navigationType: NavigationType = .overlay, animated _: Bool = true, completion _: (() -> Void)? = nil) {
        guard let routeType = routeType as? HomeRouteType else {
            return
        }

        var vc: UIViewController

        switch routeType {
        case .Home:
            let viewController = UIViewController.instantiate(HomeViewController.self, fromStoryboard: .Main)
            vc = viewController
        }

        switch navigationType {
        case .root:
            viewController?.navigationController?.viewControllers = [vc]
        default:
            return
        }
    }
}
