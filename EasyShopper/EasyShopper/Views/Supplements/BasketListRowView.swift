//
//  BasketListRowView.swift
//  EasyShopper
//
//  Created by Anders Sommer Lassen on 25/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import SwiftUI

///
/// List row view showing an item in the basket
///
struct BasketListRowView: View {
    
    @ObservedObject var basketItem: BasketItemViewModel
    
    var clicked: () -> Void
    
    var body: some View {
        
        HStack(spacing:5) {

            Image(uiImage: basketItem.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(5)

            VStack(alignment:.leading, spacing:2) {

                Text(basketItem.name).bold().font(.system(size:14.0))
                
                Text("Item(s): \(basketItem.count)")
                    .font(.system(size:13.0))

                Text("Total Price: \(basketItem.totalPrice)")
                    .font(.system(size:13.0))
            }
            
            Spacer()
            
            //FIXME: Hit area of buttons are offset quite a lot
            
            HStack(alignment:.bottom, spacing:15) {

                Button(action: { self.basketItem.increment() }) {
                    Image(systemName:"plus.circle")
                        .imageScale(.large)
                }
                
                Button(action: { self.basketItem.decrement() }) {
                    Image(systemName:"minus.circle")
                        .imageScale(.large)
                }
            }
            .font(.system(size:18.0))
            .buttonStyle(BorderlessButtonStyle())
        }
        .frame(height: 80)
    }
}
