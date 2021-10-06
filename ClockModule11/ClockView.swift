

import UIKit

class ClockView: UIView {

    var isSetuped = false
    
    var markerSize: CGSize = CGSize(width: 4, height: 12)
    var markerColor = UIColor.blue
    
    private let topMarker = UIView()
    private let leftMarker = UIView()
    private let rightMarker = UIView()
    private let bottomMarker = UIView()
    
    var hourLineSize: CGFloat = 12
    var hourLineColor = UIColor.red
    var minuteLineSize: CGFloat = 6
    var minuteLineColor = UIColor.green
    
    private let hourLine = UIView()
    private let minuteLine = UIView()
    
    lazy var date = Date()
    lazy var calendar = NSCalendar.current
    lazy var hours: CGFloat = CGFloat(calendar.component(.hour, from: date))
    lazy var minutes: CGFloat = CGFloat(calendar.component(.minute, from: date))
    
    
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
        minuteLine.frame = CGRect(x: w / 2 - minuteLineSize / 2, y: markerSize.height + 10, width: minuteLineSize, height: h / 2 - markerSize.height - 10 )
        minuteLine.backgroundColor = minuteLineColor
        
        //hours = 0
        //minutes = 0
        updateHours()
        
        for v in [topMarker, leftMarker, rightMarker, bottomMarker] {
            v.backgroundColor = markerColor
            addSubview(v)
        }
        
        addSubview(minuteLine)
        addSubview(hourLine)
        
        //круглые часы
        layer.cornerRadius = w / 2
        
    }
    
    func updateHours() {
        
        let minuteAngle = 2 * CGFloat.pi / 60 * minutes
        minuteLine.transform = CGAffineTransform(rotationAngle: minuteAngle)
        
        let hourAngle = 2 * CGFloat.pi / 12 * hours + minuteAngle / 12
        hourLine.transform = CGAffineTransform(rotationAngle: hourAngle)
        
        print(minuteAngle)
        print(minutes)
    }

}
