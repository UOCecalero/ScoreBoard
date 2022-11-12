//
//  MainView.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 1/8/21.
//  Copyright © 2021 Iflet.tech. All rights reserved.
//

import SwiftUI



struct MainView: View {
    
    
    @State var tab = 2
    
    var body: some View {
        ZStack {
            Color(.backgorundColor)
                .ignoresSafeArea()
            
            TabView(selection: $tab){
                
                StatsPath()
                    .tabItem {
                        Image("tvTab")
                    }.tag(0)
                
                ChampionshipPath()
                    .tabItem {
                        Image("champTab")
                    }.tag(1)
                
                
                GrandPrixPath()
                    .badge(2)
                    .tabItem {
                        Image("gpTab")
                    }.tag(2)
                
                
                ChampionshipPath()
                    .tabItem {
                        Image("pilotTab")
                    }.tag(3)
                
                ChampionshipPath()
                    .tabItem {
                        Image("configTab")
                    }.tag(4)
            }
            .foregroundColor(.white)
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




