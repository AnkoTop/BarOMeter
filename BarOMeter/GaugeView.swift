//
//  GaugeView.swift
//  BarOMeter
//
//  Created by Anko Top on 21/04/16.
//  Copyright © 2016 REactivity. All rights reserved.
//

import UIKit


@IBDesignable

class GaugeView: UIView {

    var pressure : Float = 0.0
    var scale : CGFloat = 1.0
    
    
    
    override func drawRect(rect: CGRect) {
        //BaroStyleKit.drawGauge(frame: self.bounds)
        drawClock(self.bounds)
        
    }
    
    func drawClock(rect: CGRect) {
        
        var ctx = UIGraphicsGetCurrentContext()!
        
        // MARK: Create back of watchface
        let rad = CGRectGetWidth(rect)/3.5
        let endAngle = CGFloat(2*M_PI)
        
        CGContextAddArc(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect), rad, 0, endAngle, 1)
        CGContextSetFillColorWithColor(ctx,UIColor.clearColor().CGColor)
        CGContextSetStrokeColorWithColor(ctx,UIColor.whiteColor().CGColor)
        CGContextSetLineWidth(ctx, 2.0)
        // use to fill and stroke path (see http://stackoverflow.com/questions/13526046/cant-stroke-path-after-filling-it )
        CGContextDrawPath(ctx, CGPathDrawingMode.FillStroke)
        
        for i in 1...60 {
            
            // save the original position and origin
            CGContextSaveGState(ctx)
            // make translation
            CGContextTranslateCTM(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect))
            // make rotation
            CGContextRotateCTM(ctx, degree2radian(CGFloat(i)*6))
            if i % 5 == 0 {
                // if an hour position we want a line slightly longer
                drawSecondMarker(ctx, x: rad-15, y:0, radius:rad, color: UIColor.whiteColor(), lineWidth: 2.0)
            }
            else {
                drawSecondMarker(ctx, x: rad-10, y:0, radius:rad, color: UIColor.whiteColor())
            }
            // restore state before next translation
            CGContextRestoreGState(ctx)
        }
        
        drawWeatherPrediction(ctx, rect: rect)
        drawScale(ctx)
    }

    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(M_PI) * a/180
        return b
    }
    
    func drawWeatherPrediction(context: CGContext, rect: CGRect) {
        CGContextTranslateCTM (context, rect.size.width / 2, rect.size.height / 2)
        CGContextScaleCTM (context, 1, -1)
        let weatherTypes = ["Stormy", "Rain", "Change", "Fair", "Very Dry"]
        //let weatherTypes = ["Stormy"]
        var angle: CGFloat = CGFloat(M_PI_2 * (2 + 1/3))
        for type in weatherTypes  {
            centreArcPerpendicularText(type, context: context, radius: 120, angle: angle, colour: UIColor.whiteColor(), font: UIFont.systemFontOfSize(24), clockwise: true)
            angle -= CGFloat(M_PI_2 * 2/3)
        }
    }
    
    func drawScale (context: CGContext) {
        let scales = ["970", "980", "990", "1000", "1010", "1020", "1030", "1040", "1050"]
        //let scales = ["970"]
        var angle: CGFloat = CGFloat(M_PI_2 * (2 + 1/3))
        for scale  in scales {
            centreArcPerpendicularText(scale, context: context, radius: 70, angle: angle, colour: UIColor.whiteColor(), font: UIFont.systemFontOfSize(12), clockwise: true)
            angle -= CGFloat(M_PI_2 * 1/3)
        }
    }
    
    
    func drawSecondMarker(ctx: CGContextRef, x:CGFloat, y:CGFloat, radius:CGFloat, color:UIColor, lineWidth:CGFloat = 1.5) {
        // generate a path
        let path = CGPathCreateMutable()
        // move to starting point on edge of circle
        CGPathMoveToPoint(path, nil, radius, 0)
        // draw line of required lengt
        CGPathAddLineToPoint(path, nil, x, y)
        // close subpath
        CGPathCloseSubpath(path)
        // add the path to the context
        CGContextAddPath(ctx, path)
        // set the line width
        CGContextSetLineWidth(ctx, lineWidth)
        // set the line color
        CGContextSetStrokeColorWithColor(ctx,color.CGColor)
        // draw the line
        CGContextStrokePath(ctx)
    }
    
    
    // MARK: text placement
    
    func centreArcPerpendicularText(str: String, context: CGContextRef, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, clockwise: Bool){
        // *******************************************************
        // This draws the String str around an arc of radius r,
        // with the text centred at polar angle theta
        // *******************************************************
        
        let l = str.characters.count
        let attributes = [NSFontAttributeName: font]
        
        var characters: [String] = [] // This will be an array of single character strings, each character in str
        var arcs: [CGFloat] = [] // This will be the arcs subtended by each character
        var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
        
        // Calculate the arc subtended by each letter and their total
        for i in 0 ..< l {
            characters += [String(str[str.startIndex.advancedBy(i)])]
            arcs += [chordToArc(characters[i].sizeWithAttributes(attributes).width, radius: r)]
            totalArc += arcs[i]
        }
        
        // Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
        // or anti-clockwise (right way up at 6 o'clock)?
        let direction: CGFloat = clockwise ? -1 : 1
        let slantCorrection = clockwise ? -CGFloat(M_PI_2) : CGFloat(M_PI_2)
        
        // The centre of the first character will then be at
        // thetaI = theta - totalArc / 2 + arcs[0] / 2
        // But we add the last term inside the loop
        var thetaI = theta - direction * totalArc / 2
        
        for i in 0 ..< l {
            thetaI += direction * arcs[i] / 2
            // Call centerText with each character in turn.
            // Remember to add +/-90º to the slantAngle otherwise
            // the characters will "stack" round the arc rather than "text flow"
            centreText(characters[i], context: context, radius: r, angle: thetaI, colour: c, font: font, slantAngle: thetaI + slantCorrection)
            // The centre of the next character will then be at
            // thetaI = thetaI + arcs[i] / 2 + arcs[i + 1] / 2
            // but again we leave the last term to the start of the next loop...
            thetaI += direction * arcs[i] / 2
        }
    }
    
    func chordToArc(chord: CGFloat, radius: CGFloat) -> CGFloat {
        // *******************************************************
        // Simple geometry
        // *******************************************************
        return 2 * asin(chord / (2 * radius))
    }
    
    func centreText(str: String, context: CGContextRef, radius r:CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, slantAngle: CGFloat) {
        // *******************************************************
        // This draws the String str centred at the position
        // specified by the polar coordinates (r, theta)
        // i.e. the x= r * cos(theta) y= r * sin(theta)
        // and rotated by the angle slantAngle
        // *******************************************************
        
        // Set the text attributes
        let attributes = [NSForegroundColorAttributeName: c,
                          NSFontAttributeName: font]
        // Save the context
        CGContextSaveGState(context)
        // Undo the inversion of the Y-axis (or the text goes backwards!)
        CGContextScaleCTM(context, 1, -1)
        // Move the origin to the centre of the text (negating the y-axis manually)
        CGContextTranslateCTM(context, r * cos(theta), -(r * sin(theta)))
        // Rotate the coordinate system
        CGContextRotateCTM(context, -slantAngle)
        // Calculate the width of the text
        let offset = str.sizeWithAttributes(attributes)
        // Move the origin by half the size of the text
        CGContextTranslateCTM (context, -offset.width / 2, -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
        // Draw the text
        str.drawAtPoint(CGPointZero, withAttributes: attributes)
        // Restore the context
        CGContextRestoreGState(context)
    }

}
