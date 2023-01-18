//
//  ProductsModel.swift
//  TableView - CollectionView
//
//  Created by Burhan Aras on 17.01.2023.
//

import Foundation

struct ProductModel: Codable {

    let response: [ProductList]?
}

struct ProductList: Codable {

    let categoryName: String?
    let products: [ProductDetails]?
}

struct ProductDetails: Codable {

    let name: String?
    let imageName: String?
    let price: String?
    let description: String?
}
