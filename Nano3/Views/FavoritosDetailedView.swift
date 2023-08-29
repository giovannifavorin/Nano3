//
//  FavoritosDetailed.swift
//  Nano3
//
//  Created by Daniel Ishida on 23/08/23.
//

import SwiftUI

struct FavoritosDetailedView: View {
    var ViewModel = APIViewModel()
    var cloudKitManager = CloudKitVM()
    var autor:String
    var frase:String
    @State var link:String?
    var body: some View {
        VStack{
            
            Text(frase)
            Text("-"+autor)
            
            Text(link ?? "Post on PasteBin to see the link here")
                .padding()
                .foregroundColor(.gray)
        }.toolbar {
            Button{
                Task{
                    ViewModel.postRequest(phrase: frase)
                }
            }label: {
                Text("Post")
            }
            
            Button{
                Task{
                    cloudKitManager.saveItems(phrase: frase)
                }
            }label: {
                Text("icloud")
            }

        }
    }
}

struct FavoritosDetailedComponent_Previews: PreviewProvider {
    static var previews: some View {
        FavoritosDetailedView(autor: "Andrew Tate", frase: "Breath air!")
    }
}
