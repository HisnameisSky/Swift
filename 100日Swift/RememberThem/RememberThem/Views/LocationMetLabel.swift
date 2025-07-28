//
//  LocationMetLabel.swift
//  RememberThem
//
//  Created by 澄界 on 2025/07/28.
//

import SwiftUI

//「」（）座標場所の構造体
struct LocationMetLabel: View {
    enum LocationMetStatus {
        case known, unknown
    }
    
    let title: String
    let status: LocationMetStatus
    
    var systemImage: String {
        status == .known ? "map" : "questionmark"
    }
    
    var body: some View {
        Label(title, systemImage: systemImage)
    }
}

//表示
struct LocationMetLabel_Previews: PreviewProvider {
    static var previews: some View {
        LocationMetLabel(title: "Here's where you met them", status: .known)
    }
}
