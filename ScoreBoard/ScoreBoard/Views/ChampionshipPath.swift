//
//  ChampionshipPath.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 2/8/21.
//  Copyright © 2021 Iflet.tech. All rights reserved.
//

import SwiftUI

struct ChampionshipPath: View {
    var body: some View {
        List {
            PilotRow()
            PilotRow()
            PilotRow()
            PilotRow()
            PilotRow()
            PilotRow()
           
        }
            
    }
}

struct ChampionshipPath_Previews: PreviewProvider {
    static var previews: some View {
        ChampionshipPath()
    }
}

struct PilotRow: View {
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("33")
                    Text("Max Versttapen")
                }
                Text("Red Bull Racing")
            }
            
            Text("44 Pts.")
            
        }
    }
}
