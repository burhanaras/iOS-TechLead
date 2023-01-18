//
//  ViewController.swift
//  TableView - CollectionView
//
//  Created by Burhan Aras on 17.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var productData: ProductModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
    }

    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func loadJson() {
        if let path = Bundle.main.path(forResource: "JsonData", ofType: ".json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                productData = try jsonDecoder.decode(ProductModel.self, from: jsonData)            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productData?.response?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as? ProductsTableViewCell else {
            return UITableViewCell()
        }
        cell.productList = self.productData?.response?[indexPath.row]
        return cell
    }
}
