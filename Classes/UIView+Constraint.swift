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
    public func snap(inside parentView: UIView,
                     offset: CGFloat = 0) -> UIView {
        Constraint.snap(self, inside: parentView, offset: offset)
        return self
    }

    @discardableResult
    public func attach(inside containingView: UIView? = nil,
                       top: Offset? = nil,
                       left: Offset? = nil,
                       bottom: Offset? = nil,
                       right: Offset? = nil) -> UIView {
        guard top != nil || left != nil || bottom != nil || right != nil else {
            assertionFailure("At least one Offset should be specified")
            return self
        }

        let viewToAttachInto: UIView
        if let containingView = containingView {
            viewToAttachInto = containingView
        } else {
            guard let superview = superview else {
                assertionFailure("You should either specify the containing view or have a superview set")
                return self
            }

            viewToAttachInto = superview
        }

        Constraint.attach(view: self,
                          inside: viewToAttachInto,
                          top: top,
                          left: left,
                          bottom: bottom,
                          right: right)

        return self
    }

    @discardableResult
    public func attach(inside containingView: UIView? = nil,
                       topOffset: CGFloat? = nil,
                       _ topRelation: Relation = .exactly,
                       withTopPriority topPriority: UILayoutPriority = .required,
                       leftOffset: CGFloat? = nil,
                       _ leftRelation: Relation = .exactly,
                       withLeftPriority leftPriority: UILayoutPriority = .required,
                       bottomOffset: CGFloat? = nil,
                       _ bottomRelation: Relation = .exactly,
                       withBottomPriority bottomPriority: UILayoutPriority = .required,
                       rightOffset: CGFloat? = nil,
                       _ rightRelation: Relation = .exactly,
                       withRightPriority rightPriority: UILayoutPriority = .required,
                       respecting layoutGuides: LayoutGuide = .none) -> UIView {
        let viewToAttachInto: UIView
        if let containingView = containingView {
            viewToAttachInto = containingView
        } else {
            guard let superview = superview else {
                assertionFailure("You should either specify the containing view or have a superview set")
                return self
            }

            viewToAttachInto = superview
        }

        Constraint.attach(self,
                          inside: viewToAttachInto,
                          topOffset: topOffset, topRelation, withTopPriority: topPriority,
                          leftOffset: leftOffset, leftRelation, withLeftPriority: leftPriority,
                          bottomOffset: bottomOffset, bottomRelation, withBottomPriority: bottomPriority,
                          rightOffset: rightOffset, rightRelation, withRightPriority: rightPriority,
                          respecting: layoutGuides)

        return self
    }

    @discardableResult
    public func center(in viewToCenterIn: UIView? = nil,
                       axis: CenterAxis = .both,
                       adjusted: CGFloat = 0.0,
                       priority: UILayoutPriority = UILayoutPriority.required) -> UIView {
        let parentView: UIView
        if let viewToCenterIn = viewToCenterIn {
            parentView = viewToCenterIn
        } else {
            guard let superview = superview else {
                assertionFailure("You should either specify the containing view or have a superview set")
                return self
            }
            parentView = superview
        }
        Constraint.center(self, in: parentView, axis: axis, adjusted: adjusted, priority: priority)

        return self
    }

    @discardableResult
    public func align(axis: CenterAxis,
                      to viewToAlignWith: UIView,
                      adjustment: CGFloat = 0.0) -> UIView {
        guard let superview = Constraint.determineSuperview(for: self, and: viewToAlignWith) else {
            assertionFailure("These views should share a common superview")
            return self
        }

        let constraints = Constraint.align(self,
                                           axis,
                                           to: viewToAlignWith,
                                           adjustment: adjustment)

        superview.addConstraints(constraints)

        return self
    }

    @discardableResult
    public func space(_ distance: CGFloat,
                      _ direction: SpaceDirection,
                      _ view: UIView,
                      _ relation: Relation = .exactly,
                      priority: UILayoutPriority = UILayoutPriority.required) -> UIView {
        guard let superview = Constraint.determineSuperview(for: self, and: view) else {
            assertionFailure("These views should share a common superview")
            return self
        }

        let firstView: UIView
        let secondView: UIView
        switch direction {
        case .above, .leftOf:
            firstView = self
            secondView = view
        case .below, .rightOf:
            firstView = view
            secondView = self
        }

        let constraints = Constraint.space(firstView,
                                           secondView,
                                           inDirection: direction.layoutDirection,
                                           distance: distance,
                                           relation,
                                           priority: priority)
        superview.addConstraints(constraints)

        return self
    }

    @discardableResult
    public func align(_ side: Side,
                      _ distance: CGFloat = 0,
                      to viewToAlignTo: UIView) -> UIView {
        guard let superview = self.superview,
            viewToAlignTo.superview != nil else {
                assertionFailure("No superview means nothing to attach the constraint to")
                return self
        }

        superview.addConstraint(Constraint.align(self, side, distance, to: viewToAlignTo))
        return self
    }

    @discardableResult
    public func ratio(of width: CGFloat,
                      to height: CGFloat = 1,
                      _ relation: Relation = .exactly,
                      priority: UILayoutPriority = UILayoutPriority.required) -> UIView {
        addConstraint(Constraint.ratio(of: self, width: width, relatedToHeight: height))

        return self
    }

    @discardableResult
    public func height(relatedTo otherView: UIView,
                       multiplied multiplier: CGFloat = 1.0,
                       adjusted adjustment: CGFloat) -> UIView {
        guard let viewToAddTo = try? Constraint.determineSharedNode(between: self, and: otherView) else {
            assertionFailure("They should share a node")
            return self
        }

        //let viewToAddTo = parentChild.parentView.superview.map { return $0 } ?? parentChild.parentView

        viewToAddTo.addConstraint(Constraint.height(of: self, relatedTo: otherView, multiplied: multiplier, adjusted: adjustment))

        return self
    }

    @discardableResult
    public func width(relatedTo otherView: UIView,
                      multiplied multiplier: CGFloat = 1.0,
                      adjusted adjustment: CGFloat = 0.0) -> UIView {
        guard let viewToAddTo = try? Constraint.determineSharedNode(between: self, and: otherView) else {
            assertionFailure("Either one of them should be the parent")
            return self
        }

        //let viewToAddTo = parentChild.parentView.superview.map { return $0 } ?? parentChild.parentView

        viewToAddTo.addConstraint(Constraint.width(of: self, relatedTo: otherView, multiplied: multiplier, adjusted: adjustment))

        return self
    }

    @discardableResult
    public func size(_ size: CGSize,
                     widthRelation: Relation = .exactly,
                     heightRelation: Relation = .exactly) -> UIView {
        addConstraints([
            Constraint.width(size.width, widthRelation, for: self),
            Constraint.height(size.height, heightRelation, for: self)
            ])

        return self
    }

    @discardableResult
    public func size(width: CGFloat,
                     _ widthRelation: Relation = .exactly,
                     height: CGFloat,
                     _ heightRelation: Relation = .exactly) -> UIView {
        addConstraints([
            Constraint.width(width, widthRelation, for: self),
            Constraint.height(height, heightRelation, for: self)
            ])

        return self
    }

    @discardableResult
    public func width(_ width: CGFloat, _ relation: Relation = .exactly, priority: UILayoutPriority = UILayoutPriority.required) -> UIView {
        addConstraints([
            Constraint.width(width, relation, for: self, priority: priority)
            ])

        return self
    }

    @discardableResult
    public func height(_ height: CGFloat,
                       _ relation: Relation = .exactly,
                       priority: UILayoutPriority = UILayoutPriority.required) -> UIView {
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
            attach(inside: view, leftOffset: 0, rightOffset: 0)
        case .left, .right:
            attach(inside: view, topOffset: 0, bottomOffset: 0)
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
