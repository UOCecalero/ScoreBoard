//
//  ContainerView.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 25/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import SwiftUI

struct AppContainerView: View {
    
    @EnvironmentObject var appState: AppStateViewModel
    
    var body: some View {
        
        VStack {
            if appState.initialLoadingState == .end {
                MainView()
            } else {
                PreLoaderView()
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
    
        AppContainerView()
    }
}
