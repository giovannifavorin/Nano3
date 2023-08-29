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
        ZStack {
            Color(red: 0.16, green: 0.18, blue: 0.31) // marca registrada Eirado
                .ignoresSafeArea(.all)
            VStack {
                
//                Text("\(manager.)")
                TextField("Add something here", text: $manager.text )
                    
                   
                    .frame(width: 300,height: 50)
                    .padding(.leading)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(20)
                Button{
                    
                }label: {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 50)
                        .cornerRadius(20)
                        .overlay {
                            Text("Add")
                                .foregroundColor(.white)
                        }
                }
                List{
                    ForEach(manager.fetchedItems, id: \.self){ items in
                        Text(items)
                    }
                }
            }
        }
    }
}

struct CloudKitView_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitView()
    }
}
