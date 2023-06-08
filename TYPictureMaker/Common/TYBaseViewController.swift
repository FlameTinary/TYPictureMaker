//
//  TYBaseController.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/24.
//

import UIKit

class TYBaseViewController : UIViewController {
    
    private lazy var backButton : UIBarButtonItem = {
        // 设置导航栏返回图标
        let item = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(back))
        item.tintColor = .white
        self.navigationItem.leftBarButtonItem = item
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 当前控制器有导航栈，且是栈中的第一个控制器，就不显示返回按钮
        if !(navigationController?.viewControllers.first is Self) {
            showBackButton()
        } else {
            hiddenBackButton()
        }
        
        setupSubviews()
        
        
        
    }
    
    func setupSubviews() {
        
    }
    
    func showBackButton() {
        if #available(iOS 16.0, *) {
            backButton.isHidden = false
        } else {
            // Fallback on earlier versions
            navigationItem.leftBarButtonItem = backButton
        }
    }
    
    func hiddenBackButton() {
        if #available(iOS 16.0, *) {
            backButton.isHidden = true
        } else {
            // Fallback on earlier versions
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
