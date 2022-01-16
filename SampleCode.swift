//
//  SampleCode.swift
//  CustomLayout
//
//  Created by Malith Kamburapola on 2022-01-16.
//

import UIKit
import CustomLayout


//this is for testing some new functionality

class TestViewController: UIViewController {
    
    let redView = UIView().chain.bgColor(.red).component
    let greenView = UIView().chain.bgColor(.green).component

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add as subviews
        view.addSubview(redView)
        view.addSubview(greenView)
        
        //layout using custom layout
        redView.layout.activate([.leading(constant: 20), .top(constant: 10, safeAreaAlign: true), .equalWidth(multiplier: 0.5), .height(constant: 50)])
        
        greenView.layout.activate(to: [view : [.bottom(constant: -2, safeAreaAlign: true), .traling(constant: -20)],
                                    redView : [.leadingToTraling(constant: -10), .topToBottom(constant: 20)]])
        
    }
}
