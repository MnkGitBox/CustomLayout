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
        activate(to: secondView, [.leading(constant: constant), .traling(constant: constant), .top(constant: constant), .bottom(constant: constant)], layoutToSafeArea: isSafeAreaActivate)
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
        case let .traling(r, c, safeAreaAlign), let .leading(r, c, safeAreaAlign), let .centerX(r, c, safeAreaAlign):
            firstView.anchorX(for: layoutKey, (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to:  secondView.anchorX(for: layoutKey, (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .top(r, c, safeAreaAlign), let .bottom(r, c, safeAreaAlign), let .centerY(r, c, safeAreaAlign):
            firstView.anchorY(for: layoutKey, (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to: secondView.anchorY(for: layoutKey, (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .topToBottom(r, c, safeAreaAlign):
            firstView.anchorY(for: .top(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to: secondView.anchorY(for: .bottom(), (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .bottomToTop(r, c, safeAreaAlign):
            firstView.anchorY(for: .bottom(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to:  secondView.anchorY(for: .top(), (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .topToCenterY(r, c, safeAreaAlign):
            firstView.anchorY(for: .top(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to: secondView.anchorY(for: .centerY(), (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .bottomToCenterY(r, c, safeAreaAlign):
            firstView.anchorY(for: .bottom(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to: secondView.anchorY(for: .centerY(), (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .leadingToTraling(r, c, safeAreaAlign):
            firstView.anchorX(for: .leading(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to: secondView.anchorX(for: .traling(), (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .leadingToCenterX(r, c, safeAreaAlign):
            firstView.anchorX(for: .leading(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to: secondView.anchorX(for: .centerX(), (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .tralingToLeading(r, c, safeAreaAlign):
            firstView.anchorX(for: .traling(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to: secondView.anchorX(for: .leading(), (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .tralingToCenterX(r, c, safeAreaAlign):
            firstView.anchorX(for: .traling(), (isSafeAreaActivate || safeAreaAlign))
                .constraint(relation: r, to:  secondView.anchorX(for: .centerX(), (isSafeAreaActivate || safeAreaAlign)), constant: c).isActive = true
            
        case let .equalWidth(r, m, c):
            firstView.widthAnchor.constraint(relation: r, to: secondView.widthAnchor, multiplier: m, constant: c).isActive = true
            
        case let .equalHeight(r, m, c):
            firstView.heightAnchor.constraint(relation: r, to: secondView.heightAnchor, multiplier: m, constant: c).isActive = true
            
        case let .equalWidthToHeight(r, m, c):
            firstView.widthAnchor.constraint(relation: r, to: secondView.heightAnchor, multiplier: m, constant: c).isActive = true
            
        case let .equalHeightToWidth(r, m, c):
            firstView.heightAnchor.constraint(relation: r, to: secondView.widthAnchor, multiplier: m, constant: c).isActive = true

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
        case let .height(r, c):
            firstView.heightAnchor.constant(relation: r, constant: c).isActive = true
            
        case let .width(r, c):
            firstView.widthAnchor.constant(relation: r, constant: c).isActive = true
            
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

extension NSLayoutAnchor {
    @objc func constraint(relation r: ConstraintRelationType, to anchor: NSLayoutAnchor<AnchorType>, constant c: CGFloat) -> NSLayoutConstraint {
        switch r {
        case .equalTo:
            return constraint(equalTo: anchor, constant: c)
        case .greaterThanOrEqualTo:
            return constraint(greaterThanOrEqualTo: anchor, constant: c)
        case .lessThanOrEqualTo:
            return constraint(lessThanOrEqualTo: anchor, constant: c)
        }
    }
}

extension NSLayoutDimension {
    @objc func constraint(relation r: ConstraintRelationType, to dimension: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat) -> NSLayoutConstraint {
        switch r {
        case .equalTo:
            return constraint(equalTo: dimension, multiplier: m, constant: c)
        case .greaterThanOrEqualTo:
            return constraint(greaterThanOrEqualTo: dimension, multiplier: m, constant: c)
        case .lessThanOrEqualTo:
            return constraint(lessThanOrEqualTo: dimension, multiplier: m, constant: c)
        }
    }
    
    @objc func constant(relation r: ConstraintRelationType, constant c: CGFloat) -> NSLayoutConstraint {
        switch r {
        case .equalTo:
            return constraint(equalToConstant: c)
        case .greaterThanOrEqualTo:
            return constraint(greaterThanOrEqualToConstant: c)
        case .lessThanOrEqualTo:
            return constraint(lessThanOrEqualToConstant: c)
        }
    }
}
