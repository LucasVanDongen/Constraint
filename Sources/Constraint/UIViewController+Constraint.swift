//
//  UIViewController+Constraint.swift
//  Constraint
//
//  Created by Lucas van Dongen on 03/02/2025.
//

import UIKit

extension UIViewController {
    @discardableResult
    /**
     Adds the UIViewController as a sub viewcontroller to the the viewcontroller you specify.
     It includes the whole attachment cycle and view nesting

     - parameters:
     - viewController: the `UIViewController` to add this viewcontroller as a sub viewcontroller to

     - Returns: a reference to the child view you just attached for further layout modifiers
     */
    public func embed(viewController: UIViewController) -> UIView {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        return viewController.view
    }

    @discardableResult
    /**
     Adds the UIViewController as a sub viewcontroller to the the viewcontroller you specify.
     It includes the whole attachment cycle and view nesting.

     Use this variant if you are adding the  root`view` of the  child`viewController` to a different view than the root `view` of the parent `UIViewController`

     - parameters:
     - viewController: the `UIViewController` to add this viewcontroller as a sub viewcontroller to
     - parentView: the `UIView` you are attaching the `viewController`'s root `view` to

     - Returns: a reference to the child view you just attached for further layout modifiers
     */
    public func embed(viewController: UIViewController,
                      in parentView: UIView) -> UIView {
        addChild(viewController)
        parentView.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        return viewController.view
    }
}
