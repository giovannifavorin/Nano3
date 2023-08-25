//
//  TestStatusView.swift
//  Nano3
//
//  Created by Gabriel Eirado on 25/08/23.
//

import SwiftUI

struct TestStatusView: View {
    @StateObject  var manager = CloudKitVM()
    var body: some View {
        ZStack {
            Color(red: 0.16, green: 0.18, blue: 0.31) // marca registrada Eirado
                .ignoresSafeArea(.all)
            VStack {
                Text(manager.status)
            } 
        }
    }
}
struct TestStatusView_Previews: PreviewProvider {
    static var previews: some View {
        TestStatusView()
    }
}
