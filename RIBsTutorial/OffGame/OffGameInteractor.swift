//
//  OffGameInteractor.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import RIBs
import RxSwift

protocol OffGameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }
    func set(score: Score)
}

protocol OffGameListener: AnyObject {
    func startTicTacToe()
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {

    weak var router: OffGameRouting?

    weak var listener: OffGameListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: OffGamePresentable,
         scoreStream: ScoreStream) {
        self.scoreStream = scoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        updateScore()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    private func updateScore() {
        scoreStream.score
            .subscribe(onNext: { (score: Score) in
                self.presenter.set(score: score)
            })
            .disposeOnDeactivate(interactor: self)
    }
    // MARK: - OffGamePresentableListener

    func startGame() {
        listener?.startTicTacToe()
    }

    private let scoreStream: ScoreStream
}
