

import UIKit

@IBDesignable
class ClockView: UIView {

    var isSetuped = false
    var timer: Timer = Timer()
    
    @IBInspectable var markerSize: CGSize = CGSize(width: 4, height: 12)
    @IBInspectable var markerColor = UIColor.blue
    
    private let topMarker = UIView()
    private let leftMarker = UIView()
    private let rightMarker = UIView()
    private let bottomMarker = UIView()
    
    @IBInspectable var hourLineSize: CGFloat = 12
    @IBInspectable var hourLineColor = UIColor.red
    @IBInspectable var minuteLineSize: CGFloat = 6
    @IBInspectable var minuteLineColor = UIColor.green
    @IBInspectable var secondLineSize: CGFloat = 2
    @IBInspectable var secondLineColor = UIColor.blue
    
    
    private let hourLine = UIView()
    private let minuteLine = UIView()
    private let secondLine = UIView()
    
    private let roundedView = UIView()
    @IBInspectable var roundedViewColor = UIColor.red
    
    lazy var date = Date()
    lazy var calendar = NSCalendar.current
    @IBInspectable lazy var hours: CGFloat = CGFloat()
    @IBInspectable lazy var minutes: CGFloat = CGFloat()
    @IBInspectable lazy var seconds: CGFloat = CGFloat()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isSetuped { return }
        isSetuped = true
        
        
        //маркеры для часов
        let w = frame.size.width
        let h = frame.size.height
        
        topMarker.frame = CGRect(x: w / 2 - markerSize.width / 2, y: 0, width: markerSize.width, height: markerSize.height)
        leftMarker.frame = CGRect(x: 0, y: h / 2 - markerSize.width / 2, width: markerSize.height, height: markerSize.width)
        rightMarker.frame = CGRect(x: w - markerSize.height, y: h / 2 - markerSize.width / 2, width: markerSize.height, height: markerSize.width)
        bottomMarker.frame = CGRect(x: w / 2 - markerSize.width / 2, y: h - markerSize.height, width: markerSize.width, height: markerSize.height)
        
        //стрелки часов
        hourLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        hourLine.frame = CGRect(x: w / 2 - hourLineSize / 2, y: h / 6, width: hourLineSize, height: h / 3 )
        hourLine.backgroundColor = hourLineColor
        
        minuteLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        minuteLine.frame = CGRect(x: w / 2 - minuteLineSize / 2, y: markerSize.height + 20, width: minuteLineSize, height: h / 2 - markerSize.height - 20 )
        minuteLine.backgroundColor = minuteLineColor
        
        secondLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        secondLine.frame = CGRect(x: w / 2 - secondLineSize / 2, y: markerSize.height, width: secondLineSize, height: h / 2 - markerSize.height)
        secondLine.backgroundColor = secondLineColor
        
        roundedView.frame = CGRect(x: h / 2 - 10, y: w / 2 - 10, width: 20, height: 20)
        roundedView.backgroundColor = roundedViewColor
        roundedView.layer.cornerRadius = 10
        
        //hours = 0
        //minutes = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ClockView.updateHours), userInfo: nil, repeats: true)
        
        
        updateHours()
        
        for v in [topMarker, leftMarker, rightMarker, bottomMarker] {
            v.backgroundColor = markerColor
        }
        
        for v in [topMarker, leftMarker, rightMarker, bottomMarker, hourLine, minuteLine, secondLine, roundedView] {
            addSubview(v)
        }
        
        //круглые часы
        layer.cornerRadius = w / 2
        
    }
    
    @objc func updateHours() {
        
        date = Date()
        
        hours = CGFloat(calendar.component(.hour, from: date))
        minutes = CGFloat(calendar.component(.minute, from: date))
        seconds = CGFloat(calendar.component(.second, from: date))
        
        let secondAngle = 2 * CGFloat.pi / 60 * seconds
        secondLine.transform = CGAffineTransform(rotationAngle: secondAngle)
        
        let minuteAngle = 2 * CGFloat.pi / 60 * minutes
        minuteLine.transform = CGAffineTransform(rotationAngle: minuteAngle)
        
        let hourAngle = 2 * CGFloat.pi / 12 * hours + minuteAngle / 12
        hourLine.transform = CGAffineTransform(rotationAngle: hourAngle)
        
        print(minuteAngle)
        print(hours)
        print(minutes)
        print(seconds)
        
        
    }

}
