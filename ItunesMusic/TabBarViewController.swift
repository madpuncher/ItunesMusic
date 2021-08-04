//
//  TabBarViewController.swift
//  ItunesMusic
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 04.08.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .systemPink
        
        viewControllers = [
            setupController(viewController: SearchViewController(), image: #imageLiteral(resourceName: "Search"), title: "Search"),
            setupController(viewController: LibraryViewController(), image: #imageLiteral(resourceName: "Library"), title: "Library")
        ]
    }
    
    private func setupController(viewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: viewController)

        navigationVC.navigationBar.prefersLargeTitles = true
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        viewController.navigationItem.title = title
        
        return navigationVC
    }
}
