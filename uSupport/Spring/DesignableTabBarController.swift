//
//  DesignableTabBarController.swift
//  uSupport
//
//  Created by Joel.
//  Copyright © 2017 J.Design. All rights reserved.
//

import UIKit

@IBDesignable class DesignableTabBarController: UITabBarController {
    
    @IBInspectable var normalTint: UIColor = UIColor.clear {
        didSet {
            UITabBar.appearance().tintColor = normalTint
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: normalTint], for: UIControlState())
        }
    }
    
    @IBInspectable var selectedTint: UIColor = UIColor.clear {
        didSet {
            UITabBar.appearance().tintColor = selectedTint
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedTint], for:UIControlState.selected)
        }
    }
    
    @IBInspectable var fontName: String = "" {
        didSet {
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: normalTint, NSFontAttributeName: UIFont(name: fontName, size: 11)!], for: UIControlState())
        }
    }
    
    @IBInspectable var firstSelectedImage: UIImage? {
        didSet {
            if let image = firstSelectedImage {
                var tabBarItems = self.tabBar.items as [UITabBarItem]!
                tabBarItems?[0].selectedImage = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            }
        }
    }
    
    @IBInspectable var secondSelectedImage: UIImage? {
        didSet {
            if let image = secondSelectedImage {
                var tabBarItems = self.tabBar.items as [UITabBarItem]!
                tabBarItems?[1].selectedImage = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            }
        }
    }
    
    @IBInspectable var thirdSelectedImage: UIImage? {
        didSet {
            if let image = thirdSelectedImage {
                var tabBarItems = self.tabBar.items as [UITabBarItem]!
                tabBarItems?[2].selectedImage = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            }
        }
    }
    
    @IBInspectable var fourthSelectedImage: UIImage? {
        didSet {
            if let image = fourthSelectedImage {
                var tabBarItems = self.tabBar.items as [UITabBarItem]!
                tabBarItems?[3].selectedImage = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            }
        }
    }
    
    @IBInspectable var fifthSelectedImage: UIImage? {
        didSet {
            if let image = fifthSelectedImage {
                var tabBarItems = self.tabBar.items as [UITabBarItem]!
                tabBarItems?[4].selectedImage = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in self.tabBar.items as [UITabBarItem]! {
            if let image = item.image {
                item.image = image.imageWithColor(tintColor: self.normalTint).withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            }
        }
    }
}

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0);
        context!.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context!.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
