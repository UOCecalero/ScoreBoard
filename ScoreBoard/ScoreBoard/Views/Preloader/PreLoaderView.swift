//
//  PreLoaderView.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 24/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import SwiftUI

struct PreLoaderView: View {
    
    @EnvironmentObject var appState: AppStateViewModel

    @ObservedObject var viewModel = PreloaderViewModel()
    
    var body: some View {
        
        
        ZStack {
            Color.purple
             Text("Preloader")
                .font(.largeTitle)
        }.task {
            do {
                appState.loadingState = .loading
                try await viewModel.downloadData()
                appState.loadingState = .end
            } catch {
                appState.loadingState = .error
            }
        }
            
    }

}

struct Preloader_Previews: PreviewProvider {
    static var previews: some View {
        PreLoaderView()
    }
}





