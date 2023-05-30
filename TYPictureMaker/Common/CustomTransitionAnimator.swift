//
//  File.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/30.
//

import UIKit

class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.5
    private let sourceView: UIView?
    private let isPresenting: Bool
    
    init(sourceView: UIView?, isPresenting: Bool) {
        self.sourceView = sourceView
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        toView.frame = containerView.bounds
        toView.alpha = 0.0
        
        if let sourceView = sourceView {
            containerView.addSubview(sourceView)
            // 对 sourceView 进行动画操作
            // 执行源视图的动画
            
            UIView.animate(withDuration: duration, animations: {
                if self.isPresenting {
                    sourceView.snp.remakeConstraints { make in
                        // 更新源视图的约束
                        make.centerX.equalToSuperview()
                        make.top.equalToSuperview().offset(100)
                        make.width.equalToSuperview()
                        make.height.equalTo(sourceView.snp.width)
                    }
                } else {
                    
                    sourceView.snp.remakeConstraints { make in
                        // 更新源视图的约束
                        make.centerX.equalToSuperview()
                        make.centerY.equalToSuperview().offset(-50)
                        make.width.equalToSuperview()
                        make.height.equalTo(sourceView.snp.width)
                    }
                }
                
                containerView.layoutIfNeeded()
            })
        }

        UIView.animate(withDuration: duration, animations: {
            fromView.alpha = 0.0
            toView.alpha = 1.0
        }) { (finished) in
            fromView.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if !self.isPresenting {
                // 将传递的视图添加到源视图控制器的视图上
                if let fromViewController = transitionContext.viewController(forKey: .to) as? SourceViewController {
                    fromViewController.view.addSubview(self.sourceView!)
                }
                if let fromViewController = transitionContext.viewController(forKey: .to) as? UINavigationController {
                    fromViewController.visibleViewController?.view.addSubview(self.sourceView!)
                }
                self.sourceView!.snp.remakeConstraints { make in
                    // 更新源视图的约束
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview().offset(-50)
                    make.width.equalToSuperview()
                    make.height.equalTo(self.sourceView!.snp.width)
                }
            }
        }
    }

}

