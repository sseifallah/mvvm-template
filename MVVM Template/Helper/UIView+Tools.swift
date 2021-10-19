//
//  UIView_GradientExtension.swift
//  CircularCarousel Demo
//
//  Created by Piotr Suwara on 19/1/19.
//  Copyright © 2019 Piotr Suwara. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradient(withColors colors: [UIColor]) {
        if let sublayers = layer.sublayers {
            let _ = sublayers.filter({ $0 is CAGradientLayer }).map({ $0.removeFromSuperlayer() })
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map({ $0.cgColor })
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyScale(_ scale: CGFloat) {
        layer.transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1.0)
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as! T
    }
    
    func addTopRoundedCornerToView(targetView:UIView?, desiredCurve:CGFloat?, shadowLayer: CALayer)
    {
        let offset:CGFloat =  targetView!.frame.width/desiredCurve!
        let bounds: CGRect = targetView!.bounds

        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y+bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)

        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)

        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        if #available(iOS 13.0, *) {
            if UserDefaults.standard.bool(forKey: "isDarkMode"){
                maskLayer.fillColor = UIColor.black.cgColor
            }else{
                maskLayer.fillColor = UIColor.white.cgColor
            }
            
        } else {
            if UserDefaults.standard.bool(forKey: "isDarkMode"){
                maskLayer.fillColor = UIColor.black.cgColor
            }else{
                maskLayer.fillColor = UIColor.white.cgColor
            }
        }
            
        maskLayer.shadowColor = targetView?.layer.shadowColor
        maskLayer.shadowOffset = targetView?.layer.shadowOffset ?? CGSize(width: 0, height: 0)
        maskLayer.shadowOpacity = targetView?.layer.shadowOpacity ?? 0
        maskLayer.shadowPath = targetView?.layer.shadowPath
        maskLayer.shadowRadius = targetView?.layer.shadowRadius ?? 0

        // Set the newly created shape layer as the mask for the view's layer
        targetView!.layer.mask = maskLayer
        shadowLayer.insertSublayer(maskLayer, at: 0)
        
        targetView!.layer.addSublayer(shadowLayer)
        
    }
    
    func createShadowLayer(targetView:UIView) -> CALayer {
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = targetView.layer.shadowColor
        shadowLayer.shadowOffset = targetView.layer.shadowOffset
        shadowLayer.shadowRadius = targetView.layer.shadowRadius
        shadowLayer.shadowOpacity = targetView.layer.shadowOpacity
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        return shadowLayer
    }
    
    func addBottomRoundedEdge(targetView:UIView?, desiredCurve:CGFloat?, shadowLayer: CALayer) {
        let offset: CGFloat = self.frame.width / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        if #available(iOS 13.0, *) {
            if UserDefaults.standard.bool(forKey: "isDarkMode"){
                maskLayer.fillColor = UIColor.black.cgColor
            }else{
                maskLayer.fillColor = UIColor.white.cgColor
            }
            
        } else {
            if UserDefaults.standard.bool(forKey: "isDarkMode"){
                maskLayer.fillColor = UIColor.black.cgColor
            }else{
                maskLayer.fillColor = UIColor.white.cgColor
            }
        }
            
        maskLayer.shadowColor = targetView?.layer.shadowColor
        maskLayer.shadowOffset = targetView?.layer.shadowOffset ?? CGSize(width: 0, height: 0)
        maskLayer.shadowOpacity = targetView?.layer.shadowOpacity ?? 0
        maskLayer.shadowPath = targetView?.layer.shadowPath
        maskLayer.shadowRadius = targetView?.layer.shadowRadius ?? 0

        // Set the newly created shape layer as the mask for the view's layer
        targetView!.layer.mask = maskLayer
        shadowLayer.insertSublayer(maskLayer, at: 0)
        
        targetView!.layer.addSublayer(shadowLayer)
    }
}
