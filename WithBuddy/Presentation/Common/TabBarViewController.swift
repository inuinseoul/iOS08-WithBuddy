//
//  TabbarViewController.swift
//  WithBuddy
//
//  Created by 김두연 on 2021/11/01.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private var prevIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "BackgroundPurple")
        self.delegate = self
        let calendar = configureTab(controller: CalendarViewController(), title: "일정", photoName: "calendar")
        let chart = configureTab(controller: ChartViewController(), title: "통계", photoName: "chart.bar.xaxis")
        let register = configureTab(controller: RegisterViewController(), title: "모임등록", photoName: "person.3.fill")
        let list = configureTab(controller: ListViewController(), title: "목록", photoName: "list.bullet.rectangle.fill")
        let setting = configureTab(controller: SettingViewController(), title: "설정", photoName: "gearshape.fill")
        self.viewControllers = [calendar, chart, register, list, setting]
        self.tabBarController?.tabBar.items?[2].isEnabled = false
    }
    
    private func configureTab(controller: UIViewController, title: String, photoName: String) -> UINavigationController {
        let tab = UINavigationController(rootViewController: controller)
        let tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: photoName), selectedImage: UIImage(systemName: photoName))
        tab.tabBarItem = tabBarItem
        return tab
    }
    
}

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        if index == 2 {
            self.navigationController?.pushViewController(RegisterViewController(), animated: true)
            tabBarController.selectedIndex = prevIndex
        } else {
            self.prevIndex = index
        }
    }
    
}
