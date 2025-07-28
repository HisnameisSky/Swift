//
//  FileManager-DocumentsDirectory.swift
//  RememberThem
//
//  Created by 澄界 on 2025/07/28.
//

import Foundation


//書類管理の機能を起動する拡張の構造体
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
