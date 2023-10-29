//
//  SourceViewController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/30.
//

import UIKit
//import RxSwift
//import RxCocoa

class SourceViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    private lazy var transformView : UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    private lazy var transformBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("转场动画", for: .normal)
        btn.setTitleColor(.red, for: .normal)
//        _ = btn.rx.tap.takeUntil(self.rx.deallocated).subscribe {[weak self] event in
//            self!.presentDestinationViewController()
//        }
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(transformBtn)
        view.addSubview(transformView)
        transformBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        transformView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
    }
    
    // ...
    
    func presentDestinationViewController() {
        let destinationViewController = DestinationViewController()
        destinationViewController.sourceView = transformView
        destinationViewController.transitioningDelegate = self
        destinationViewController.modalPresentationStyle = .fullScreen
        destinationViewController.passViewClosure = { [weak self] view in
            self?.transformView = view
            view.backgroundColor = .cyan
        }
        present(destinationViewController, animated: true, completion: nil)
    }
    
    // 实现UIViewControllerTransitioningDelegate的方法
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimator(sourceView: transformView, isPresenting: true)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimator(sourceView: transformView, isPresenting: false)
    }
}
