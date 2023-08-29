//
//  ContentView.swift
//  FavFood
//
//  Created by Giovanni Favorin de Melo on 14/08/23.
//

import SwiftUI



struct ContentView: View {
    
    @State var selectTab:Int = 0
    
    var body: some View {
        TabView(selection: $selectTab){
            NavigationView{
                FrasesView()
            }
            .tabItem {
                Label("Frases", systemImage: "book")
            }
            .tag(selectTab)
            NavigationView{
                FavoritosView()
            }
            .tabItem{
                Label("Favoritos", systemImage: "star.fill")
            }
            .tag(selectTab)
            NavigationView{
                CloudKitView()
            }
            .tabItem{
                Label("iCloud", systemImage: "icloud.fill")
            }
            .tag(selectTab)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
