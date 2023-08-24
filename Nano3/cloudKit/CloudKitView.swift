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
                Text(manager.isSignedIn.description.uppercased())
                Text(manager.signInError)
                Text("Name: \(manager.userName)")
                Text(manager.permissionStatus.description)
            }
        }
    }
}

struct CloudKitView_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitView()
    }
}
