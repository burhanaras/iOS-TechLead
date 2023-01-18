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

    var productList: ProductList? {
        didSet{
            categoryName.text = productList?.categoryName
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    fileprivate func configureUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onClickSeeAll(_ sender: Any) {
    }
}

extension ProductsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList?.products?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.productName.text = productList?.products?[indexPath.row].name
        cell.image.image = UIImage(named: productList?.products?[indexPath.row].imageName ?? "")
        cell.configure()
        return cell
    }
}
