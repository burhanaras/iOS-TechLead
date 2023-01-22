//
//  ProductDetailTableViewCell.swift
//  TableView - CollectionView
//
//  Created by Burhan Aras on 22.01.2023.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(product: ProductDetails) {
        productImage.image = UIImage(named: product.imageName ?? "")
        productName.text = product.name
        productDescription.text = product.description
        productPrice.text = product.price
    }
}
