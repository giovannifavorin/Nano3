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
            List(ViewModel.quotes, id: \.self) {quote in
                VStack{
                    HStack {
                        Text("\(quote.a)")
                            .font(.headline)
                        Spacer()
                        Button {
                            persistence.addQuote(quote: quote)
                        } label: {
                            Image(systemName: "folder")
                        }
                    }
                    Text("\(quote.q)")
                        .multilineTextAlignment(.leading)
                
                }

            }
            Button {
                ViewModel.fetch()
            } label: {
                Text("Gerar Nova Frase")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 20)
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
