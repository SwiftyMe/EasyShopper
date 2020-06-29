//
//  ProductListRowView.swift
//  EasyShopper
//
//  Created by Anders Sommer Lassen on 25/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import SwiftUI

struct ProductListRowView: View {
    
    @ObservedObject var product: ProductViewModel
    
    var body: some View {
        
        HStack(spacing:5) {

            Image(uiImage: product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(5)

            Toggle(isOn:$product.addedToBasket) {
                VStack(alignment: .leading) {
                    Text(product.name)
                    Text("Price: \(product.price)")
                }
            }.font(.system(size:14.0))
        }
        .frame(height: 80)
    }
}
