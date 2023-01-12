//
//  ReminderVC.swift
//  Today
//
//  Created by Burhan Aras on 4.01.2023.
//

import Foundation
import UIKit

class ReminderVC: UICollectionViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Row>

    private var dataSource: DataSource!

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
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        navigationItem.rightBarButtonItem = editButtonItem
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        updateSnapshotForViewing()
        collectionView.dataSource = dataSource
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            updateSnapshotForEditing()
        } else {
            updateSnapshotForViewing()
        }
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
        default:
            return nil
        }
    }

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let title)):
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = title
            cell.contentConfiguration = contentConfiguration
        case (.view, _):
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = text(for: row)
            contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
            contentConfiguration.image = row.image
            cell.contentConfiguration = contentConfiguration
        default:
            fatalError("Unexpected  combination")
        }
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .todayPrimaryTint
    }

    func updateSnapshotForViewing() {
        var snapshot = SnapShot()
        snapshot.appendSections([.view])
        snapshot.appendItems([.header(""), .viewTitle, .viewDate, .viewTime, .viewNotes], toSection: .view)
        dataSource.apply(snapshot)
    }

    func updateSnapshotForEditing() {
        var snapshot = SnapShot()
        snapshot.appendSections([.title, .date, .notes])
        snapshot.appendItems([.header(Section.title.name)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        dataSource.apply(snapshot)
    }

    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
