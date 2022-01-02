//
//  UIView+Extension.swift
//  NewsTest
//
//  Created by Ahmed Shafik on 03/10/2021.
//

import Foundation
import UIKit

extension UIView {

    func blink(completion:@escaping (()->())) {
         self.alpha = 0.2
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {self.alpha = 1.0}, completion: { isDone in
            if isDone{
                completion()
            }
         })
     }

    func circularRoundedCorner(){
        
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true
    }
    
    func rounderCornerWithRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func borderWith(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func removeCorner() {
        let path = UIBezierPath()
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
     func dropShadow(scale: Bool = true) {
       layer.masksToBounds = false
       layer.shadowColor = UIColor.black.cgColor
       layer.shadowOpacity = 0.5
       layer.shadowOffset = CGSize(width: -1, height: 1)
       layer.shadowRadius = 1

       layer.shadowPath = UIBezierPath(rect: bounds).cgPath
       layer.shouldRasterize = true
       layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }

     func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
       layer.masksToBounds = false
       layer.shadowColor = color.cgColor
       layer.shadowOpacity = opacity
       layer.shadowOffset = offSet
       layer.shadowRadius = radius

       layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
       layer.shouldRasterize = true
       layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }
    
    func dropCustomShadow(color: CGColor, offset: CGSize, raduis: CGFloat, opacity: Float){
        self.layer.masksToBounds = false;
        self.layer.shadowColor = color
        self.layer.shadowOffset = offset;
        self.layer.shadowRadius = raduis;
        self.layer.shadowOpacity = opacity;
    }
    func createDottedLine(width: CGFloat, color: CGColor) {
       let caShapeLayer = CAShapeLayer()
       caShapeLayer.strokeColor = color
       caShapeLayer.lineWidth = width
       caShapeLayer.lineDashPattern = [2,3]
       let cgPath = CGMutablePath()
       let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
       cgPath.addLines(between: cgPoint)
       caShapeLayer.path = cgPath
       layer.addSublayer(caShapeLayer)
    }
}
