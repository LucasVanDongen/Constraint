//
//  UIView+Constraint.swift
//  LiveCore
//
//  Created by Lucas van Dongen on 24/06/2018.
//  Copyright © 2018 Hollywood.com. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult
    /**
     Adds the UIView as a subview to the view you specify

     - parameters:
     - view: the view to add this view as a subview to

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func addedAsSubview(to view: UIView) -> Self {
        view.addSubview(self)
        return self
    }

    @discardableResult
    /**
     Adds the UIView as a subview to the view you specify

     - parameters:
     - stackView: the `UIStackView` to add this view as a subview to

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func addedAsArrangedSubview(to stackView: UIStackView) -> Self {
        stackView.addArrangedSubview(self)
        return self
    }

    @discardableResult
    @available(*, deprecated, renamed: "attach()", message: "Replaced by a simpler version of the function attach that does not ask for the parentView anymore")
    public func snap(inside parentView: UIView? = nil,
                     offset: CGFloat = 0) -> Self {
        guard let parentView = parentView ?? superview else {
            assertionFailure("This view should either be added to a superview or have a parentView specified")
            return self
        }

        Constraint.snap(self, inside: parentView, offset: offset)
        return self
    }

    @discardableResult
    /**
     Adds layouts that determine the offset of this view towards it's parent view

     - parameters:
       - offset: The amount of points this view will be inset in it's parentView
       - respectingLayoutGuides: Default it will attach to the edges of the parent view (value `false`). If you want it to attach to the layoutGuides for example to not be covered by the notch this should be set to `true`

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func attach(offset: CGFloat = 0, respectingLayoutGuides: Bool = false) -> Self {
        guard let superview = superview else {
            assertionFailure("This view should already have a superview")
            return self
        }

        Constraint.attach(self,
                          inside: superview,
                          offset: offset,
                          respectingLayoutGuides: respectingLayoutGuides)
        return self
    }

    @discardableResult
    @available(*, deprecated, renamed: "attach()", message: "Replaced by a simpler version of the function attach that does not ask for the containingView anymore")
    public func attach(inside containingView: UIView,
                       top: Offsetable? = nil,
                       leading: Offsetable? = nil,
                       bottom: Offsetable? = nil,
                       trailing: Offsetable? = nil) -> Self {
        Constraint.attach(self,
                          inside: containingView,
                          top: top,
                          leading: leading,
                          bottom: bottom,
                          trailing: trailing)

        return self
    }

    @discardableResult
    @available(*, deprecated, renamed: "attach(sides:_:)", message: "Replaced by a version that uses Offsetable instead")
    public func attach(sides: Set<Side>,
                       _ offset: CGFloat,
                       respectingLayoutGuides: Bool = false) -> Self {
        let offsetable: Offsetable = respectingLayoutGuides ? offset.layoutGuideRespecting : offset
        return attach(sides: sides, offsetable)
    }

    @discardableResult
    /**
     Adds layouts that determine the offset of this view towards it's parent view

     - parameters:
     - offset: An Offsetable value, like `0.orMore`

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func attach(_ offset: Offsetable = 0) -> Self {
        return attach(top: offset, leading: offset, bottom: offset, trailing: offset)
    }

    @discardableResult
    /**
     Adds layouts that determine the offset of this view towards it's parent view.
     This version is useful to copy `UIEdgeInsets` to real constraints.

     Note: it will map `left` to `leading` and `right` to `trailing`

     - parameters:
     - insets: `UIEdgeInsets` determining all of the insets

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func attach(with insets: UIEdgeInsets) -> Self {
        return attach(top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
    }

    @discardableResult
    /**
     Adds layouts that determine the offset of this view towards it's parent view

     This is a convenience function

     - parameters:
     - vertically: The offset that should be added at the `top` and `bottom` edge
     - horizontally: The offst that should be added at the `leading` and `trailing` edge

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func attach(vertically: Offsetable? = nil,
                       horizontally: Offsetable? = nil) -> Self {
        return attach(top: vertically, leading: horizontally, bottom: vertically, trailing: horizontally)
    }

    /**
     Adds layouts that determine the offset of this view towards it's parent view.

     This is a convenience function for giving the same offset to one or more sides in one line

     - parameters:
     - sides: Declare what sides should be included
     - offset: The amount of offset in Offsetable format, for example 8.orMore

     - Returns: a reference of the view you call this function on to allow chaining
     */
    @discardableResult
    public func attach(sides: Set<Side>,
                       _ offset: Offsetable = 0) -> Self {
        var top: Offsetable? = nil
        var leading: Offsetable? = nil
        var bottom: Offsetable? = nil
        var trailing: Offsetable? = nil

        sides.forEach { side in
            switch side {
            case .top:
                top = offset
            case .leading:
                leading = offset
            case .bottom:
                bottom = offset
            case .trailing:
                trailing = offset
            }
        }

        return attach(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    /**
     Adds layouts that determine the offset of this view towards it's parent view

     - parameters:
     - top: The amount of points this view will be inset from the top edge of it's parentView, for example 0.orMore
     - leading: The amount of points this view will be inset from the leading edge of it's parentView, for example 0.orMore
     - bottom: The amount of points this view will be inset from the bottom edge of it's parentView, for example 0.orMore
     - trailing: The amount of points this view will be inset from the trailing edge of it's parentView, for example 0.orMore

     - Returns: a reference of the view you call this function on to allow chaining
     */
    @discardableResult
    public func attach(top: Offsetable? = nil,
                       leading: Offsetable? = nil,
                       bottom: Offsetable? = nil,
                       trailing: Offsetable? = nil) -> Self {
        guard top != nil || leading != nil || bottom != nil || trailing != nil else {
            assertionFailure("At least one Offset should be specified")
            return self
        }

        guard let superview = superview else {
            assertionFailure("This view should already have a superview")
            return self
        }

        Constraint.attach(self,
                          inside: superview,
                          top: top,
                          leading: leading,
                          bottom: bottom,
                          trailing: trailing)

        return self
    }

    @discardableResult
    /**
     Adds layouts that centers the view on one or more axis of it's parent view

     - parameters:
     - axis: Can be `.x`, `.y` or `.both`
     - `relation`: Allows you to adjust the centering in a given direction
     - `adjusted`: The amount of points the center is shifted, a positive value means it's moving towards the trailing and/or bottom edge and a negative value will shift it top the top and/or leading edge
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func center(axis: CenterAxis = .both,
                       relation: NSLayoutConstraint.Relation = .equal,
                       adjusted: CGFloat = 0.0,
                       priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        guard let superview = superview else {
            assertionFailure("You should either specify the containing view or have a superview set")
            return self
        }

        Constraint.center(self, in: superview, axis: axis, relation: relation, adjusted: adjusted, priority: priority)

        return self
    }

    @discardableResult
    /**
     Adds layouts that centers the view to one or more axis of another view

     Note: Use the `center` function if you want to center this view inside of it's parent view

     - parameters:
     - axis: Can be `.x`, `.y` or `.both`
     - viewToAlignWith: The view you want to align it with
     - adjusted: The amount of points the center is shifted, a positive value means it's moving towards the trailing and/or bottom edge and a negative value will shift it top the top and/or leading edge
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func align(axis: CenterAxis,
                      to viewToAlignWith: UIView,
                      adjusted adjustment: CGFloat = 0.0,
                      priority: UILayoutPriority = .required) -> Self {
        guard let superview = try? Constraint.determineSharedSuperview(between: self, and: viewToAlignWith) else {
            assertionFailure("These views should share a common superview")
            return self
        }

        let constraints = Constraint.align(self,
                                           axis,
                                           to: viewToAlignWith,
                                           adjusted: adjustment,
                                           priority: priority)

        superview.addConstraints(constraints)

        return self
    }

    @discardableResult
    /**
     Adds layouts that adds a space between this view and another view

     - parameters:
     - direction: The direction where to space to, this can be `.below`, `.trailing`, `.above` or `.leading
     - view: The other view you're spacing off
     - relation: This can be `.exactly`, `.orLess` or `.orMore`
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func space(_ direction: SpaceDirection,
                      _ view: UIView,
                      _ relation: Relation = .exactly,
                      priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        return space(0, direction, view, relation, priority: priority)
    }

    @discardableResult
    /**
     Adds layouts that adds a space between this view and another view

     - parameters:
     - distance: The amount of points of distance between this view and the other view. A positive value will create a gap, a negative value will make the overlap
     - direction: The direction where to space to, this can be `.below`, `.trailing`, `.above` or `.leading
     - view: The other view you're spacing off
     - relation: This can be `.exactly`, `.orLess` or `.orMore`
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func space(_ distance: CGFloat,
                      _ direction: SpaceDirection,
                      _ view: UIView,
                      _ relation: Relation = .exactly,
                      priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        guard let superview = try? Constraint.determineSharedSuperview(between: self, and: view) else {
            assertionFailure("These views should share a common superview")
            return self
        }

        let firstView: UIView
        let secondView: UIView
        let finalRelation: Relation
        let finalDistance: CGFloat

        switch direction {
        case .above, .leading:
            firstView = self
            secondView = view
            finalRelation = relation
            finalDistance = distance
        case .below, .trailing:
            firstView = view
            secondView = self
            finalRelation = relation.reversed
            finalDistance = distance
        }

        let constraints = Constraint.space(firstView,
                                           secondView,
                                           inDirection: direction.layoutDirection,
                                           distance: finalDistance,
                                           finalRelation,
                                           priority: priority)
        superview.addConstraints(constraints)

        return self
    }

    @discardableResult
    /**
     Aligns one edge of this view with the same edge of another view.

     Note: use `attach` when you want to align the sides with the super view

     - parameters:
     - side: Can be `.top`, `.leading`, `.bottom` or `.trailing`
     - distance: The amount of points of space between the
     - viewToAlignWith: The view you want to align it with
     - adjusted: The amount of points the center is shifted, a positive value means it's moving towards the trailing and/or bottom edge and a negative value will shift it top the top and/or leading edge
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func align(_ side: Side,
                      _ distance: CGFloat = 0,
                      to viewToAlignTo: UIView) -> Self {
        guard let constraintParent = try? Constraint.determineSharedSuperview(between: self, and: viewToAlignTo) else {
            assertionFailure("Should have a common parent")
            return self
        }

        constraintParent.addConstraint(Constraint.align(self, side, distance, to: viewToAlignTo))
        return self
    }

    @discardableResult
    /**
     Aligns multiple edges of this view with the same edges of another view.

     Note: use `attach` when you want to align the sides with the super view

     - parameters:
     - sides: Can be `.top`, `.leading`, `.bottom` and/or `.trailing`
     - distance: The amount of points of space between the
     - viewToAlignWith: The view you want to align it with

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func align(_ sides: Set<Side>,
                      _ distance: CGFloat = 0,
                      to viewToAlignTo: UIView) -> Self {
        guard let constraintParent = try? Constraint.determineSharedSuperview(between: self, and: viewToAlignTo) else {
            assertionFailure("Should have a common parent")
            return self
        }

        for side in sides {
            constraintParent.addConstraint(Constraint.align(self, side, distance, to: viewToAlignTo))
        }

        return self
    }

    @discardableResult
    /**
     Aligns multiple edges of this view with the same edges of another view.

     Note: use `attach` when you want to align the sides with the super view
     ToDo: this seems a duplicate of the function above

     - parameters:
     - sides: Can be `.top`, `.leading`, `.bottom` and/or `.trailing`
     - distance: The amount of points of space between the
     - viewToAlignWith: The view you want to align it with

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func align(sides: Set<Side>,
                      _ distance: CGFloat = 0,
                      to viewToAlignTo: UIView) -> Self {
        guard let constraintParent = try? Constraint.determineSharedSuperview(between: self, and: viewToAlignTo) else {
            assertionFailure("Should have a common parent")
            return self
        }

        constraintParent.addConstraints(Constraint.align(self, sides, distance, to: viewToAlignTo))
        return self
    }

    @discardableResult
    /**
     Defines a ratio between widht and height for this view

     Note: this a convenience function allowing you to turn the size of for example a `UIImage` into constraints allowing it to scale without losing it's ratio

     - parameters:
     - ratio: contains width and height
     - relation: This can be `.exactly`, `.orLess` or `.orMore`
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func ratio(_ ratio: CGSize,
                      _ relation: Relation = .exactly,
                      priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        addConstraint(Constraint.ratio(of: self, width: ratio.width, relatedToHeight: ratio.height))

        return self
    }

    @discardableResult
    /**
     Defines a ratio between widht and height for this view

     - parameters:
     - width: The ratio of the width. If this would be 2.0 and the height would be 1.0 it would be twice as wide as it is tall
     - height: The ratio of the height. If this would be 2.0 and the width would be 1.0 it would be twice as tall as it is wide
     - relation: This can be `.exactly`, `.orLess` or `.orMore`
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func ratio(of width: CGFloat,
                      to height: CGFloat = 1,
                      _ relation: Relation = .exactly,
                      priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        addConstraint(Constraint.ratio(of: self, width: width, relatedToHeight: height))

        return self
    }

    @discardableResult
    /**
     Allows you to relate the height of this view to the height another view

     - parameters:
     - otherView: The view to relate to
     - multiplied: The multiplier applied to it's size. For example with a multiplier of 2.0 the height of the other view would be doubled
     - adjusted: It's possible to shift the multiplied value with a fixed value
     - relation: This can be `.exactly`, `.orLess` or `.orMore`
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func height(relatedTo otherView: UIView,
                       multiplied multiplier: CGFloat = 1.0,
                       adjusted adjustment: CGFloat = 0.0,
                       _ relation: Relation = .exactly,
                       priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        guard let viewToAddTo = try? Constraint.determineSharedSuperview(between: self, and: otherView) else {
            assertionFailure("They should share a node")
            return self
        }

        viewToAddTo.addConstraint(Constraint.height(of: self,
                                                    relatedTo: otherView,
                                                    multiplied: multiplier,
                                                    priority: priority,
                                                    adjusted: adjustment,
                                                    relation))

        return self
    }

    @discardableResult
    /**
     Allows you to relate the width of this view to the width of another view

     - parameters:
     - otherView: The view to relate to
     - multiplied: The multiplier applied to it's size. For example with a multiplier of 2.0 the width of the other view would be doubled
     - adjusted: It's possible to shift the multiplied value with a fixed value
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func width(relatedTo otherView: UIView,
                      multiplied multiplier: CGFloat = 1.0,
                      priority: UILayoutPriority = UILayoutPriority.required,
                      adjusted adjustment: CGFloat = 0.0,
                      _ relation: Relation = .exactly) -> Self {
        guard let viewToAddTo = try? Constraint.determineSharedSuperview(between: self, and: otherView) else {
            assertionFailure("Either one of them should be the parent")
            return self
        }

        viewToAddTo.addConstraint(Constraint.width(of: self,
                                                   relatedTo: otherView,
                                                   multiplied: multiplier,
                                                   priority: priority,
                                                   adjusted: adjustment,
                                                   relation))

        return self
    }

    @discardableResult
    /**
     Allows you to set the width and height of the view.

     Note: it's a shorthand function for `width` and `height` used to set the frame size to real constraints

     - parameters:
     - size: The size you want to set
     - widthRelation: This can be `.exactly`, `.orLess` or `.orMore`
     - heightRelation: This can be `.exactly`, `.orLess` or `.orMore`

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func size(_ size: CGSize,
                     widthRelation: Relation = .exactly,
                     heightRelation: Relation = .exactly) -> Self {
        addConstraints([
            Constraint.width(size.width, widthRelation, for: self),
            Constraint.height(size.height, heightRelation, for: self)
            ])

        return self
    }

    @discardableResult
    /**
     Allows you to set the width and height of the view.

     Note: it's a shorthand function for `width` and `height` used to set the frame size to real constraints

     - parameters:
     - width: The width you want to set
     - widthRelation: This can be `.exactly`, `.orLess` or `.orMore`
     - height: The height you want to set
     - heightRelation: This can be `.exactly`, `.orLess` or `.orMore`

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func size(width: CGFloat,
                     _ widthRelation: Relation = .exactly,
                     height: CGFloat,
                     _ heightRelation: Relation = .exactly) -> Self {
        addConstraints([
            Constraint.width(width, widthRelation, for: self),
            Constraint.height(height, heightRelation, for: self)
            ])

        return self
    }

    @discardableResult
    public func size(relatedTo otherView: UIView,
                     multiplied multiplier: CGFloat = 1.0,
                     priority: UILayoutPriority = UILayoutPriority.required,
                     adjusted adjustment: CGFloat = 0.0,
                     _ relation: Relation = .exactly) -> UIView {
        guard let viewToAddTo = try? Constraint.determineSharedSuperview(between: self, and: otherView) else {
            assertionFailure("Either one of them should be the parent")
            return self
        }

        viewToAddTo.addConstraints([
            Constraint.width(of: self, relatedTo: otherView, multiplied: multiplier, priority: priority, adjusted: adjustment, relation),
            Constraint.height(of: self, relatedTo: otherView, multiplied: multiplier, priority: priority, adjusted: adjustment, relation)
            ])

        return self
    }

    @discardableResult
    /**
     Allows you to set the width of the view.

     - parameters:
     - width: The width you want to set
     - relation: This can be `.exactly`, `.orLess` or `.orMore`
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func width(_ width: CGFloat,
                      _ relation: Relation = .exactly,
                      priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        addConstraints([
            Constraint.width(width, relation, for: self, priority: priority)
            ])

        return self
    }

    @discardableResult
    /**
     Allows you to set the height of the view.

     - parameters:
     - height: The width you want to set
     - relation: This can be `.exactly`, `.orLess` or `.orMore`
     - priority: The priority given to these constraints

     - Returns: a reference of the view you call this function on to allow chaining
     */
    public func height(_ height: CGFloat,
                       _ relation: Relation = .exactly,
                       priority: UILayoutPriority = UILayoutPriority.required) -> Self {
        addConstraints([
            Constraint.height(height, relation, for: self, priority: priority)
            ])

        return self
    }

    public func animatableToastConstraint(fromThe side: Side,
                                          in view: UIView,
                                          using spacer: UIView) -> NSLayoutConstraint {
        switch side {
        case .bottom, .top:
            attach(leading: 0, trailing: 0)
        case .leading, .trailing:
            attach(top: 0, bottom: 0)
        }

        space(0, side.spaceDirection, spacer, priority: UILayoutPriority(700))

        let animatableConstraint = NSLayoutConstraint(item: self,
                                                      attribute: side.spaceDirection.otherViewAttribute,
                                                      relatedBy: .equal,
                                                      toItem: spacer,
                                                      attribute: side.spaceDirection.otherViewAttribute,
                                                      multiplier: 1,
                                                      constant: 0)
        animatableConstraint.priority = UILayoutPriority.defaultLow

        view.addConstraint(animatableConstraint)

        return animatableConstraint
    }
}
