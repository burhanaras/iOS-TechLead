//
//  ReminderVC+Section.swift
//  Today
//
//  Created by Burhan Aras on 6.01.2023.
//

import Foundation

extension ReminderVC {

    enum Section:Int, Hashable {

        case view
        case title
        case date
        case notes

        var name: String {
            switch self {
            case .view:
                return ""
            case .title:
                return NSLocalizedString("Title", comment: "Title section name")
            case .date:
                return NSLocalizedString("Date", comment: "Date section name")
            case .notes:
                return NSLocalizedString("Notes", comment: "Notes section name")
            }
        }
    }


}
