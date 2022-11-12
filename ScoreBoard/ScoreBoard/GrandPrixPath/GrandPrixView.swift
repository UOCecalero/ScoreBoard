//
//  GrandPrixPath.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 1/10/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import SwiftUI


struct GrandPrixView: View {
    
    @ObservedObject var viewModel = GrandPrixViewModel()

//    @FetchRequest(sortDescriptors: [SortDescriptor(\RaceCDM.round, order: .forward)],
//                  predicate: NSPredicate(format: "%K <= %@", #keyPath(RaceCDM.ISODateTimeString), Date().ISO8601Format()))
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\RaceCDM.round, order: .forward)])
    
    
    var fetchedRaces: FetchedResults<RaceCDM>
    
    var body: some View {
        
        ScrollView {
            ZStack {
                
                VStack {
                    
                    ZStack {
                        Color(.cardGradient2)
                        
                        VStack(alignment: .leading) {
                            
                            HStack {
                                Text(viewModel.race?.raceName?.uppercased() ?? "Grand Prix".uppercased())
                                    .foregroundColor(.white)
                                    .font(.custom("NicoMoji-Regular", fixedSize: 28))
                                Circle()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .foregroundColor(Color.red)
                            }
                           
                            Text(viewModel.race?.circuit?.circuitName?.uppercased() ?? "Circuit Name".uppercased())
                                .foregroundColor(.white)
                                .font(.custom("NicoMoji-Regular", fixedSize: 15))
                            
                            Text(viewModel.race?.circuit?.location?.locality?.capitalized ?? "City")
                                .foregroundColor(.white)
                                .font(.custom("NicoMoji-Regular", fixedSize: 15))
                            
                            Text(viewModel.race?.circuit?.location?.country?.uppercased() ?? "Country")
                                .foregroundColor(.white)
                                .font(.custom("NicoMoji-Regular", fixedSize: 15))
                                
                            
                            VStack(alignment: .center) {
                                Text(viewModel.nexEventInfo?.name ?? "STARTS IN")
                                    .foregroundColor(.white)
                                    .font(.custom("NicoMoji-Regular", fixedSize: 22))
                                .padding(.top)
                                
                                Text(viewModel.nexEventInfo?.remianingTimeString ?? "1D 14:06:22")
                                    .foregroundColor(.white)
                                    .font(.custom("NicoMoji-Regular", fixedSize: 28))

                            }
                            
                                                    
                            
                        }
                        .padding()
                    }
                    .cornerRadius(25)
                    .padding()
                   
                    
                    
                    
                    Color.blue
                        .frame(height: 300, alignment: .center)
                    
                }
                .padding(.horizontal)
                
                    .task {
                        await viewModel.fetchRace()
                              viewModel.initCountdownIfNeeded()
                    }
                    
            }
        }
    }

}

struct ChampionshipPath_GrandPrixPath: PreviewProvider {
    static var previews: some View {
        GrandPrixView()
    }
}
