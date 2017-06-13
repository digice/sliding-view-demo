//
//  TextField.swift
//  SlidingViewDemo
//
//  Created by Digices LLC on 6/12/17.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

extension UITextField {
  
  func fieldPosition(contentOffset: CGPoint) -> CGFloat {
    
    var position = self.frame.maxY
    
    if let stackView = self.superview {
      position = position + stackView.frame.minY
    }
    
    return position - contentOffset.y
    
  }
  
}
