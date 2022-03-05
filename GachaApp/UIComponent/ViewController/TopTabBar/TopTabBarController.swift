//
//  TopTabBarController.swift
//  GachaApp
//
//  Created by 化田晃平 on 2022/03/05.
//

import UIKit

final class TopTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configViewControllers()

        // Do any additional setup after loading the view.
    }

    private func configViewControllers() {
        tabBar.tintColor = .blue
        tabBar.backgroundColor = .systemGray6

        let gachaListVC = templeteNavigationController(title: L10n.gachaList, systemName: "list.bullet", rootViewController: GachaListViewController())

        let mypageVC = templeteNavigationController(title: L10n.mypage, systemName: "person.fill", rootViewController: MypageViewController())

        viewControllers = [gachaListVC, mypageVC]
    }

    private func templeteNavigationController(title: String, systemName: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(systemName: systemName)
        return nav
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
