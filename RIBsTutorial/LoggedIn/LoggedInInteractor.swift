//
//  LoggedInInteractor.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import RIBs
import RxSwift

enum PlayerType: Int {
    case player1 = 1
    case player2
}

protocol LoggedInRouting: Routing {
    func cleanupViews()
    func routeToTicTacToe()
    func routeToOffGame()
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(mutableScoreStream: MutableScoreStream) {
        self.mutableScoreStream = mutableScoreStream
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }

    // MARK: - OffGameListener

    func startTicTacToe() {
        router?.routeToTicTacToe()
    }

    // MARK: - TicTacToeListener

    func gameDidEnd(withWinner winner: PlayerType?) {
        if let winner = winner {
            mutableScoreStream.updateScore(withWinner: winner)
        }
        router?.routeToOffGame()
    }

    private let mutableScoreStream: MutableScoreStream

}
