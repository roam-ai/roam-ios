//
//  UIViewController+Hud.swift
//  CareUI
//
//  Created by Pavel Zhuravlev on 3/1/17.
//  Copyright © 2017 Care.com. All rights reserved.
//

import UIKit

private var hudViewAssociatedKey: UInt8 = 0

public extension UIViewController {
    
    var hudView: HudView? {
        get {
            return objc_getAssociatedObject(self, &hudViewAssociatedKey) as? HudView
        }
        set {
            objc_setAssociatedObject(self, &hudViewAssociatedKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    func showHud() {
        DispatchQueue.main.async {
            self.showHud(withBackground: .white)
        }
    }
    
    func showHud(withBackground backgroundColor: UIColor? = .white) {
        
        removeHudIfPresent()
        
        hudView = HudView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        hudView?.backgroundColor = backgroundColor
        hudView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hudView!)
        hudView!.cr_fillContainerWithInsets(.zero)
        hudView!.startProgress()
    }
    
    func dismissHud(withCompletion completionBlock: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if let hudView = self.hudView {
                UIView.animate(withDuration: 0.25, animations: {
                    hudView.alpha = 0
                }, completion: { (isValue) in
                    self.removeHudIfPresent()
                })
            }
        }
    }
    
    private func removeHudIfPresent() {
        if let hudView = hudView {
            hudView.removeFromSuperview()
            self.hudView = nil
        }
    }
    
}

