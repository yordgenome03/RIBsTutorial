//
//  RootViewController.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import RIBs

protocol LoggedOutDependency {}

protocol LoggedOutListener {}

protocol LoggedOutBuildable {
    func build(withListener: LoggedOutListener) -> ViewableRouting
}

class LoggedOutInteractor: Interactor {}

class LoggedOutViewController: UIViewController, ViewControllable {
}

class LoggedOutBuilder: LoggedOutBuildable {
    init(dependency: Any) {}
    func build(withListener: LoggedOutListener) -> ViewableRouting {
        return ViewableRouter<Interactable, ViewControllable>(interactor: LoggedOutInteractor(), viewController: LoggedOutViewController())
    }
}
