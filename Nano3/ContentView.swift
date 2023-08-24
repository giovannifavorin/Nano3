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
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 200, height: 100)
                    .foregroundColor(.black)
                    .overlay{
                        Text(manager.quote?.a ?? "")
                            .foregroundColor(.white)
                    }
                    Spacer()
                Button {
                    manager.fetch()
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 100, height: 50)
                        .overlay{
                            Text("F").foregroundColor(.white)
                        }
                }
            }.task {
//                manager.fetch()
                manager.post()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
