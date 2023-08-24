//
//  FavoritosView.swift
//  Nano3
//
//  Created by Arthur Dos Reis on 21/08/23.
//

import SwiftUI

struct FavoritosView: View {
    
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Banco.entity(), sortDescriptors: [])
    private var acessoBanco:FetchedResults<Banco>
    @StateObject var persistence : PersistenceController = PersistenceController()
    
    var body: some View {
        VStack{
            
            List(){
                ForEach(persistence.savedQuotes){ banco in
                    VStack{
                        HStack {
                            Text("\(banco.autor ?? "Desconhecido")")
                                .font(.headline)
                            Spacer()
                        }
                        Text("\(banco.frase ?? "Desconhecida")")
                    }
                }
                .onDelete(perform: PersistenceController.shared.deleteObject)
            }
        }
        .task {
            persistence.fetchQuotes()
        }
        .navigationTitle("Favoritos")
    }
}

struct FavoritosView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritosView()
    }
}
