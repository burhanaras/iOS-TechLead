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

    private func loadJson() {
        if let path = Bundle.main.path(forResource: "JsonData", ofType: ".json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                productData = try jsonDecoder.decode(ProductModel.self, from: jsonData)
                print(productData?.response?.count ?? -1)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }

}

