//
//  PlayerType.swift
//  RIBsTutorial
//
//  Created by yotahara on 2024/07/02.
//

import UIKit

enum PlayerType: String {
    case player1 = "X"
    case player2 = "O"
    case none = ""  // 引き分け
}

extension PlayerType {

//    var color: UIColor {
//        switch self {
//        case .player1:  UIColor.systemGray6
//        case .player2: UIColor.systemGray2
//        case .none: UIColor.clear
//        }
//    }
    
    var mark: String {
        switch self {
        case .player1: "⭕"
        case .player2: "❌"
        case .none: ""
        }
    }
}
