//
//  MarkersStyle.swift
//  Mapp
//
//  Created by Chiara Giorgia Ricci on 05/06/24.
//

import Foundation
import SwiftUI



struct SpeechBubble: Shape {
    //    var controlPoint: Float
    
    func path(in rect: CGRect) -> Path {
        var cursor = Path()
        
        let height = rect.height
        let width = rect.width
        
        var point = CGPoint()
        point.x = point.x + 4
        
        //bottom left
        cursor.move(to: CGPoint(x: 25, y: height))
        
        //bottom right
        cursor.addLine(to: CGPoint(x: width - 20, y: height))
        cursor.addCurve(to: CGPoint(x: width, y: height - 20),
                        control1: CGPoint(x: width - 8, y: height),
                        control2: CGPoint(x: width, y: height - 8))
        
        //top right
        cursor.addLine(to: CGPoint(x: width, y: 20))
        cursor.addCurve(to: CGPoint(x: width - 20, y: 0),
                        control1: CGPoint(x: width, y: 8),
                        control2: CGPoint(x: width - 8, y: 0))
        
        //top left
        cursor.addLine(to: CGPoint(x: 21, y: 0))
        cursor.addCurve(to: CGPoint(x: 4, y: 20),
                        control1: CGPoint(x: 12, y: 0),
                        control2: CGPoint(x: 4, y: 8))
        
        //bottom left
        
        
        cursor.addLine(to: CGPoint(x: 4, y: height - 35))
        
        //pointy part
        cursor.addLine(to: CGPoint(x: -12, y: height - 20))
        cursor.addLine(to: CGPoint(x: 4, y: height - 20))
        
        //        cursor.addLine(to: CGPoint(x: 11.0, y: height - 4.0))
        cursor.addCurve(to: CGPoint(x: 25, y: height),
                        control1: CGPoint(x: 4, y: height-8),
                        control2: CGPoint(x: 4+8, y: height))
        
        
        return cursor
    }
    
    
    
}
