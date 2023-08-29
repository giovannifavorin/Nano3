//
//  CloudKitView.swift
//  Nano3
//
//  Created by Gabriel Eirado on 24/08/23.
//

import SwiftUI

struct CloudKitView: View {
    @StateObject  var manager = CloudKitVM()
    var body: some View {
            List{
                ForEach(manager.fetchedItems, id: \.self){ items in
                    Text(items)
                }
            }.refreshable {
                manager.fetchItems()
            }
        
    }
}
struct CloudKitView_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitView()
    }
}
