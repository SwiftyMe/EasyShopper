//
//  BasketItemViewModel.swift
//  EasyShopper
//
//  Created by Anders Sommer Lassen on 25/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation
import Combine
import UIKit

///
/// View model class for a single employee
///
class BasketItemViewModel: ObservableObject, Identifiable {

    ///
    /// Conformance to Identifiable
    ///
    var id: Int {
        Int(model.product.id)!
    }
    
    @Published var image = UIImage(systemName:"wifi.slash")!
    
    var name: String {
        model.product.name
    }
    
    var description: String {
        model.product.description
    }
    
    @Published var count: Int
    @Published var price: Int
    @Published var totalPrice: Int
    
    private var model: ShoppingBasketItemModel
    private let basket: ShoppingBasketUpdate
    
    ///
    /// Init
    ///
    init(model: ShoppingBasketItemModel, basket: ShoppingBasketUpdate) {
        
        self.model = model
        self.basket = basket
        
        self.count = model.count
        self.price = model.product.retailPrice
        
        self.totalPrice = model.count * model.product.retailPrice
        
        DispatchQueue.global().async {
            
            if let url = URL(string:model.product.imageUrl), let data = try? Data(contentsOf:url), let image = UIImage(data:data) {
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
    func increment() {
        
        model.count = model.count + 1
        count = model.count
        
        totalPrice = count * price

        basket.updateTotalPrice()
    }
    
    func decrement() {
        
        guard model.count > 0 else { return }
        
        model.count = model.count - 1
        count = model.count

        totalPrice = count * price
        
        basket.updateTotalPrice()
    }
}
