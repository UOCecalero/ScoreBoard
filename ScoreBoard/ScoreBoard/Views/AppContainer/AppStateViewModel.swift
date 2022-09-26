//
//  AppStateViewModel.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 25/9/22.
//  Copyright © 2022 Iflet.tech. All rights reserved.
//

import Foundation

final class AppStateViewModel: ObservableObject {

    enum LoadingStateEnum: Int {
        case start
        case loading
        case end
        case error
    }
    
    
    @Published var loadingState: LoadingStateEnum = .start
    
}
