//
//  ReminderVC+Row.swift
//  Today
//
//  Created by Burhan Aras on 4.01.2023.
//

import Foundation
import UIKit

extension ReminderVC {

    enum Row: Hashable {

        case viewDate
        case viewNotes
        case viewTitle
        case viewTime

        var imageName: String? {
            switch self {
            case .viewDate: return "calendar.circle"
            case .viewNotes: return "square.and.pencil"
            case .viewTime: return "clock"
            default: return nil
            }
        }

        var image: UIImage! {
            guard let imageName = imageName else { return nil }
            let config = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName)
        }

        var textStyle: UIFont.TextStyle {
            switch self {
            case .viewTitle: return .headline
            default: return .subheadline
            }
        }
    }

}


