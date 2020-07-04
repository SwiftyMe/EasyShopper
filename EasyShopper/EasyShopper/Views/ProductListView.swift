//
//  ProductListView.swift
//  EasyShopper
//
//  Created by Anders Sommer Lassen on 25/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import SwiftUI
import Combine

struct ProductListView: View {
    
    var close: ([ProductModel],Bool) -> Void
    
    @ObservedObject var productList: ProductListViewModel

    @Environment(\.presentationMode) private var presentationMode
    
    @State private var hasError = false
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing:0) {
            
            HStack {
                
                Button("Cancel", action: {
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                    self.close([],true)
                })
                
                Spacer()
                
                Text("Product List")
                
                Spacer()
                
                Button("Save",action: {
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                    let selected = self.productList.products.filter({$0.addedToBasket}).map( { $0.modelObject } )
                    
                    self.close(selected,false)
                })
            }
            .padding()
            .background(Color.init(white:0.90))

            Divider().background(Color.init(white:0.9))
                .padding(0)
            
            List(self.productList.products, id:\.id) { product in
                    
                ProductListRowView(product:product)
            }
            .background(Color.white)
                
            Spacer()
        }
        .background(Color.white)
    }
}


