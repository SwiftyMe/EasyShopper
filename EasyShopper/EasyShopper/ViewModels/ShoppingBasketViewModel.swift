//
//  ShoppingBasketViewModel.swift
//  EasyShopper
//
//  Created by Anders Sommer Lassen on 25/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation
import Combine

protocol ShoppingBasketUpdate {

    func updateTotalPrice()
}

///
/// View model class for shopping basket
///
class ShoppingBasketViewModel: ObservableObject {
    
    @Published var basketItems = [BasketItemViewModel]()
    
    @Published var error: String?
    @Published var totalPrice = 0
    
    var products: [ProductViewModel] {
        
        var list: [ProductViewModel] = []
        
        for (_,product) in productDictionary! {
            list.append(ProductViewModel(product:product))
        }
        
        return list
    }
    
    private var productDictionary: [String:ProductModel]?
    
    private var backend = APIService.ServiceProducts
    private var cancellable: AnyCancellable?
    
    func addToBasket(item: ProductModel) {
        
        if let found = basketItems.first(where: { String($0.id) == item.id }) {
            
            found.increment()
        }
        else {
            
            let itemModel = ShoppingBasketItemModel(product:item,count:1)
            
            basketItems.append(BasketItemViewModel(model:itemModel, basket:self))
            
            updateTotalPrice()
        }
    }
    
    func clearItems() {
        
        basketItems.removeAll()
        
        updateTotalPrice()
    }
    
    func getProducts() {
        
        error = nil
        
        cancellable?.cancel()

        cancellable = backend.products()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        self.error = error.localizedDescription
                    case .finished:
                        break
            }},receiveValue:{ value in
                
                self.productDictionary = value
            })
    }
}

///
///
///
extension ShoppingBasketViewModel: ShoppingBasketUpdate {
    
    func updateTotalPrice() {
        
        totalPrice = basketItems.reduce(0) { $0 + $1.totalPrice }
    }
}
