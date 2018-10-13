//
//  CustomViewImage.swift
//  CustomDetailsViewApp
//
//  Created by Mark on 7/23/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class customImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            print("\(self.frame.size.width)")
            print("\(self.frame.size.height)")
            let path = UIBezierPath()
            path.move(to: CGPoint(x: CGFloat(0), y: CGFloat(0)))
            path.addLine(to: CGPoint(x: CGFloat(self.frame.size.width), y: CGFloat(0)))
            path.addLine(to: CGPoint(x: CGFloat(self.frame.size.width), y: CGFloat((self.frame.size.height/3) * 2+((35/173.5) * self.frame.size.height))))
            path.addCurve(to: CGPoint(x: CGFloat(0), y: CGFloat((self.frame.size.height/3) * 2+((35/173.5) * self.frame.size.height))), controlPoint1: CGPoint(x: CGFloat((self.frame.size.width/2)+((100/375.5)) * self.frame.size.width) , y: CGFloat((self.frame.size.height/3) * 2 + ((60/173.5) * self.frame.size.height))), controlPoint2: CGPoint(x: CGFloat((self.frame.size.width/2)-((100/375.5) * self.frame.size.width)) , y: CGFloat((self.frame.size.height/3) * 2 + ((60/173.5) * self.frame.size.height))))
            path.close()
            UIColor.red.setFill()
            path.stroke()
            path.reversing()
            let shapeLayer = CAShapeLayer()
            shapeLayer.frame = self.bounds
            shapeLayer.path = path.cgPath
            shapeLayer.shadowRadius = CGFloat((2/173.5) * self.frame.size.height)
            shapeLayer.shadowOpacity = 0.3
            shapeLayer.shadowColor = UIColor.black.cgColor
            shapeLayer.fillColor = UIColor.red.cgColor
            shapeLayer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat((2/173.5) * self.frame.size.height))
            self.layer.mask = shapeLayer;
            self.layer.masksToBounds = true;
        }
        self.layoutIfNeeded()
    }
    
}
