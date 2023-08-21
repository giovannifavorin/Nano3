//
//  FrasesView.swift
//  Nano3
//
//  Created by Arthur Dos Reis on 21/08/23.
//

import SwiftUI

struct FrasesView: View {
    
    @StateObject var ViewModel = APIViewModel() //Chamada da API
    @StateObject var persistence : PersistenceController = PersistenceController()

    init(){
        ViewModel.fetch()
    }
    
    var body: some View {
        VStack {
            
            List {
                ForEach(ViewModel.quotes, id: \.self) { quote in
                    HStack {
                        Text("\(quote.a)\n\(quote.q)")
                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
            Button {
                ViewModel.fetch()
            } label: {
                Text("Gerar Nova Frase")
            }
            .buttonStyle(.borderedProminent)
            .padding(20)
        }
        .navigationTitle("Frases")
        .refreshable {
            ViewModel.fetch()
        }
    }
}

struct FrasesView_Previews: PreviewProvider {
    static var previews: some View {
        FrasesView()
    }
}
