//
//  TicTacToeViewController.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import RIBs
import SnapKit
import UIKit

protocol TicTacToePresentableListener: AnyObject {
    func placeCurrentPlayerMark(atRow row: Int, col: Int)
}

final class TicTacToeViewController: UIViewController, TicTacToePresentable, TicTacToeViewControllable {
    
    weak var listener: TicTacToePresentableListener?
    
    init(player1Name: String,
         player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        buildCollectionView()
    }
    
    // MARK: - TicTacToePresentable
    
    func setCell(atRow row: Int, col: Int, withPlayerType playerType: PlayerType) {
        let indexPathRow = row * GameConstants.colCount + col
        if let cell = collectionView.cellForItem(at: IndexPath(row: indexPathRow, section: Constants.sectionCount - 1)) as? TicTacToeCell {
            cell.setMark(playerType.mark)
        }
    }
    
    
    func announce(winner: PlayerType, withCompletionHandler handler: @escaping () -> ()) {
        let winnerString: String = {
            switch winner {
            case .player1:
                return "\(player1Name) Won!"
            case .player2:
                return "\(player2Name) Won!"
            case .none:
                return "It's a Tie"
            }
        }()
        let alert = UIAlertController(title: winnerString, message: nil, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close Game", style: UIAlertAction.Style.default) { _ in
            handler()
        }
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private
    
    private let player2Name: String
    private let player1Name: String
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: Constants.cellSize, height: Constants.cellSize)
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()
    
    private func buildCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TicTacToeCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.center.equalTo(self.view.snp.center)
            maker.size.equalTo(CGSize(width: CGFloat(GameConstants.colCount) * Constants.cellSize, height: CGFloat(GameConstants.rowCount) * Constants.cellSize))
        }
    }
}

fileprivate struct Constants {
    static let sectionCount = 1
    static let cellSize: CGFloat = UIScreen.main.bounds.width / CGFloat(GameConstants.colCount)
    static let cellIdentifier = "TicTacToeCell"
    static let defaultColor = UIColor.white
}

extension TicTacToeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameConstants.rowCount * GameConstants.colCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! TicTacToeCell
        cell.reset()
        return cell
    }
    
    private func reset(cell: UICollectionViewCell) {
        cell.backgroundColor = Constants.defaultColor
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
}

// MARK: - UICollectionViewDelegate

extension TicTacToeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row / GameConstants.colCount
        let col = indexPath.row - row * GameConstants.rowCount
        listener?.placeCurrentPlayerMark(atRow: row, col: col)
    }
}

// MARK: - TicTacToeCell

class TicTacToeCell: UICollectionViewCell {
    
    let markLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(markLabel)
        markLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMark(_ mark: String) {
        markLabel.text = mark
    }
    
    func reset() {
        markLabel.text = nil
        backgroundColor = Constants.defaultColor
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
