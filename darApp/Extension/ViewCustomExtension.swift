//
//  ViewExtension.swift
//  GymReservations
//
//  Created by macbook on 08/03/2021.
//

import UIKit

extension UIView {
    
    @IBInspectable var corner_radius : CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var border_color : UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var border_width : CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var shadow_Radius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadow_Color: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadow_Offset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadow_Opacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    func loadViewFromNib(nibName:String)->UIView?{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setGradient(firstColor:UIColor,secondColor:UIColor,startPoint:CGPoint?,endPoint:CGPoint?) {
        let colours = [firstColor,secondColor]
        
        let gradient: CAGradientLayer = CAGradientLayer()
        //        gradient.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        if let startPoint = startPoint , let endPoint = endPoint{
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UINavigationController{
    func removeBackgroungNavBar(){
        self.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layoutIfNeeded()
    }
}
