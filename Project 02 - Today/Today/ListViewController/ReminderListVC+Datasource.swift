//
//  ReminderListviewController+Datasource.swift
//  Today
//
//  Created by Burhan Aras on 2.01.2023.
//

import Foundation
import UIKit

extension ReminderListVC {

    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snaphhot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>

    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }

    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }

    func updateSnapshot(reloading ids: [Reminder.ID] = []) {
        var snapshot = Snaphhot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        let reminder = reminder(for: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration

        var donebuttonConfiguration = doneButtonConfiguration(for: reminder)
        donebuttonConfiguration.tintColor = .todayListCellDoneButtonTint

        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
        cell.accessories = [.customView(configuration: donebuttonConfiguration), .disclosureIndicator(displayed: .always)]
        cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
    }

    func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)

        let button = ReminderDoneButton()
        button.id = reminder.id
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }

    func reminder(for id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(id: id)
        return reminders[index]
    }

    func update(_ reminder: Reminder, with id: Reminder.ID) {
        let index = reminders.indexOfReminder(id: id)
        reminders[index] = reminder
    }

    func completeReminder(with id: Reminder.ID) {
        var newReminder = reminder(for: id)
        newReminder.isComplete.toggle()
        update(newReminder, with: id)
        updateSnapshot(reloading: [id])
    }

    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Reminder done button accessibility label")
        return UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(with: reminder.id)
            return true
        }
    }
}
