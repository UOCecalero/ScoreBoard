//
//  GrandPrixPath.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 1/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import SwiftUI


extension RaceCDM {
    @objc
    var currentDate: Date? {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YY-mm-dd"
        return dateFormatter.date(from: self.date ?? "")
    }
}

struct GrandPrixView: View {
    
    @ObservedObject var viewModel = GrandPrixViewModel()
    

    @FetchRequest(sortDescriptors: [SortDescriptor(\RaceCDM.round, order: .forward)],
                  predicate: NSPredicate(format: "%K <= %@", #keyPath(RaceCDM.currentDate), NSDate()))
    
    
    var fetchRaces: FetchedResults<RaceCDM>
    
    var body: some View {
            VStack {
                ZStack {
                    Color.green
                        .frame(width: .infinity, height: 200)
                    Text(fetchRaces.first?.raceName ?? "")
                }
               
                
                
                Color.blue
                    .frame(width: .infinity, height: 300, alignment: .center)
            }
            
            .navigationBarTitle(Text("Grand Prix"))
    }
}

struct ChampionshipPath_GrandPrixPath: PreviewProvider {
    static var previews: some View {
        GrandPrixView()
    }
}
