//
//  ViewController.swift
//  BarOMeter
//
//  Created by Anko Top on 01/03/16.
//  Copyright © 2016 REactivity. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    lazy var altimeter :CMAltimeter = CMAltimeter()
    
    @IBOutlet var pressureView: UIView!
    @IBOutlet weak var meterLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    
    @IBOutlet weak var maxPressureLabel: UILabel!
    @IBOutlet weak var minPressureLabel: UILabel!
    @IBOutlet weak var deltaPressureLabel: UILabel!
    
    @IBOutlet weak var gaugeView: GaugeView!
    
    @IBOutlet weak var maxAltLabel: UILabel!
    @IBOutlet weak var minAltLabel: UILabel!
    @IBOutlet weak var deltaAltLabel: UILabel!
    
    @IBOutlet weak var signalView: UIView!
   // @IBOutlet weak var chartView: PressureChartView!
    @IBOutlet weak var statsView: UIView!
    
    // altitude offset in meter, enables reset feature
    var offset: Float = 0.0
    
    // relative altitude in meter
    var altitude: Float = 0.0 {
        didSet { updateViewWithNewAlt(meter: self.altitude) }
    }
    
    // current pressure in kPa
    var pressure :Float = 0.0 {
        didSet { updateViewWithNewPressure(kPa: self.pressure)}
    }
    
    // min / max values are inited with maximum values, so they dont get capped to 0 if below 0
    var maxAlt: Float = Float(Int.min)
    var minAlt: Float = Float(Int.max)
    
    var maxPressure: Float = Float(Int.min)
    var minPressure: Float = Float(Int.max)
    
    
    var hourLayer = CAShapeLayer()
    var previousAngle: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadStatsFromBackground()
        
        if CMAltimeter.isRelativeAltitudeAvailable() {
            print("starting altimeter update")
            self.startAltimeterUpdate()
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName("APP_ENTER_BACKGROUND",
            object: nil, queue: NSOperationQueue.currentQueue(),
            usingBlock: { (n:NSNotification!) -> Void in
                
                self.saveStatsForBackground()
                
        })
        
        //test
        setLayout()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        addGaugeHand()
    }
    // constraints that will be affected by a rotation change
    @IBOutlet weak private var chartViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var chartViewTopConstraint: NSLayoutConstraint!
    
    
    /*
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        let ui = toInterfaceOrientation
        
        // 78 or 10
        self.chartViewBottomConstraint.constant = (ui.isLandscape) ? 10 : 78
        
        // 389 or 10
        self.chartViewTopConstraint.constant = (ui.isLandscape) ? 10 : 389
        
        self.statsView.hidden = (ui.isLandscape)
        
        
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            self.view.setNeedsLayout()
            
            }, completion: { (finished:Bool) -> Void in
                
                //self.chartView.chartView.reloadData()
        })
        
    }
    */
    
    
    func startAltimeterUpdate() {
        
        self.altimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.currentQueue()!,
            withHandler: { (altdata:CMAltitudeData?, error:NSError?) -> Void in
                print("should handle new measure")
                if altdata != nil {
                    print("valid data")
                    //print(altdata!.pressure)
                    //print(altdata!.relativeAltitude)
                    self.handleNewMeasure(pressureData: altdata!)
                } else {
                    print("no data available")
                }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleNewMeasure(pressureData pressureData: CMAltitudeData) {
        
        self.pressure = Float(pressureData.pressure)
        self.altitude = Float(pressureData.relativeAltitude)
        //print(pressureData)
        //self.chartView.addTimedDataPoint(pressure: self.pressure)
        //print(self.pressure)
        //print(self.altitude)
    }
    
    @IBAction func tappedReset(sender: UIButton) {
        
        self.offset = self.altitude
        
        self.maxAlt = Float(Int.min)
        self.minAlt = Float(Int.max)
        
        self.maxPressure = Float(Int.min)
        self.minPressure = Float(Int.max)
        
    }
    
    func updateViewWithNewAlt(meter meter :Float) {
        
        let newAlt = meter - self.offset
        //self.meterLabel.text = NSString(format: "%0.2f m", newAlt) as String
        print(NSString(format: "%0.2f m", newAlt) as String)
        

        if newAlt > self.maxAlt {
            self.maxAlt = newAlt
            //self.flashSignalWith(color: UIColor.greenColor())
        }
        
        if newAlt < self.minAlt {
            self.minAlt = newAlt
           // self.flashSignalWith(color: UIColor.redColor())
        }
        
        let delta = self.maxAlt - self.minAlt
        
        //self.maxAltLabel.text = NSString(format: "%0.2f m", self.maxAlt) as String
        //self.minAltLabel.text = NSString(format: "%0.2f m", self.minAlt) as String
        //self.deltaAltLabel.text = NSString(format: "%0.2f m", delta) as String
        
    }
    
    func updateViewWithNewPressure(kPa kPa :Float) {
        
        let hPa = kPa * 10
        
        self.pressureLabel.text = NSString(format: "%0.3f hPa", hPa) as String
        print(NSString(format: "%0.3f hPa", hPa) as String)
        if hPa > self.maxPressure {
            self.maxPressure = hPa
        }
        
        if hPa < self.minPressure {
            self.minPressure = hPa
        }
        
        let delta = self.maxPressure - self.minPressure
        
        //self.maxPressureLabel.text = NSString(format: "%0.3f hPa", self.maxPressure) as String
        //self.minPressureLabel.text = NSString(format: "%0.3f hPa", self.minPressure) as String
        //self.deltaPressureLabel.text = NSString(format: "%0.3f hPa", delta) as String
        //gaugeView.pressure = hPa
        //gaugeView.setNeedsDisplay()
        rotateLayer(hourLayer, dur: 30)
        
    }
    
    func flashSignalWith(color color: UIColor) {
        
        self.signalView.backgroundColor = color
        self.signalView.alpha = 1
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.signalView.alpha = 0
            
        })
    }
    
    func saveStatsForBackground() {
        
        let dict = NSDictionary(dictionary: [
            "pressure": self.pressure,
            "alt": self.altitude,
            "maxPressure": self.maxPressure,
            "minPressure": self.minPressure,
            "maxAlt": self.maxAlt,
            "minAlt": self.minAlt
            ])
        
        
        NSUserDefaults.standardUserDefaults().setObject(dict, forKey: "minMaxStats")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    
    func reloadStatsFromBackground() {
        
        if let dict = NSUserDefaults.standardUserDefaults().objectForKey("minMaxStats") as? NSDictionary {
            
            let sdict = dict as! Dictionary<String, Float>
            
            self.altitude = sdict["alt"]!
            self.pressure = sdict["pressure"]!
            
            self.maxPressure = sdict["maxPressure"]!
            self.minPressure = sdict["minPressure"]!
            self.maxAlt = sdict["maxAlt"]!
            self.minAlt = sdict["minAlt"]!
            
            self.updateViewWithNewAlt(meter: self.altitude)
            self.updateViewWithNewPressure(kPa: self.pressure)
        }
        
    }

    func setLayout() {
        // Layout is determined by the pressure value
        // 1) Gradient falls in certain range:
        /*
            970 to 984  = Stormy - Grey
            984 to 998   = Rain  - Grey- Dark blue
            998 to 1012 = Change -
            1012 to 1026 = Fair
            1026 to 1040 = Dry
        */
        //2) y-position is determined by place in the range
        
        // Even better: wavemodel
        
        
        let topColor = UIColor(red: CGFloat(0/255.0), green: CGFloat(0/255.0), blue: CGFloat(205/255.0), alpha: 1.0)
        let bottomColor = UIColor(red: CGFloat(0/255.0), green: CGFloat(0/255.0), blue: CGFloat(0/255.0), alpha: 1.0)
        let background = GradientHelpers().makeGradientFor(topColor: topColor, bottomColor: bottomColor)
        background.frame = self.pressureView.bounds
        self.pressureView.layer.insertSublayer(background, atIndex: 0)
        pressureLabel.textColor = UIColor.whiteColor()
        //drawInnerCircle()
        //drawOuterCircle()
        gaugeView.backgroundColor = UIColor.clearColor()
        // gauge
        //addGaugeHand()
    }
    
    func addGaugeHand() {
        
        //lhourLayer = CAShapeLayer()
        hourLayer.frame = view.frame
        let path = CGPathCreateMutable()
        
        CGPathMoveToPoint(path, nil, CGRectGetMidX(view.frame), CGRectGetMidY(view.frame))
        //CGPathAddLineToPoint(path, nil, time.h.x, time.h.y)
        CGPathAddLineToPoint(path, nil, 240, 240)
        hourLayer.path = path
        hourLayer.lineWidth = 4
        hourLayer.lineCap = kCALineCapRound
        hourLayer.strokeColor = UIColor.whiteColor().CGColor
        
        // see for rasterization advice http://stackoverflow.com/questions/24316705/how-to-draw-a-smooth-circle-with-cashapelayer-and-uibezierpath
        hourLayer.rasterizationScale = UIScreen.mainScreen().scale;
        hourLayer.shouldRasterize = true
        
        self.pressureView.layer.addSublayer(hourLayer)
        
        // text test
        //UIGraphicsBeginImageContext(gaugeView.frame.size)
        //var context = UIGraphicsGetCurrentContext()!
        // *******************************************************************
        // Scale & translate the context to have 0,0
        // at the centre of the screen maths convention
        // Obviously change your origin to suit...
        // *******************************************************************
        //CGContextTranslateCTM (context, pressureView.frame.size.width / 2, pressureView.frame.size.height / 2)
        //CGContextScaleCTM (context, 1, -1)
        //centreArcPerpendicularText("Fair", context: context, radius: 400 , angle: 0, colour: UIColor.whiteColor(), font: UIFont.systemFontOfSize(16), clockwise: true)
    }
    
    
    func drawInnerCircle() {
        let x = pressureView.frame.width / 2
        let y = pressureView.frame.height / 2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: CGFloat(90), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.blackColor().CGColor
        shapeLayer.opacity = 0.5
        //you can change the stroke color
        //shapeLayer.strokeColor = UIColor.redColor().CGColor
        //you can change the line width
        //shapeLayer.lineWidth = 3.0
        
        pressureView.layer.addSublayer(shapeLayer)
    }
    
    func drawOuterCircle() {
        let x = pressureView.frame.width / 2
        let y = pressureView.frame.height / 2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: CGFloat(91), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.opacity = 1.0
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        //you can change the line width
        shapeLayer.lineWidth = 1.0
        
        pressureView.layer.addSublayer(shapeLayer)
    }
    
    func rotateLayer(currentLayer:CALayer,dur:CFTimeInterval){
        
        let test = arc4random_uniform(30)
        var angle = degree2radian(CGFloat(pressure + Float(test)))
        
        // rotation http://stackoverflow.com/questions/1414923/how-to-rotate-uiimageview-with-fix-point
        var theAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        theAnimation.duration = dur
        // Make this view controller the delegate so it knows when the animation starts and ends
        theAnimation.delegate = self
        theAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        // Use fromValue and toValue
        theAnimation.fromValue = previousAngle
        theAnimation.repeatCount = Float.infinity
        theAnimation.toValue = angle
        previousAngle = angle
        // Add the animation to the layer
        currentLayer.addAnimation(theAnimation, forKey:"rotate")
        
    }
    
    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(M_PI) * a/180
        return b
    }
    
    func drawGauge() {
        
        //let gauge = GaugeView()
        print("should add gauge")
        //gauge.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        
        //pressureView.addSubview(gauge)
       // UIGraphicsEndImageContext()
        
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


typealias GradientHelpers = CAGradientLayer
extension GradientHelpers {
    func makeGradientFor(topColor topColor: UIColor, bottomColor: UIColor) -> CAGradientLayer {
        
        let gradientColors = [topColor.CGColor, bottomColor.CGColor]
        let gradienLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradienLocations
        
        return gradientLayer
        
    }
}

