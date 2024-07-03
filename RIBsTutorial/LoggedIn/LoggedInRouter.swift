//
//  LoggedInRouter.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener, TicTacToeListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         offGameBuilder: OffGameBuildable,
         ticTacToeBuilder: TicTacToeBuildable) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        attachOffGame()
    }

    // MARK: - LoggedInRouting

    func cleanupViews() {
        if let currentChild = currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }

    func routeToTicTacToe() {
        detachCurrentChild()
        attachTicTacToe()
    }

    func routeToOffGame() {
        detachCurrentChild()
        attachOffGame()
    }

    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable
    private let ticTacToeBuilder: TicTacToeBuildable

    private var currentChild: ViewableRouting?

    private func attachOffGame() {
        let offGame = offGameBuilder.build(withListener: interactor)
        self.currentChild = offGame
        attachChild(offGame)
        let viewControllable = offGame.viewControllable
        viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        viewController.present(viewController: viewControllable)
    }
    
    private func attachTicTacToe() {
        let ticTacToe = ticTacToeBuilder.build(withListener: interactor)
        self.currentChild = ticTacToe
        attachChild(ticTacToe)
        let viewControllable = ticTacToe.viewControllable
        viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        viewController.present(viewController: viewControllable)
    }

    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
}
