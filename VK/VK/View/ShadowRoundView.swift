//
//  ShadowRoundView.swift
//  VK
//
//  Created by Михаил Чертов on 03.01.2021.
//

import UIKit

@IBDesignable class ShadowRoundView: UIView {
    
    @IBInspectable var shadeColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
    @IBInspectable var shadeTransparency: CGFloat = 0.5 {
        didSet {
            self.updateTransparency()
        }
    }
    @IBInspectable var shadeRadius: CGFloat = 8 {
        didSet {
            self.updateRadius()
        }
    }
    @IBInspectable  var shadeOffset: CGSize = .zero {
        didSet {
            self.updateOffset()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    func updateColors() {
        self.layer.shadowColor = self.shadeColor.cgColor
    }
    
    func updateTransparency() {
        self.layer.shadowOpacity = Float(shadeTransparency)
    }
    
    func updateRadius() {
        self.layer.shadowRadius = shadeRadius
    }
    
    func updateOffset() {
        self.layer.shadowOffset = shadeOffset
    }
    

}
