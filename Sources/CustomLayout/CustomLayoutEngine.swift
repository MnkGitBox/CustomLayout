//
//  CustomLayoutEngine.swift
//  
//
//  Created by Malith Kamburapola on 2022-01-15.
//

import UIKit

struct CustomLayoutEngine: CustomLayout {
    
    private let firstView: UIView
    
    init(_ view: UIView) {
        self.firstView = view
    }
    
    //MARK: - ACTIVE LAYOUT TO PARENT
    
    func activate(equalConstant constant: CGFloat, to secondView: UIView?, layoutToSafeArea isSafeAreaActivate: Bool ) {
        activate(to: secondView, [.leading(constant: constant), .traling(constant: constant), .traling(constant: constant), .bottom(constant: constant)], layoutToSafeArea: isSafeAreaActivate)
    }
    
    func activate(to secondView: UIView?,_ layouts: [CustomLayoutConstraint], layoutToSafeArea isSafeAreaActivate: Bool) {
        for layout in layouts {
            prepareLayout(layout, secondView, isSafeAreaActivate)
        }
    }
    
    func activate(to layoutsConfigurtions: [UIView : [CustomLayoutConstraint]], layoutToSafeArea isSafeAreaActivate: Bool) {
        for config in layoutsConfigurtions {
            for layout in config.value {
                prepareLayout(layout, config.key, isSafeAreaActivate)
            }
        }
    }
    
    func activate(to secondView: UIView, _ layoutKey: CustomLayoutConstraint, layoutToSafeArea isSafeAreaActivate: Bool) {

        switch layoutKey {
        case let .traling(constant, safeAreaAlign), let .leading(constant, safeAreaAlign), let .centerX(constant, safeAreaAlign):
            firstView.anchorX(for: layoutKey, (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorX(for: layoutKey, (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
        case let .top(constant, safeAreaAlign), let .bottom(constant, safeAreaAlign), let .centerY(constant, safeAreaAlign):
            firstView.anchorY(for: layoutKey, (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorY(for: layoutKey, (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
            
        case let .topToBottom(constant, safeAreaAlign):
            firstView.anchorY(for: .top(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorY(for: .bottom(), (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
        case let .bottomToTop(constant, safeAreaAlign):
            firstView.anchorY(for: .bottom(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorY(for: .top(), (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
        case let .topToCenterY(constant, safeAreaAlign):
            firstView.anchorY(for: .top(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorY(for: .centerY(), (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
        case let .bottomToCenterY(constant, safeAreaAlign):
            firstView.anchorY(for: .bottom(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorY(for: .centerY(), (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
        
        case let .leadingToTraling(constant, safeAreaAlign):
            firstView.anchorX(for: .leading(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorX(for: .traling(), (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
        case let .leadingToCenterX(constant, safeAreaAlign):
            firstView.anchorX(for: .leading(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorX(for: .centerX(), (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
        case let .tralingToLeading(constant, safeAreaAlign):
            firstView.anchorX(for: .traling(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorX(for: .leading(), (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
        case let .tralingToCenterX(constant, safeAreaAlign):
            firstView.anchorX(for: .traling(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(equalTo: secondView.anchorX(for: .centerX(), (isSafeAreaActivate || safeAreaAlign)), constant: constant).isActive = true
            
            
        case let .equalWidth(mutiplier, constant):
            firstView.widthAnchor.constraint(equalTo: secondView.widthAnchor, multiplier: mutiplier, constant: constant).isActive = true
            
        case let .equalHeight(mutiplier, constant):
            firstView.heightAnchor.constraint(equalTo: secondView.heightAnchor, multiplier: mutiplier, constant: constant).isActive = true
            
        case let .equalWidthToHeight(mutiplier, constant):
            firstView.widthAnchor.constraint(equalTo: secondView.heightAnchor, multiplier: mutiplier, constant: constant).isActive = true
            
        case let .equalHeightToWidth(mutiplier, constant):
            firstView.heightAnchor.constraint(equalTo: secondView.widthAnchor, multiplier: mutiplier, constant: constant).isActive = true

        default:
            fatalError("Incorrent layout method for key")
        }
        
    }
    
    //Remove all constraint
    func removeAllConstraints() {
        var _superview = firstView.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == firstView {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == firstView {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        firstView.removeConstraints(firstView.constraints)
        firstView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    
    //Activate Dimesion realative layout
    private func activate(_ layout: CustomLayoutConstraint) {
        switch layout {
        case let .height(constant):
            firstView.heightAnchor.constraint(equalToConstant: constant).isActive = true
            
        case let .width(constant):
            firstView.widthAnchor.constraint(equalToConstant: constant).isActive = true
            
        default:
            fatalError("Incorrent layout method for key")
        }
    }
    
    private func prepareLayout(_ layout: CustomLayoutConstraint, _ secondView: UIView?, _ isSafeAreaActivate: Bool) {
        firstView.translatesAutoresizingMaskIntoConstraints = false
        
        switch layout {
        case .height, .width:
            activate(layout)
            
        default:
            
            let `secondView` = secondView == nil ? firstView.superview : secondView
            
            guard let `secondView` = secondView else {
                fatalError("First add \(firstView.description) to view hirachy before layout")
            }

            activate(to: secondView, layout, layoutToSafeArea: isSafeAreaActivate)
        }
    }
    
}



//MARK: - LAYOUT EXTENSION TO UIVIEW
extension UIView {
    func anchorX(for layoutKey: CustomLayoutConstraint, _ safeAreaRelative: Bool) -> NSLayoutXAxisAnchor {
        switch layoutKey {
        case .leading:
            return safeAreaRelative ? self.safeAreaLayoutGuide.leadingAnchor : self.leadingAnchor
            
        case .traling:
            return safeAreaRelative ? self.safeAreaLayoutGuide.trailingAnchor : self.trailingAnchor
            
        case .centerX:
            return safeAreaRelative ? self.safeAreaLayoutGuide.centerXAnchor : self.centerXAnchor
        
        default:
            fatalError("Not Related to NSLayoutXAxisAnchor")
        }
    }
    
    func anchorY(for layoutKey: CustomLayoutConstraint, _ safeAreaRelative: Bool) -> NSLayoutYAxisAnchor {
        switch layoutKey {
        case .top:
            return safeAreaRelative ? self.safeAreaLayoutGuide.topAnchor : self.topAnchor
            
        case .bottom:
            return safeAreaRelative ? self.safeAreaLayoutGuide.bottomAnchor : self.bottomAnchor
            
        case .centerY:
            return safeAreaRelative ? self.safeAreaLayoutGuide.centerYAnchor : self.centerYAnchor
        
        default:
            fatalError("Not Related to NSLayoutXAxisAnchor")
        }
    }
}
