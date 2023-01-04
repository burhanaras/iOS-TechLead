//
//  ReminderVC.swift
//  Today
//
//  Created by Burhan Aras on 4.01.2023.
//

import Foundation
import UIKit

class ReminderVC: UICollectionViewController {

    var reminder: Reminder

    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfig.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfig)
        super.init(collectionViewLayout: listLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderVC using init(reminder:)")
    }

}
