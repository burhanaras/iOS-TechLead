//
//  ReminderListviewController+Datasource.swift
//  Today
//
//  Created by Burhan Aras on 2.01.2023.
//

import Foundation
import UIKit

extension ReminderListViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snaphhot = NSDiffableDataSourceSnapshot<Int, String>

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        contentConfiguration.image = UIImage(systemName: "qrcode")
        cell.contentConfiguration = contentConfiguration
    }
}
