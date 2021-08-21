//
//  PlayerList.swift
//  ScoreBoard
//
//  Created by Edu Calero on 17/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

struct PlayerList: View {
    
    @ObservedObject var viewModel = PlayerListViewModel()
    @State var isSearching: Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                List(self.viewModel.players) { player in
                    VStack{
                        HStack{
                            Image(uiImage: )
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .scaledToFill()
                            Text(player.displayName?.capitalized ?? "")
                        }
                    }
                 }
                .navigationBarTitle("Players")
                .navigationBarItems(
                    trailing: Button("Search",
                                     action: { self.isSearching.toggle() }
                    )
                )
                
                Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isSearching ? 0.60 : 0)
                    .animation(Animation.spring())
                VStack {
                    SearchBar(text: $viewModel.playerName, isSearching: $isSearching)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .opacity(isSearching ? 1 : 0)
                        //.offset(x: isSearching ? 0 : -UIScreen.main.bounds.width)
                        .animation(Animation.spring())
                    Spacer()
                }
            }
        }
         .onAppear {
            self.viewModel.getPlayerList()
        }

    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
        PlayerList()
    }
}



struct SearchBar: View {
    
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
            
            HStack{
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20,
                           height: 20)
                    .padding(.leading, 10)
                
                TextField("Escribe aqui...",
                          text: $text)
                    {
                        self.isSearching.toggle()
                    }
                    .padding(7)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(5)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 7)
                    .padding(.trailing, 7)
                    .keyboardType(.alphabet)
                    
                
            }
    .background(
        Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        )
    }
}
