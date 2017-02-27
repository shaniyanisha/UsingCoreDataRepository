//
//  GenericFunction.swift
//  HitList
//
//  Created by Appinventiv on 25/02/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  var getTableViewCell : UITableViewCell?{
    
    var subview = self
    
    while !(subview is UITableViewCell){
      
      guard let s = subview.superview  else { return nil }
      subview = s
      
    }
    
    return subview as? UITableViewCell
    
  }
  
  var getCollectionViewCell : UICollectionViewCell?{
    
    var subview = self
    
    while !(subview is UICollectionViewCell){
      
      guard let s = subview.superview  else { return nil}
      subview = s
      
    }
    
    return subview as? UICollectionViewCell
    
  }
  
  
}
