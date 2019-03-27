//
//  [UIView]+Constraint.swift
//  Constraint
//
//  Created by Lucas van Dongen on 19/02/2019.
//

import UIKit

extension Array where Element: UIView {

    /**
     Shorthand method to add an array of views as subviews to a certain view.

     - parameters:
     - view: View that adds all views in this Array to a itself as subviews

     Note: It can also be done by using `.forEach(view.addSubview(_:)) directly

     - Returns: an array of the views you called this function on to allow chaining
     **/
    @discardableResult
    public func addedAsSubviews(to view: UIView) -> [Element] {
        self.forEach(view.addSubview(_:))
        return self
    }

    /**
     Used for spacing views an equal distance either horizontally or vertically. The direction will be below (so top-to-bottom from first to last item) for vertically and leading-to-trailing for horizontally

     - parameters:
     - distance: spacing in points
     - direction: can be `.horizontally` or `.vertically`
     - relation: This can be `.exactly`, `.orLess` or `.orMore`
     - priority: The priority given to these constraints

     - Returns: an array of the views you called this function on to allow chaining
     */
    @discardableResult
    public func space(_ distance: CGFloat = 0.0,
                      _ direction: LayoutDirection,
                      relation: Relation = .exactly,
                      priority: UILayoutPriority = .required) -> [Element] {
        self.reduce(nil) { (previousView: Element?, view: Element) -> Element? in
            guard let viewToSpaceOff = previousView else {
                return view
            }

            view.space(distance, direction.spaceDirection, viewToSpaceOff, relation, priority: priority)
            return view
        }

        return self
    }

    /**
     Used for spacing views an equal distance either horizontally or vertically. The direction will be below (so top-to-bottom from first to last item) for vertically and leading-to-trailing for horizontally

     - Note: this is a convenience function for having 0 distance

     - parameters:
     - direction: can be `.horizontally` or `.vertically`
     - relation: This can be `.exactly`, `.orLess` or `.orMore`
     - priority: The priority given to these constraints

     - Returns: an array of the views you called this function on to allow chaining
     */
    @discardableResult
    public func space(_ direction: LayoutDirection,
                      relation: Relation = .exactly,
                      priority: UILayoutPriority = .required) -> [Element] {
        return self.space(0, direction)
    }

    /**
     Adds layouts that determine the offset of these views towards their parent view

     - parameters:
     - top: The amount of points these views will be inset from the top edge of their parentView, for example 0.orMore
     - leading: The amount of points these views will be inset from the leading edge of their parentView, for example 0.orMore
     - bottom: The amount of points these views will be inset from the bottom edge of their parentView, for example 0.orMore
     - trailing: The amount of points these views will be inset from the trailing edge of their parentView, for example 0.orMore

     - Returns: an array of the views you called this function on to allow chaining
     */
    @discardableResult
    public func attach(top: Offsetable? = nil,
                       leading: Offsetable? = nil,
                       bottom: Offsetable? = nil,
                       trailing: Offsetable? = nil) -> [Element] {
        self.forEach { $0.attach(top: top, leading: leading, bottom: bottom, trailing: trailing) }
        return self
    }
}
