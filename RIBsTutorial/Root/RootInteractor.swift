//
//  RootInteractor.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String)
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?

    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - LoggedOutListener

    func didLogin(withPlayer1Name player1Name: String, player2Name: String) {
        router?.routeToLoggedIn(withPlayer1Name: player1Name, player2Name: player2Name)
    }
}
