//
//  BaseViewController.swift
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

@objc protocol BaseViewControllerCustomizable {
    @objc optional func setupUI()
}

class BaseViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.info("\(type(of: self)): viewDidLoad")
        _setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Log.info("\(type(of: self)): viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Log.info("\(type(of: self)): viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Log.info("\(type(of: self)): viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Log.info("\(type(of: self)): viewDidDisappear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    deinit {
        Log.info("\(type(of: self)): deinit")
    }
}

extension BaseViewController: BaseViewControllerCustomizable {
    fileprivate func _setupUI() {
        (self as BaseViewControllerCustomizable).setupUI?()
    }
}
