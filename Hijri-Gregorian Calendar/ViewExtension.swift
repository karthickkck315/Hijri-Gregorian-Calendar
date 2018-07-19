//
//  ViewExtension.swift
//  QiQ
//
//  Created by Karthick on 11/12/17.
//  Copyright © 2017 Karthick. All rights reserved.
//Com.Live.PickApp
//com.demo.PickApp
import UIKit


@IBDesignable
extension UIView {
  // Shadow
  @IBInspectable var shadow: Bool {
    get {
      return layer.shadowOpacity > 0.0
    }
    set {
      if newValue == true {
        self.addShadow()
      }
    }
  }
  
  fileprivate func addShadow(shadowColor: CGColor = UIColor.black.cgColor, shadowOffset: CGSize = CGSize(width: 3.0, height: 3.0), shadowOpacity: Float = 0.35, shadowRadius: CGFloat = 5.0) {
    let layer = self.layer
    layer.masksToBounds = false
    
    layer.shadowColor = shadowColor
    layer.shadowOffset = shadowOffset
    layer.shadowRadius = shadowRadius
    layer.shadowOpacity = shadowOpacity
    layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    
    let backgroundColor = self.backgroundColor?.cgColor
    self.backgroundColor = nil
    layer.backgroundColor =  backgroundColor
  }
  
  
  // Corner radius
  @IBInspectable var circle: Bool {
    get {
      return layer.cornerRadius == self.bounds.width*0.5
    }
    set {
      if newValue == true {
        self.cornerRadius = self.bounds.width*0.5
      }
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return self.layer.cornerRadius
    }
    
    set {
      self.layer.cornerRadius = newValue
    }
  }
  
  
  // Borders
  // Border width
  @IBInspectable
  public var borderWidth: CGFloat {
    set {
      layer.borderWidth = newValue
    }
    
    get {
      return layer.borderWidth
    }
  }
  
  // Border color
  @IBInspectable
  public var borderColor: UIColor? {
    set {
      layer.borderColor = newValue?.cgColor
    }
    
    get {
      if let borderColor = layer.borderColor {
        return UIColor(cgColor: borderColor)
      }
      return nil
    }
  }
  //Set View backGroundColor
  @IBInspectable var backGroundColor : UIColor? {
    get {
      return self.backgroundColor
    }
    set {
      self.backgroundColor = newValue
    }
  }
}
