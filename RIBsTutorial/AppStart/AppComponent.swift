//
//  AppDelegate.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
