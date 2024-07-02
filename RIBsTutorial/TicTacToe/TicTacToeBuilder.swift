//
//  TicTacToeBuilder.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import RIBs

protocol TicTacToeDependency: Dependency {
    var player1Name: String { get }
    var player2Name: String { get }
}

final class TicTacToeComponent: Component<TicTacToeDependency> {

    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }

}

// MARK: - Builder

protocol TicTacToeBuildable: Buildable {
    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting
}

final class TicTacToeBuilder: Builder<TicTacToeDependency>, TicTacToeBuildable {

    override init(dependency: TicTacToeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting {
        let component = TicTacToeComponent(dependency: dependency)
        let viewController = TicTacToeViewController(player1Name: component.player1Name,
                                                     player2Name: component.player2Name)
        let interactor = TicTacToeInteractor(presenter: viewController)
        interactor.listener = listener
        return TicTacToeRouter(interactor: interactor, viewController: viewController)
    }
}
