//
//  ContentView.swift
//  FavFood
//
//  Created by Giovanni Favorin de Melo on 14/08/23.
//

import SwiftUI

//struct APIResponse: Hashable, Codable {
//    let q: String
//    let a: String
//} Struct da API

struct ContentView: View {
    @StateObject var manager = GitHubUseVM() //Chamada da API
    
    var body: some View {
        VStack {
            Button {
//                ViewModel.fetch()
            } label: {
                Text("Button")
            }
            NavigationView {
//                List {
//                    ForEach(ViewModel.quotes, id: \.self) { quote in
//                        HStack {
//                            Text("\(quote.a)\n\(quote.q)")
//
//                            Spacer()
//                        }
//                    }
//                }
//                .navigationTitle("Frases")
//                .onAppear {
////                    ViewModel.fetch()
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
