//
//  CloudKitView.swift
//  Nano3
//
//  Created by Gabriel Eirado on 24/08/23.
//

import SwiftUI

struct CloudKitView: View {
    @StateObject  var manager = CloudKitViewModel()
    var body: some View {
        ZStack {
            Color(red: 0.16, green: 0.18, blue: 0.31) // marca registrada Eirado
                .ignoresSafeArea(.all)
            VStack {
                TextField("Add something here", text: $manager.text )
                    .frame(width: 500)
                    .foregroundColor(.white)
                Button{
                    
                }label: {
                    Text("Add")
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
