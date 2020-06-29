//
//  ShoppingBasket.swift
//  EasyShopper
//
//  Created by Morten Bek Ditlevsen on 11/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation

struct ShoppingBasketItemModel: Decodable {

    var product: ProductModel
    var count: Int
}

