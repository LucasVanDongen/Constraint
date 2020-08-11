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
     Shorthand method to add an array of views as subviews to a certain view.

     - parameters:
        - `stackView`: `UIStackView` that adds all views in this Array to a itself as subviews

     Note: It can also be done by using `.forEach(view.addSubview(_:)) directly

     - Returns: an array of the views you called this function on to allow chaining
     **/
    @discardableResult
    public func addedAsArrangedSubviews(to stackView: UIStackView) -> [Element] {
        self.forEach(stackView.addArrangedSubview(_:))
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
        _ = self.reduce(nil) { (previousView: Element?, view: Element) -> Element? in
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

    /**
     Allows you to set the width of these views.

     - parameters:
         - width: The width you want to set
         - relation: This can be `.exactly`, `.orLess` or `.orMore`
         - priority: The priority given to these constraints

     - Returns: an array of the views you called this function on to allow chaining
     */
    @discardableResult
    public func width(_ width: CGFloat,
                      _ relation: Relation = .exactly,
                      priority: UILayoutPriority = UILayoutPriority.required) -> [Element] {
        self.forEach { $0.width(width, relation, priority: priority) }
        return self
    }

    /**
     Allows you to set the height of these views.

     - parameters:
         - height: The width you want to set
         - relation: This can be `.exactly`, `.orLess` or `.orMore`
         - priority: The priority given to these constraints

     - Returns: an array of the views you called this function on to allow chaining
     */
    @discardableResult
    public func height(_ height: CGFloat,
                       _ relation: Relation = .exactly,
                       priority: UILayoutPriority = UILayoutPriority.required) -> [Element] {
        self.forEach { $0.height(height, relation, priority: priority) }
        return self
    }

    /**
     Defines a ratio between widht and height for these views

     - parameters:
         - width: The ratio of the width. If this would be 2.0 and the height would be 1.0 it would be twice as wide as it is tall
         - height: The ratio of the height. If this would be 2.0 and the width would be 1.0 it would be twice as tall as it is wide
         - relation: This can be `.exactly`, `.orLess` or `.orMore`
         - priority: The priority given to these constraints

     - Returns: an array of the views you called this function on to allow chaining
     */
    @discardableResult
    public func ratio(of width: CGFloat,
                      to height: CGFloat = 1,
                      _ relation: Relation = .exactly,
                      priority: UILayoutPriority = UILayoutPriority.required) -> [Element] {
        self.forEach { $0.ratio(of: width, to: height, relation, priority: priority) }
        return self
    }

    /**
     Allows you to relate the width of these views to the width of a view

     - parameters:
         - otherView: The view to relate to
         - multiplied: The multiplier applied to it's size. For example with a multiplier of 2.0 the width of the other view would be doubled
         - adjusted: It's possible to shift the multiplied value with a fixed value
         - priority: The priority given to these constraints

     - Returns: an array of the views you called this function on to allow chaining
     */
    @discardableResult
    public func width(relatedTo otherView: UIView,
                      multiplied multiplier: CGFloat = 1.0,
                      priority: UILayoutPriority = UILayoutPriority.required,
                      adjusted adjustment: CGFloat = 0.0,
                      _ relation: Relation = .exactly) -> [Element] {
        self.forEach { $0.width(relatedTo: otherView, multiplied: multiplier, priority: priority, adjusted: adjustment, relation) }
        return self
    }

    /**
     Allows you to relate the height of these views to the height of all views

     - parameters:
         - otherView: The view to relate to
         - multiplied: The multiplier applied to it's size. For example with a multiplier of 2.0 the height of the other view would be doubled
         - adjusted: It's possible to shift the multiplied value with a fixed value
         - priority: The priority given to these constraints

     - Returns: an array of the views you called this function on to allow chaining
     */
    @discardableResult
    public func height(relatedTo otherView: UIView,
                       multiplied multiplier: CGFloat = 1.0,
                       priority: UILayoutPriority = UILayoutPriority.required,
                       adjusted adjustment: CGFloat = 0.0,
                       _ relation: Relation = .exactly) -> [Element] {
        self.forEach { $0.height(relatedTo: otherView, multiplied: multiplier, adjusted: adjustment, relation, priority: priority) }
        return self
    }

    /**
     Allows you to set the width and height of all views

     - parameters:
        - size: The size to set it to

     - Returns: an array of the views you called this function on to allow chaining
     */
    @discardableResult
    public func size(_ size: CGSize) -> [Element] {
        self.forEach { ($0 as UIView).size(size) }
        return self
    }
}
