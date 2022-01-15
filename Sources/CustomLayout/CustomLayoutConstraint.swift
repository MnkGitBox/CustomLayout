//
//  MNkLayoutKeys.swift
//  
//
//  Created by Malith Kamburapola on 2022-01-15.
//

import UIKit

public enum CustomLayoutConstraint: Hashable {
    case top(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case leading(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case traling(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case bottom(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case centerX(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case centerY(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case height(constant: CGFloat = 0)
    case width(constant: CGFloat = 0)
    
    case topToBottom(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case topToCenterY(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    
    case bottomToTop(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case bottomToCenterY(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    
    case leadingToTraling(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case leadingToCenterX(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    
    case tralingToLeading(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    case tralingToCenterX(constant: CGFloat = 0, safeAreaAlign: Bool = false)
    
    case equalHeight(multiplier: CGFloat = 1, constant: CGFloat = 0)
    case equalWidth(multiplier: CGFloat = 1, constant: CGFloat = 0)
    
    case equalHeightToWidth(mutiplier: CGFloat, constant: CGFloat)
    case equalWidthToHeight(mutiplier: CGFloat, constant: CGFloat)
    
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
