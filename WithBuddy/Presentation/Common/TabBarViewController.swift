//
//  TabbarViewController.swift
//  WithBuddy
//
//  Created by 김두연 on 2021/11/01.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private var registerButton = UIButton()
    private var prevIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "BackgroundPurple")
        self.tabBar.backgroundColor = .systemBackground
        
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configure() {
        self.configureTabBarItems()
        self.configureButton()
    }
    
    private func configureTabBarItems() {
        let calendar = CalendarViewController()
        let chart = ChartViewController()
        let register = RegisterViewController()
        let list = ListViewController()
        let setting = SettingViewController()
        self.configureTab(controller: calendar, title: "일정", photoName: "calendar")
        self.configureTab(controller: chart, title: "통계", photoName: "chart.bar.xaxis")
        self.configureTab(controller: list, title: "목록", photoName: "list.bullet.rectangle.fill")
        self.configureTab(controller: setting, title: "설정", photoName: "gearshape.fill")
        self.viewControllers = [calendar, chart, register, list, setting]
    }
    
    private func configureTab(controller: UIViewController, title: String, photoName: String) {
        let tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: photoName), selectedImage: UIImage(systemName: photoName))
        controller.tabBarItem = tabBarItem
    }
    
    private func configureButton() {
        let circleDiameter = self.tabBar.layer.bounds.height * 1.5
        var config = UIButton.Configuration.filled()
        var attText = AttributedString("모임등록")
        attText.font = UIFont.systemFont(ofSize: 10.0, weight: .medium)
        config.attributedTitle = attText
        config.imagePadding = 7
        config.image = UIImage(systemName: "person.3.fill")
        config.imagePlacement = .top
        config.cornerStyle = .capsule
        
        self.registerButton = UIButton(configuration: config, primaryAction: nil)
        self.registerButton.frame = CGRect(x: 0, y: 0, width: circleDiameter, height: circleDiameter)
        self.registerButton.titleLabel?.font = .systemFont(ofSize: 10)
        self.registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        
        self.view.addSubview(self.registerButton)
        self.registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.registerButton.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: -circleDiameter / 6),
            self.registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.registerButton.widthAnchor.constraint(equalToConstant: circleDiameter),
            self.registerButton.heightAnchor.constraint(equalToConstant: circleDiameter)
        ])
    }
    
    @objc private func registerAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
//    func presentDetail() {
//        let CalendarDetailViewController = CalendarDetailViewController()
//        let nav = UINavigationController(rootViewController: CalendarDetailViewController)
//        nav.modalPresentationStyle = .pageSheet
//        if let sheet = nav.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
//        }
//        present(nav, animated: true, completion: nil)
//    }
}
