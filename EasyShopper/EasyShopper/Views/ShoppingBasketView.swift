//
//  ShoppingBasketView.swift
//  EasyShopper
//
//  Created by Anders Sommer Lassen on 25/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import SwiftUI

struct ShoppingBasketView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var shoppingBasket = ShoppingBasketViewModel()
    
    @State private var selectedBasketItem: BasketItemViewModel? = nil
    @State private var showSheet = false
    @State private var hasError = false
    @State private var showAlert = false
    
    private let alertMessage = "Confirm to clear all items in shopping basket"
    
    var body: some View {
        
        VStack(alignment:.leading, spacing:0) {
            
            HStack {
                
                Text("Shopping Basket")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    self.showSheet = true
                    
                }) {
                    
                    Image(systemName:"cart.badge.plus")
                        .imageScale(.medium)
                        .foregroundColor(Color.white)
                        .padding()
                }
            }.font(.system(size:22.0))
            
            Divider().background(Color.init(white:0.8))
            
            List {
                
                ForEach(self.shoppingBasket.basketItems)  { basketItem in
                    
                    BasketListRowView(basketItem: basketItem, clicked: {
                        self.selectedBasketItem = basketItem
                        self.showSheet = true
                    })
                    
                }
                
            }.background(Color.white)
            
            HStack {
                
                Text("Total price: \(shoppingBasket.totalPrice)")
                    .padding()
                
                Spacer()
                
                Button(action: { self.showAlert = true }) {
                    
                    Text("Clear")
                    
                    Image(systemName:"cart.badge.minus")
                        .imageScale(.medium)
                }
                .padding()
                .alertOKCancel(isPresented: $showAlert, message: alertMessage, OKAction: {
                    self.shoppingBasket.clearItems()
                })
                
            }.foregroundColor(Color.white).font(.system(size:20.0))
        }
        .background(ShoppingBasketView.shoppingBlue.edgesIgnoringSafeArea(.all))
        .sheet(isPresented:$showSheet, onDismiss:onDismissProductView) {
            if self.selectedBasketItem == nil {
                ProductListView(close:self.onCloseShowProducts, productList: ProductListViewModel(products: self.shoppingBasket.products))
            }
            else {
                ProductDetailsView(basketItem: self.selectedBasketItem!)
            }
        }
        .onAppear(perform: { self.shoppingBasket.getProducts() })
    }
    
    func onCloseShowProducts(added:[ProductModel], cancelled:Bool) {
        
        for product in added {
            shoppingBasket.addToBasket(item: product)
        }
    }
    
    func onDismissProductView() {
        showSheet = false
    }
    
    func onDismissDetailView() {
        self.selectedBasketItem = nil
    }
}

///
/// Constants
///
extension ShoppingBasketView {
    
    static private let shoppingBlue = Color.init(.sRGB, red:(24.0/255.0), green:(150.0/255.0), blue:(215.0/255.0))
}
