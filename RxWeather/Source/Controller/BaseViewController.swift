//
//  BaseViewController.swift
//
//  Created by dwKang on 2021/12/24.
//

import UIKit
import RxSwift

@objc protocol BaseViewControllerCustomizable {
    @objc optional func setupUI()
}

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
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
        self.view.backgroundColor = .systemBackground
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension BaseViewController: BaseViewControllerCustomizable {
    fileprivate func _setupUI() {
        (self as BaseViewControllerCustomizable).setupUI?()
    }
}
