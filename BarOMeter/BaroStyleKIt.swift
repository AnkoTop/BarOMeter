//
//  BaroStyleKit.swift
//  BarOMeter
//
//  Created by Anko Top on 22/04/16.
//  Copyright (c) 2016 CompanyName. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class BaroStyleKit : NSObject {

    //// Drawing Methods

    public class func drawGauge(frame frame: CGRect = CGRect(x: 4, y: 3, width: 290, height: 257)) {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.437, green: 0.437, blue: 0.437, alpha: 1.000)

        //// Outer Frame Drawing
        let outerFramePath = UIBezierPath()
        outerFramePath.moveToPoint(CGPoint(x: frame.minX + 0.88760 * frame.width, y: frame.minY + 0.50424 * frame.height))
        outerFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.92797 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.88760 * frame.width, y: frame.minY + 0.73826 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.71406 * frame.width, y: frame.minY + 0.92797 * frame.height))
        outerFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.11240 * frame.width, y: frame.minY + 0.50424 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.28594 * frame.width, y: frame.minY + 0.92797 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.11240 * frame.width, y: frame.minY + 0.73826 * frame.height))
        outerFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.08051 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.11240 * frame.width, y: frame.minY + 0.27022 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.28594 * frame.width, y: frame.minY + 0.08051 * frame.height))
        outerFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.88760 * frame.width, y: frame.minY + 0.50424 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.71406 * frame.width, y: frame.minY + 0.08051 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.88760 * frame.width, y: frame.minY + 0.27022 * frame.height))
        outerFramePath.closePath()
        UIColor.whiteColor().setFill()
        outerFramePath.fill()
        strokeColor.setStroke()
        outerFramePath.lineWidth = 2
        outerFramePath.stroke()


        //// Scale Frame Drawing
        let scaleFramePath = UIBezierPath()
        scaleFramePath.moveToPoint(CGPoint(x: frame.minX + 0.22475 * frame.width, y: frame.minY + 0.67797 * frame.height))
        scaleFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.34109 * frame.width, y: frame.minY + 0.20333 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.13699 * frame.width, y: frame.minY + 0.51178 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.18907 * frame.width, y: frame.minY + 0.29928 * frame.height))
        scaleFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.77525 * frame.width, y: frame.minY + 0.33051 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.49310 * frame.width, y: frame.minY + 0.10738 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.68748 * frame.width, y: frame.minY + 0.16432 * frame.height))
        scaleFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.77525 * frame.width, y: frame.minY + 0.67797 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.83202 * frame.width, y: frame.minY + 0.43801 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.83202 * frame.width, y: frame.minY + 0.57046 * frame.height))
        scaleFramePath.addLineToPoint(CGPoint(x: frame.minX + 0.68126 * frame.width, y: frame.minY + 0.61864 * frame.height))
        scaleFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.68126 * frame.width, y: frame.minY + 0.38983 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.71865 * frame.width, y: frame.minY + 0.54785 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.71865 * frame.width, y: frame.minY + 0.46063 * frame.height))
        scaleFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.39535 * frame.width, y: frame.minY + 0.30608 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.62346 * frame.width, y: frame.minY + 0.28039 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.49546 * frame.width, y: frame.minY + 0.24289 * frame.height))
        scaleFramePath.addCurveToPoint(CGPoint(x: frame.minX + 0.31874 * frame.width, y: frame.minY + 0.61864 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.29524 * frame.width, y: frame.minY + 0.36926 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.26094 * frame.width, y: frame.minY + 0.50920 * frame.height))
        scaleFramePath.addLineToPoint(CGPoint(x: frame.minX + 0.22475 * frame.width, y: frame.minY + 0.67797 * frame.height))
        scaleFramePath.closePath()
        strokeColor.setStroke()
        scaleFramePath.lineWidth = 2
        scaleFramePath.stroke()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.21610 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.15678 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.18217 * frame.width, y: frame.minY + 0.50424 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.23643 * frame.width, y: frame.minY + 0.50424 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.76357 * frame.width, y: frame.minY + 0.50424 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.81783 * frame.width, y: frame.minY + 0.50424 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.68637 * frame.width, y: frame.minY + 0.30049 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.72474 * frame.width, y: frame.minY + 0.25855 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.27526 * frame.width, y: frame.minY + 0.25855 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.31363 * frame.width, y: frame.minY + 0.30049 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.74350 * frame.width, y: frame.minY + 0.39397 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.79364 * frame.width, y: frame.minY + 0.37127 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.20636 * frame.width, y: frame.minY + 0.37128 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.25649 * frame.width, y: frame.minY + 0.39398 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.37837 * frame.width, y: frame.minY + 0.18323 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.39914 * frame.width, y: frame.minY + 0.23804 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.60086 * frame.width, y: frame.minY + 0.77045 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.62163 * frame.width, y: frame.minY + 0.82525 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.62162 * frame.width, y: frame.minY + 0.18323 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.60086 * frame.width, y: frame.minY + 0.23804 * frame.height))
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.39913 * frame.width, y: frame.minY + 0.77045 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.37837 * frame.width, y: frame.minY + 0.82525 * frame.height))
        strokeColor.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()


        //// Arrow Drawing
        let arrowPath = UIBezierPath()
        arrowPath.moveToPoint(CGPoint(x: frame.minX + 0.47761 * frame.width, y: frame.minY + 0.62001 * frame.height))
        arrowPath.addLineToPoint(CGPoint(x: frame.minX + 0.47761 * frame.width, y: frame.minY + 0.52492 * frame.height))
        arrowPath.addLineToPoint(CGPoint(x: frame.minX + 0.48293 * frame.width, y: frame.minY + 0.41927 * frame.height))
        arrowPath.addLineToPoint(CGPoint(x: frame.minX + 0.48293 * frame.width, y: frame.minY + 0.12346 * frame.height))
        arrowPath.addLineToPoint(CGPoint(x: frame.minX + 0.49888 * frame.width, y: frame.minY + 0.08120 * frame.height))
        arrowPath.addLineToPoint(CGPoint(x: frame.minX + 0.51483 * frame.width, y: frame.minY + 0.12346 * frame.height))
        arrowPath.addLineToPoint(CGPoint(x: frame.minX + 0.51483 * frame.width, y: frame.minY + 0.41927 * frame.height))
        arrowPath.addLineToPoint(CGPoint(x: frame.minX + 0.52014 * frame.width, y: frame.minY + 0.52492 * frame.height))
        arrowPath.addLineToPoint(CGPoint(x: frame.minX + 0.52014 * frame.width, y: frame.minY + 0.62001 * frame.height))
        arrowPath.addLineToPoint(CGPoint(x: frame.minX + 0.47761 * frame.width, y: frame.minY + 0.62001 * frame.height))
        arrowPath.closePath()
        arrowPath.lineJoinStyle = .Round;

        strokeColor.setFill()
        arrowPath.fill()
        strokeColor.setStroke()
        arrowPath.lineWidth = 2
        arrowPath.stroke()


        //// Center Oval Drawing
        let centerOvalPath = UIBezierPath(ovalInRect: CGRect(x: frame.minX + floor(frame.width * 0.45172 - 0.5) + 1, y: frame.minY + floor(frame.height * 0.45136 + 0.5), width: floor(frame.width * 0.54828 - 0.5) - floor(frame.width * 0.45172 - 0.5), height: floor(frame.height * 0.55642 + 0.5) - floor(frame.height * 0.45136 + 0.5)))
        UIColor.whiteColor().setFill()
        centerOvalPath.fill()
        strokeColor.setStroke()
        centerOvalPath.lineWidth = 2
        centerOvalPath.stroke()
    }

}
