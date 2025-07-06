//
//  Cell.swift
//  TicTacToe0
//
//  Created by 澄界 on 2025/07/06.
//

import Foundation
import SwiftUI

struct Cell {
    var tile: Tile
    //タイル表示の設定
    func displayTile() ->String {
        switch(tile) {
        case Tile.Nought: return "O"
        case Tile.Cross: return "X"
        default: return ""
        }
    }
    //タイル色の設定
    func tileColor() -> Color {
        switch(tile) {
        case Tile.Nought: return .blue
        case Tile.Cross: return .black
        default: return .black
        }
    }
    
}

//タイルの種類を設定
enum Tile {
    case Nought
    case Cross
    case Empty
}
