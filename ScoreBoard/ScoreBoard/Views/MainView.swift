//
//  MainView.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 1/8/21.
//  Copyright © 2021 Iflet.tech. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView(){
            
            GrandPrixPath()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("GP")
                }
            
            ChampionshipPath()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Championship")
                }
            
            StatsPath()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Stats")
                }
          }
            
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct GrandPrixPath: View {
    var body: some View {
        NavigationView(){
            VStack {
                Color.green
                    .frame(width: .infinity, height: 200)
                
                Color.blue
                    .frame(width: .infinity, height: 300, alignment: .center)
            }
            
            .navigationBarTitle(Text("Grand Prix"))
        }
    }
}



struct StatsPath: View {
    var body: some View {
        Text("Statistics")
            
    }
}




