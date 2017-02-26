//
//  BlurView.swift
//  uSupport
//
//  Created by Joel.
//  Copyright © 2017 J.Design. All rights reserved.
//

import UIKit

public func insertBlurView (view: UIView, style: UIBlurEffectStyle) -> UIVisualEffectView {
    view.backgroundColor = UIColor.clear
    
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    view.insertSubview(blurEffectView, at: 0)
    return blurEffectView
}
