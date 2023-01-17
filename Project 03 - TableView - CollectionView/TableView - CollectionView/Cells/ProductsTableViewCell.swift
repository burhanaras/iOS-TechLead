//
//  ProductsTableViewCell.swift
//  TableView - CollectionView
//
//  Created by Burhan Aras on 17.01.2023.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickSeeAll(_ sender: Any) {
    }
}
