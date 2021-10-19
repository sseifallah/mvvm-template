//
//  UIViewX.swift
//  DesignableX
//
//  Created by Mark Moeykens on 12/31/16.
//  Copyright © 2016 Mark Moeykens. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewX: UIView {
    
    // MARK: - Gradient
    
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var horizontalGradient: Bool = false {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ firstColor.cgColor, secondColor.cgColor ]
        
        if (horizontalGradient) {
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
    }
    
    func updateShadow(){
        let shadowLayer = CALayer()
//        shadowLayer.shadowColor = curvedshadowColor as! CGColor
//        shadowLayer.shadowOffset = CGSize(width: 0, height: curvedshadowOffsetY)
//        shadowLayer.shadowRadius = curvedshadowRadius
//        shadowLayer.shadowOpacity = Float(curvedshadowOpacity)
//        shadowLayer.backgroundColor = UIColor.clear.cgColor
        self.addTopRoundedCornerToView(targetView: self, desiredCurve: curvedTop, shadowLayer: shadowLayer)
    }
    
    // MARK: - Border
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var topRightLeftcornerRadius: CGFloat = 0 {
        didSet {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: topRightLeftcornerRadius, height: topRightLeftcornerRadius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    @IBInspectable public var curvedTop: CGFloat = 0 {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable public var curvedshadowOpacity: CGFloat = 0 {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable public var curvedshadowColor: UIColor = UIColor.clear {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable public var curvedshadowRadius: CGFloat = 0 {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable public var curvedshadowOffsetY: CGFloat = 0 {
        didSet {
            updateShadow()
        }
    }
    
    // MARK: - Shadow
    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
    
    @IBInspectable public var isSemiCircle: Bool = false {
        didSet {
            if isSemiCircle{
                let circlePath = UIBezierPath.init(arcCenter: CGPoint(x: self.bounds.size.width / 2, y: 0), radius: self.bounds.size.height, startAngle: 0.0, endAngle: .pi, clockwise: true)
                let circleShape = CAShapeLayer()
                circleShape.path = circlePath.cgPath
                self.layer.mask = circleShape
            }
        }
    }
}
