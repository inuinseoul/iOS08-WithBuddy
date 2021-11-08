//
//  CalendarViewController.swift
//  WithBuddy
//
//  Created by 박정아 on 2021/11/01.
//

import UIKit

class CalendarViewController: UIViewController, CalendarCellSelectable {
    static let identifer = "CalendarViewController"
    private let headerView = HeaderView()
    private let calendarView = UIView()
    private let wbcalendar = WBCalendarView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let tmpViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        self.wbcalendar.delegate = self
        self.configureScrollView()
        self.configureContentView()
        self.configureHeaderView()
        self.configureCalendarView()
        self.configurCalendar()
    }
    
    private func configureScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    private func configureContentView() {
        self.scrollView.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
//            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        ])
    }
    
    private func configureHeaderView() {
        self.contentView.addSubview(headerView)
        self.headerView.backgroundColor = .systemBackground
        self.headerView.layer.cornerRadius = 10
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 80),
            self.headerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.headerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureCalendarView() {
        self.contentView.addSubview(calendarView)
        self.calendarView.backgroundColor = .systemBackground
        self.calendarView.layer.cornerRadius = 10
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.calendarView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 10),
            self.calendarView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.calendarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.calendarView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.calendarView.heightAnchor.constraint(equalToConstant: 530)
        ])
    }
    
    private func configurCalendar() {
        self.calendarView.addSubview(wbcalendar)
        self.wbcalendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.wbcalendar.leadingAnchor.constraint(equalTo: self.calendarView.leadingAnchor, constant: 15),
            self.wbcalendar.trailingAnchor.constraint(equalTo: self.calendarView.trailingAnchor, constant: -15),
            self.wbcalendar.topAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: 15),
            self.wbcalendar.bottomAnchor.constraint(equalTo: self.calendarView.bottomAnchor, constant: -15)
        ])
    }
    
    func presentCellDetail() {
        let CalendarDetailViewController = CalendarDetailViewController()
        let nav = UINavigationController(rootViewController: CalendarDetailViewController)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(nav, animated: true, completion: nil)
    }
}
