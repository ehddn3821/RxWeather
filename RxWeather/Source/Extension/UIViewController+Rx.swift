//
//  UIViewController+Rx.swift
//
//  Created by dwKang on 2023-02-09.
//

import UIKit
import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        ControlEvent(events: self.methodInvoked(#selector(Base.viewDidLoad)).map{ _ in })
    }
    
    var viewWillAppear: ControlEvent<Bool> {
        ControlEvent(events: self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false })
    }
    
    var viewDidAppear: ControlEvent<Bool> {
        ControlEvent(events: self.methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false })
    }
    
    var viewWillDisappear: ControlEvent<Bool> {
        ControlEvent(events: self.methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false })
    }
    
    var viewDidDisappear: ControlEvent<Bool> {
        ControlEvent(events: self.methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false })
    }
    
    var viewWillLayoutSubviews: ControlEvent<Void> {
        ControlEvent(events: self.methodInvoked(#selector(Base.viewWillLayoutSubviews)).map { _ in })
    }
    
    var viewDidLayoutSubviews: ControlEvent<Void> {
        ControlEvent(events: self.methodInvoked(#selector(Base.viewDidLayoutSubviews)).map { _ in })
    }
    
    var willMoveToParentViewController: ControlEvent<UIViewController?> {
        ControlEvent(events: self.methodInvoked(#selector(Base.willMove)).map { $0.first as? UIViewController })
    }
    
    var didMoveToParentViewController: ControlEvent<UIViewController?> {
        ControlEvent(events: self.methodInvoked(#selector(Base.didMove)).map { $0.first as? UIViewController })
    }
    
    var didReceiveMemoryWarning: ControlEvent<Void> {
        ControlEvent(events: self.methodInvoked(#selector(Base.didReceiveMemoryWarning)).map { _ in })
    }
    
    /// Rx observable, triggered when the ViewController appearance state changes (true if the View is being displayed, false otherwise)
    var isVisible: Observable<Bool> {
        let viewDidAppearObservable = self.base.rx.viewDidAppear.map { _ in true }
        let viewWillDisappearObservable = self.base.rx.viewWillDisappear.map { _ in false }
        return Observable<Bool>.merge(viewDidAppearObservable, viewWillDisappearObservable)
    }

    /// Rx observable, triggered when the ViewController is being dismissed
    var isDismissing: ControlEvent<Bool> {
        ControlEvent(events: self.sentMessage(#selector(Base.dismiss)).map { $0.first as? Bool ?? false })
    }
}

