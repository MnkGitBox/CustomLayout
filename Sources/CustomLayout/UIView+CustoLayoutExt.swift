//
//  UIView+CustoLayoutExt.swift
//  
//
//  Created by Malith Kamburapola on 2022-01-15.
//

import UIKit

public extension UIView {
    var layout: CustomLayout { CustomLayoutEngine.init(self) }
}
