//
//  ContentView.swift
//  FavFood
//
//  Created by Giovanni Favorin de Melo on 14/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = ContentVM() //Chamada da API
    
    var body: some View {
        ZStack {
            Color(red: 0.16, green: 0.18, blue: 0.31) // marca registrada Eirado
                .ignoresSafeArea(.all)
            VStack {

                Text(manager.quote?.q ?? "aa")
                 .foregroundColor(.white)
   
                Button {
                    manager.fetch()
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 200, height: 100)
                }
            }.task {
                manager.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
