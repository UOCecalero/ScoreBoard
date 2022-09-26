//
//  AutoColorRing.swift
//  ScoreBoard
//
//  Created by Edu Calero on 20/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import SwiftUI

struct AutoColorRing: View {
    
    @Binding var width: CGFloat
    @Binding var height: CGFloat
    @Binding var percent: CGFloat
    @Binding var show: Bool
    
    
    var body: some View {
        
        var firstColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        var secondColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        
//        switch percent {
//        case 100...70:
//            firstColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//            secondColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
//        case 70...30:
//            firstColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//            secondColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
//        default:
//            firstColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
//            secondColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
//        }
        
        return RingView(
                            color1: firstColor ,
                            color2: secondColor,
                            width: $width,
                            height: $height,
                            percent: $percent,
                            show: $show
        )
    }
}

struct AutoColorRing_Previews: PreviewProvider {
    static var previews: some View {
        AutoColorRing(
            width: .constant(200),
            height: .constant(200),
            percent: .constant(73),
            show: .constant(true)
        )
    }
}
