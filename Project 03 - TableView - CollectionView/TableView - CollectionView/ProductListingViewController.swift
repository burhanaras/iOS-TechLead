//
//  ProductListingViewController.swift
//  TableView - CollectionView
//
//  Created by Burhan Aras on 22.01.2023.
//

import Foundation
import UIKit

class ProductListingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var productListing: ProductList?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = productListing?.categoryName ?? ""
        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension ProductListingViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListing?.products?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTableViewCell") as? ProductDetailTableViewCell else {
            return UITableViewCell()
        }
        if let product = productListing?.products?[indexPath.row] {
            cell.configure(product: product)
        }
        return cell
    }
}
