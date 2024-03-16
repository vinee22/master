//
//  CustomPushAnimator.swift
//  SwiftHire
//
//  Created by HS on 15/03/24.
//

import Foundation
import UIKit

class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // Return the duration of the transition animation
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Implement the transition animation
        // You can use transitionContext to get the fromView, toView, containerView, etc.
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        
        // Set the initial state of the toView if needed
        toViewController.view.frame = finalFrame
        toViewController.view.alpha = 0.0
        
        // Add the toView to the containerView
        containerView.addSubview(toViewController.view)
        
        // Perform the animation
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            toViewController.view.alpha = 1.0
        } completion: { _ in
            // Notify the transition context of the completion
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
