//
//  FavoritosDetailed.swift
//  Nano3
//
//  Created by Daniel Ishida on 23/08/23.
//

import SwiftUI

struct FavoritosDetailedComponent: View {
    var ViewModel = APIViewModel()
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
//                    let post = ViewModel.post(text: frase+"-"+autor)
//                    
//                    link = post
//                    print(post)
                }
              
               
                
                
                
                
            }label: {
                Text("Post")
            }
        }
    }
}

struct FavoritosDetailedComponent_Previews: PreviewProvider {
    static var previews: some View {
        FavoritosDetailedComponent(autor: "Andrew Tate", frase: "Breath air!")
    }
}
