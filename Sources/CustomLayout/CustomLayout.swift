//
//  CustomLayout.swift
//  
//
//  Created by Malith Kamburapola on 2022-01-14.
//

import UIKit

public protocol CustomLayout {
    
    ///Activate layout ancher to second view using equal constant to all  NSLayoutXAxisAnchor and  NSLayoutYAxisAnchor.
    func activate(equalConstant constant: CGFloat, to secondView: UIView?, layoutToSafeArea isSafeAreaActivate: Bool)
    
    
    ///Activate layout ancher to second view using defined  constant to all  NSLayoutXAxisAnchor and  NSLayoutYAxisAnchor.
    func activate(to secondView: UIView?,_ layouts: [CustomLayoutConstraint], layoutToSafeArea isSafeAreaActivate: Bool)
    
    
    ///Activate layout anchor using different layout configuration to different views.
    func activate(to layoutsConfigurtions: [UIView : [CustomLayoutConstraint]], layoutToSafeArea isSafeAreaActivate: Bool)
    
    
    ///Activate single layout anchor to second view.
    func activate(to secondView: UIView, _ layout: CustomLayoutConstraint, layoutToSafeArea isSafeAreaActivate: Bool)
    
    ///Remove all constraint in target view
    func removeAllConstraints()
}

public extension CustomLayout {
    
    ///Activate layout ancher to second view using equal constant to all  NSLayoutXAxisAnchor and  NSLayoutYAxisAnchor. 
    func activate(equalConstant constant: CGFloat = 0, to secondView: UIView? = nil, layoutToSafeArea isSafeAreaActivate: Bool = false) {
        activate(equalConstant: constant, to: secondView, layoutToSafeArea: isSafeAreaActivate)
    }
    
    ///Activate layout ancher to second view using defined  constant to all  NSLayoutXAxisAnchor and  NSLayoutYAxisAnchor.
    func activate(to secondView: UIView? = nil,_ layouts: [CustomLayoutConstraint], layoutToSafeArea isSafeAreaActivate: Bool = false) {
        activate(to: secondView, layouts, layoutToSafeArea: isSafeAreaActivate)
    }
    
    ///Activate layout anchor using different layout configuration to different views.
    func activate(to layoutsConfigurtions: [UIView : [CustomLayoutConstraint]], layoutToSafeArea isSafeAreaActivate: Bool = false) {
        activate(to: layoutsConfigurtions, layoutToSafeArea: isSafeAreaActivate)
    }
    
    ///Activate single layout anchor to second view.
    func activate(to secondView: UIView, _ layout: CustomLayoutConstraint, layoutToSafeArea isSafeAreaActivate: Bool = false) {
        activate(to: secondView, layout, layoutToSafeArea: isSafeAreaActivate)
    }
    
}
