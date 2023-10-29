//
//  TYOprationEditController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/23.
//

import UIKit
import SnapKit

class TYOprationEditController : TYBaseViewController {
    
    var editInfo : TYEditInfo
    
    lazy var editView : TYBaseEditView = {
        let editView = editInfo.layout.toEditView(images: editInfo.filter != .none ? editInfo.filterImages : editInfo.images)
        editView.size = CGSize(width: view.width, height: editInfo.proportion.heightFrom(width: view.width))
        editView.center = view.center
        editView.padding = CGFloat(editInfo.borderCorner.pictureBorder)
        editView.imagePandding = CGFloat(editInfo.borderCorner.imageBorder)
        editView.imageCornerRadio = CGFloat(editInfo.borderCorner.imageCornerRadio)
        editView.backgroundColor = editInfo.backgroundColor.color()
        editView.backgroundImage = editInfo.backgroundImage
        return editView
    }()
    
    var aleatHeight : CGFloat {
        get {
            return 150
        }
    }
    
    lazy var alertView : TYOprationAlertView = {
        let view = TYOprationAlertView()
//        _ = view.closeObserver.takeUntil(rx.deallocated).subscribe(onNext: {_ in
//            self.hiddenAlertView { isFinished in
//                self.dismiss(animated: true)
//            }
//        })
        return view
    }()
    
    init(editInfo : TYEditInfo) {
        self.editInfo = editInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
    }
    
    override func setupSubviews() {
        view.addSubview(editView)
        view.addSubview(alertView)
        
        alertView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(aleatHeight)
            make.bottom.equalTo(aleatHeight)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlertView()
    }

    
}

extension TYOprationEditController {
    
    func showAlertView(finished: ((Bool) -> Void)? = nil) {
        alertView.snp.updateConstraints { make in
            make.bottom.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn, .overrideInheritedDuration]) {
            self.view.layoutIfNeeded()
        } completion: { isFinished in
            if let finished = finished {
                finished(isFinished)
            }
        }
    }
    
    func hiddenAlertView(finished: ((Bool) -> Void)? = nil) {
        
        self.alertView.snp.updateConstraints { make in
            make.bottom.equalTo(self.alertView.height)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseIn]) {
            self.view.layoutIfNeeded()
        } completion: { isFinished in
            if let finished = finished {
                finished(isFinished)
            }
        }
    }
    
}

extension TYPictureStitchController : UIViewControllerTransitioningDelegate {
    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        hiddenAlertView()
        
        let sourceVC = source as! TYOprationEditController
        return CustomTransitionAnimator(sourceView: sourceVC.editView, isPresenting: true)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let dismissVC = dismissed as! TYOprationEditController
        
        return CustomTransitionAnimator(sourceView: dismissVC.editView, isPresenting: false) {
            
            self.editView = dismissVC.editView
            self.editInfo = dismissVC.editInfo
            self.view.addSubview(self.editView)
            
            self.showAlertView()
        }
    }
}
