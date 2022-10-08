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
            
            StatsPath()
                .tabItem {
                    Image("tvTab")
                    Text("GP")
                }
            
            ChampionshipPath()
                .tabItem {
                    Image("champTab")
                    Text("Championship")
                }
            
            NavigationView {
                GrandPrixView()
                    .tabItem {
                        Image(systemName: "gpTab")
                        Text("Stats")
                    }
            }
           
            
            ChampionshipPath()
                .tabItem {
                    Image(systemName: "pilotTab")
                    Text("Championship")
                }
            
            ChampionshipPath()
                .tabItem {
                    Image(systemName: "configTab")
                    Text("Championship")
                }
        }
    }
        
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



struct StatsPath: View {
    var body: some View {
        Text("Statistics")
            
    }
}




