//
//  ProductDetailsView.swift
//  EasyShopper
//
//  Created by Anders Sommer Lassen on 25/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import SwiftUI

///
/// Detail view for a selected product
///
struct ProductDetailsView: View {
    
    // TODO: Not implemented
    
    @ObservedObject var basketItem: BasketItemViewModel
    
    var body: some View {
        
        Text(basketItem.description)
    }
}

