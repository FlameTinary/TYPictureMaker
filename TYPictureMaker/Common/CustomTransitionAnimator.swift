//
//  File.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/30.
//

import UIKit

class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    let duration: TimeInterval = 0.5
    var animationDidFinished : (()-> Void)?
    private let sourceView: UIView?
    private let isPresenting: Bool
    
    init(sourceView: UIView?, isPresenting: Bool, finished: (()-> Void)? = nil) {
        self.sourceView = sourceView
        self.isPresenting = isPresenting
        animationDidFinished = finished
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toView = transitionContext.view(forKey: .to) else {
                  
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
                  
        }
        
        let containerView = transitionContext.containerView
        
        // 添加目标视图控制器的视图到容器视图
        containerView.addSubview(toView)
        toView.frame = containerView.bounds
        toView.alpha = 0.0
        
        // 添加视图到目标控制器视图
        if let sourceView = self.sourceView {
            containerView.addSubview(sourceView)
            
            UIView.animate(withDuration: duration) {
                if self.isPresenting {
                    sourceView.centerY = containerView.centerY - 80
                } else {
                    sourceView.centerY = containerView.centerY - 30
                }
            }
            
        }
        
        
        
        UIView.animate(withDuration: duration) {
            toView.alpha = 1.0
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        if let finished = animationDidFinished {
            finished()
        }
    }
}

