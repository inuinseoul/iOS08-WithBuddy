//
//  RegisterViewController.swift
//  WithBuddy
//
//  Created by 김두연 on 2021/11/01.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var dateView = DateView()
    private lazy var placeView = PlaceView()
    private lazy var typeView = PurposeSelectView()
    private lazy var buddyView = BuddySelectView()
    private lazy var memoView = MemoView()
    private lazy var pictureView = PictureView()
    
    private lazy var datePicker = UIDatePicker()
    private lazy var dateToolBar = UIToolbar()
    
    private lazy var addButton: UIBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.addGathering))
    
    private var registerViewModel = RegisterViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.configure()
        self.registerViewModel.didStartDatePicked(Date())
        self.navigationItem.rightBarButtonItem = self.addButton
    }
    
    private func bind() {
        self.dataBind()
        self.signalBind()
    }
    
    private func dataBind() {
        self.registerViewModel.$startDateString
            .receive(on: DispatchQueue.main)
            .sink { [weak self] date in
                self?.dateView.changeDateLebelText(date)
            }
            .store(in: &self.cancellables)
        
        self.registerViewModel.$purposeList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] purposeList in
                self?.typeView.changeSelectedType(purposeList)
            }
            .store(in: &self.cancellables)
        
        self.registerViewModel.$buddyList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] buddyList in
                self?.buddyView.buddyListReload(buddyList)
            }
            .store(in: &self.cancellables)
        
        self.registerViewModel.$pictures
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pictures in
                self?.pictureView.pictureListReload(pictures)
            }
            .store(in: &self.cancellables)
    }
    
    private func signalBind() {
        self.registerViewModel.registerDoneSignal
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] in
                self?.alertSuccess()
            }
            .store(in: &self.cancellables)
        
        self.registerViewModel.registerFailSignal
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] result in
                self?.alertError(result)
            }
            .store(in: &self.cancellables)
        
        self.registerViewModel.addBuddySignal
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] buddyList in
                let buddyChoiceViewController = BuddyChoiceViewController()
                buddyChoiceViewController.delegate = self
                buddyChoiceViewController.configureBuddyList(by: buddyList)
                self?.navigationController?.pushViewController(buddyChoiceViewController, animated: true)
            }
            .store(in: &self.cancellables)
    }
    
    private func configure() {
        self.view.backgroundColor = UIColor(named: "BackgroundPurple")
        
        self.configureScrollView()
        self.configureContentView()
        self.configureStartDateView()
        self.configurePlaceView()
        self.configureTypeView()
        self.configureBuddyView()
        self.configureMemoView()
        self.configurePictureView()
    }
    
    private func configureScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func configureContentView() {
        self.scrollView.addSubview(self.contentView)
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapEmptySpace)))
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
 
    private func configureStartDateView() {
        self.contentView.addSubview(self.dateView)
        self.dateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.dateView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.dateView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20)
        ])
        self.dateView.delegate = self
    }
    
    private func configurePlaceView() {
        self.contentView.addSubview(self.placeView)
        self.placeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.placeView.topAnchor.constraint(equalTo: self.dateView.bottomAnchor, constant: 40),
            self.placeView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.placeView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20)
        ])
        self.placeView.delegate = self
    }
    
    private func configureTypeView() {
        self.contentView.addSubview(self.typeView)
        self.typeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.typeView.topAnchor.constraint(equalTo: self.placeView.bottomAnchor, constant: 40),
            self.typeView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.typeView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20)
        ])
        self.typeView.delegate = self
    }
    
    private func configureBuddyView() {
        self.contentView.addSubview(self.buddyView)
        self.buddyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.buddyView.topAnchor.constraint(equalTo: self.typeView.bottomAnchor, constant: 40),
            self.buddyView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.buddyView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20)
        ])
        self.buddyView.delegate = self
    }
    
    private func configureMemoView() {
        self.contentView.addSubview(self.memoView)
        self.memoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.memoView.topAnchor.constraint(equalTo: self.buddyView.bottomAnchor, constant: 40),
            self.memoView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.memoView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20)
        ])
        self.memoView.delegate = self
    }
    
    private func configurePictureView() {
        self.contentView.addSubview(self.pictureView)
        self.pictureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pictureView.topAnchor.constraint(equalTo: self.memoView.bottomAnchor, constant: 40),
            self.pictureView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.pictureView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            self.pictureView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        self.pictureView.delegate = self
    }
    
    private func alertSuccess() {
        let alert = UIAlertController(title: "등록 완료", message: "모임 등록이 완료되었습니다!", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func alertError(_ error: RegisterError) {
        let alert = UIAlertController(title: "등록 실패", message: error.errorDescription, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func onStartDoneTouched() {
        self.registerViewModel.didStartDatePicked(self.datePicker.date)
        self.datePicker.removeFromSuperview()
        self.dateToolBar.removeFromSuperview()
    }

    @objc private func tapEmptySpace(){
        self.view.endEditing(true)
    }
    
    @objc private func addGathering() {
        self.registerViewModel.didDoneTouched()
    }
}

extension RegisterViewController: DateViewDelegate {
    
    func dateButtonDidTouched() {
        self.configureDatePicker()
        self.configureStartDateToolBar()
    }
    
    private func configureDatePicker() {
        self.view.addSubview(self.datePicker)
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker.autoresizingMask = .flexibleWidth
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .inline
        self.datePicker.locale = Locale(identifier: "ko-KR")
        self.datePicker.timeZone = .autoupdatingCurrent
        self.datePicker.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.datePicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.datePicker.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.datePicker.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.datePicker.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureStartDateToolBar() {
        self.view.addSubview(self.dateToolBar)
        self.dateToolBar.translatesAutoresizingMaskIntoConstraints = false
        self.dateToolBar.barStyle = .default
        self.dateToolBar.items = [UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onStartDoneTouched))]
        self.dateToolBar.sizeToFit()
        
        NSLayoutConstraint.activate([
            self.dateToolBar.bottomAnchor.constraint(equalTo: self.datePicker.topAnchor),
            self.dateToolBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.dateToolBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.dateToolBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let url = info[UIImagePickerController.InfoKey.imageURL] as? URL else {
            return
        }
        self.registerViewModel.didPicturePicked(url)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterViewController: PlaceViewDelegate {
    func placeTextFieldDidReturn(_ place: String) {
        self.registerViewModel.didPlaceFinished(place)
    }
}

extension RegisterViewController: PurposeViewDelegate {
    func purposeDidSelected(_ idx: Int) {
        self.registerViewModel.didTypeTouched(idx)
    }
}

extension RegisterViewController: BuddyViewDelegate {
    func buddyDidDeleted(_ idx: Int) {
        self.registerViewModel.didBuddyDeleteTouched(in: idx)
    }
    
    func buddyAddDidTouched() {
        self.registerViewModel.addBuddyDidTouched()
    }
}

extension RegisterViewController: MemoViewDelegate {
    func memoTextFieldDidReturn(_ text: String) {
        self.registerViewModel.didMemoFinished(text)
    }
}

extension RegisterViewController: PictureViewDelegate {
    func pictureDidDeleted(_ idx: Int) {
        self.registerViewModel.didPictureDeleteTouched(in: idx)
    }
    
    func pictureButtonDidTouched() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
}

extension RegisterViewController: BuddyChoiceDelegate {
    func buddySelectingDidCompleted(_ buddyList: [Buddy]) {
        self.registerViewModel.buddyDidUpdated(buddyList)
    }
}
