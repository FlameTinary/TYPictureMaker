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
    
    init(sourceView: UIView?, isPresenting: Bool) {
        self.sourceView = sourceView
        self.isPresenting = isPresenting
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
            if isPresenting {
                sourceView.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview().offset(-50)
                    make.width.equalToSuperview()
                    make.height.equalTo(sourceView.snp.width)
                }
            }
            
            UIView.animate(withDuration: duration) {
                if self.isPresenting {
                    sourceView.snp.updateConstraints { make in
                        // 更新源视图的约束
                        make.centerY.equalToSuperview().offset(-150)
                    }
                } else {
                    sourceView.snp.updateConstraints { make in
                        // 更新源视图的约束
                        make.centerY.equalToSuperview().offset(-50)
                    }
                }
                containerView.layoutIfNeeded()
            }
            
        }
        
        
        
        UIView.animate(withDuration: duration) {
            toView.alpha = 1.0
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            if !self.isPresenting {
                if let sourceView = self.sourceView {
                    toView.addSubview(sourceView)
                    sourceView.snp.remakeConstraints { make in
                        // 更新源视图的约束
                        make.centerX.equalToSuperview()
                        make.centerY.equalToSuperview().offset(-50)
                        make.width.equalToSuperview()
                        make.height.equalTo(sourceView.snp.width)
                    }
                }
            }
        }
    }

}

