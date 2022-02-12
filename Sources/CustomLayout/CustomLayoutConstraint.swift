//
//  MNkLayoutKeys.swift
//  
//
//  Created by Malith Kamburapola on 2022-01-15.
//

import UIKit

public enum CustomLayoutConstraint: Hashable {
    case top(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0,  safeAreaAlign: Bool = false)
    case leading(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case traling(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case bottom(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case centerX(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case centerY(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case height(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0)
    case width(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0)
    
    case topToBottom(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case topToCenterY(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    
    case bottomToTop(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case bottomToCenterY(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    
    case leadingToTraling(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case leadingToCenterX(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    
    case tralingToLeading(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case tralingToCenterX(relation: ConstraintRelationType = .equalTo, constant: CGFloat = 0, safeAreaAlign: Bool = false)
    
    case equalHeight(relation: ConstraintRelationType = .equalTo, multiplier: CGFloat = 1, constant: CGFloat = 0)
    case equalWidth(relation: ConstraintRelationType = .equalTo, multiplier: CGFloat = 1, constant: CGFloat = 0)
    
    case equalHeightToWidth(relation: ConstraintRelationType = .equalTo, mutiplier: CGFloat, constant: CGFloat)
    case equalWidthToHeight(relation: ConstraintRelationType = .equalTo, mutiplier: CGFloat, constant: CGFloat)
    
    //Identify the layout key uniquily
    var layoutId: Int {
        switch self {
        case .top:
            return 0
        case .leading:
            return 1
        case .traling:
            return 2
        case .bottom:
            return 3
        case .centerX:
            return 4
        case .centerY:
            return 5
        case .height:
            return 6
        case .width:
            return 7
        case .topToBottom:
            return 8
        case .topToCenterY:
            return 9
        case .bottomToTop:
            return 10
        case .bottomToCenterY:
            return 11
        case .leadingToTraling:
            return 12
        case .leadingToCenterX:
            return 13
        case .tralingToLeading:
            return 14
        case .tralingToCenterX:
            return 15
        case .equalHeight:
            return 16
        case .equalWidth:
            return 17
        case .equalHeightToWidth:
            return 18
        case .equalWidthToHeight:
            return 19
        }
    }
    
    //Conform Hasable
    public static func == (lhs: CustomLayoutConstraint, rhs: CustomLayoutConstraint) -> Bool {
        return lhs.layoutId == rhs.layoutId
    }
}


@objc public enum ConstraintRelationType: Int {
    case equalTo
    case greaterThanOrEqualTo
    case lessThanOrEqualTo
}
