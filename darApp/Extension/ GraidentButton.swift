//
//   GraidentButton.swift
//  GymReservations
//
//  Created by macbook on 16/03/2021.
//

import UIKit

class GraidentButton: UIButton {

    var gradient: CAGradientLayer?
    @IBInspectable var firstColor: UIColor = #colorLiteral(red: 0.4, green: 0.8745098039, blue: 0.5843137255, alpha: 1)
    @IBInspectable var secondColor: UIColor = #colorLiteral(red: 0.07843137255, green: 0.7058823529, blue: 0.6549019608, alpha: 1)
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.5)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)

    override func layoutSubviews() {
        super.layoutSubviews()
        setButtonGradient()
    }

    func setButtonGradient() {
        if let g = gradient {
            g.removeFromSuperlayer()
        }
        let colours = [firstColor,secondColor]
        gradient = CAGradientLayer()
        gradient!.frame = self.bounds
        gradient!.colors = colours.map { $0.cgColor }
        gradient!.startPoint = startPoint
        gradient!.endPoint = endPoint
        self.layer.insertSublayer(gradient!, at: 0)
    }
}

