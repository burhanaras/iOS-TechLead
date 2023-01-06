//
//  ReminderVC.swift
//  Today
//
//  Created by Burhan Aras on 4.01.2023.
//

import Foundation
import UIKit

class ReminderVC: UICollectionViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Row>

    private var datasource: DataSource!

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

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        datasource = DataSource(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        updateSnapshot()
    }
}

// MARK: - Private methods

private extension ReminderVC {

    func text(for row: Row) -> String?{
        switch row {
        case .viewDate: return reminder.dueDate.dayAndTimeText
        case .viewNotes: return reminder.notes
        case .viewTime: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .viewTitle: return reminder.title
        }
    }

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .todayPrimaryTint
    }

    func updateSnapshot() {
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems([.viewTitle, .viewDate, .viewTime, .viewNotes], toSection: 0)
        datasource.apply(snapshot)
    }
}
