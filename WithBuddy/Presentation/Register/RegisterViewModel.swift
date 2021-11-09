//
//  RegisterViewModel.swift
//  WithBuddy
//
//  Created by Inwoo Park on 2021/11/03.
//

import Foundation

class RegisterViewModel {
    @Published private(set) var startDateString: String? = nil
    @Published private(set) var endDateString: String? = nil
    private var startDate: Date? = nil
    private var endDate: Date? = nil
    private var place: String? = nil
    @Published private(set) var purposeList: [Purpose] = PlaceType.allCases.map({ Purpose(type: $0, check: false) })
    private var checkedPurposeList: [Purpose] {
        return self.purposeList.filter( { $0.check })
    }
    @Published private(set) var buddyList: [Buddy] = []
    @Published private(set) var memo: String? = nil
    @Published private(set) var pictures: [URL] = []
    
    func didStartDatePicked(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        self.startDate = date
        self.startDateString = dateFormatter.string(from: date)
        
        if let endDate = self.endDate,
           endDate < date {
            self.endDate = self.startDate
            self.endDateString = self.startDateString
        }
    }
    
    func didEndDatePicked(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        if let startDate = startDate,
           startDate > date {
            self.endDate = self.startDate
            self.endDateString = self.startDateString
            return
        }
        self.endDate = date
        self.endDateString = dateFormatter.string(from: date)
    }
    
    func didPlaceFinished(_ place: String) {
        self.place = place
    }
    
    func didTypeTouched(_ idx: Int) {
        self.purposeList[idx].check.toggle()
    }
    
    func didBuddySelected(_ buddy: Buddy) {
        self.buddyList.insert(buddy, at: 0)
    }
    
    func didMemoFinished(_ memo: String) {
        self.memo = memo
    }
    
    func didPicturePicked(_ picture: URL) {
        self.pictures.insert(picture, at: 0)
    }
    
    func didPictureDeleteTouched(in idx: Int) {
        if idx < self.pictures.count {
            self.pictures.remove(at: idx)
        }
    }
    
    func didBuddyDeleteTouched(in idx: Int) {
        if idx < self.buddyList.count {
            self.buddyList.remove(at: idx)
        }
    }
}
