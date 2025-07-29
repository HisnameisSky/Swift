//
//  Prospect.swift
//  HotProspects
//
//  Created by 澄界 on 2025/07/29.
//

import Foundation
import SwiftData


//SwiftDataによる構造体
@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    //class構造体なので始動宣言
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
