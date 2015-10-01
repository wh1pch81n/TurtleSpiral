//
//  Turtle.swift
//  
//
//  Created by Derrick  Ho on 9/11/15.
//
//

import UIKit

public struct Angle: IntegerLiteralConvertible {
    var _degree: Int = 0
    public var degree: Int {
        set {
            _degree = newValue % 360
        }
        get {
            return _degree
        }
    }
    public var radian: CGFloat {
        get {
            return CGFloat(degree) * CGFloat(CGFloat(M_PI * 2) / CGFloat(360))
        }
    }
    public init(integerLiteral value: IntegerLiteralType) {
        degree = value
    }
}

extension CGPoint {
    public mutating func rotate(rad: Angle) {
        var newPoint = self
        let ø = rad.radian
        newPoint.x = self.x * CGFloat(cos(ø)) + self.y * CGFloat(-sin(ø))
        newPoint.y = self.x * CGFloat(sin(ø)) + self.y * CGFloat(cos(ø))
        self = newPoint
    }
    
    public mutating func offset(dx: CGFloat, dy: CGFloat) {
        self.y += dy
        self.x += dx
    }
    
    public mutating func offset(p: CGPoint) {
        offset(p.x, dy: p.y)
    }
}

public class Turtle : UIImageView {
    private var theta: Angle = 0
    private var currPosition: CGPoint
    private var path: CGMutablePathRef
    public var color = UIColor.blackColor()
    
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    }
    
    public override init(frame: CGRect) {
        currPosition = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
        path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, currPosition.x, currPosition.y)
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func forward(distance: Int) {
        UIGraphicsBeginImageContext(self.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        var newPoint = CGPoint(x: 0.0, y: 0.0)
        newPoint.x += CGFloat(distance)
        newPoint.rotate(theta)
        newPoint.offset(currPosition)
        
        CGPathAddLineToPoint(path, nil, newPoint.x, newPoint.y)
        
        CGContextSetLineWidth(context, 1.0)
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineJoin(context, CGLineJoin.Round)
        
        CGContextAddPath(context, path)
        CGContextStrokePath(context)
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        currPosition = newPoint
    }
    
    public func left(degrees: Int) {
        theta = Angle(integerLiteral: theta.degree - degrees)
    }
    
    public func right(degrees: Int) {
        left(-degrees)
    }
}
