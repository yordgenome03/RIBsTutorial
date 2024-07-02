//
//  LoggedInComponent+OffGame.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedIn to provide for the OffGame scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencyOffGame: Dependency {

    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the OffGame scope.
}

extension LoggedInComponent: OffGameDependency {
    var scoreStream: ScoreStream {
        return mutableScoreStream
    }
}
