//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Burhan Aras on 3.01.2023.
//

import UIKit

extension ReminderListViewController {

    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else {
            return
        }
        completeReminder(with: id)
    }
}
