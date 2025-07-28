//
//  Person.swift
//  RememberThem
//
//  Created by 澄界 on 2025/07/28.
//

import MapKit
import SwiftUI

//人物情報の構造体
struct Person: Identifiable, Codable, Comparable {
    
    
    var id = UUID()
    let name: String
    let jpegData: Data
    //任意の座標の記録保存設定
    var latitude: Double? = nil
    var longitude: Double? = nil

    //画像情報
    var image: Image? {
        let uiImage = UIImage(data: jpegData)
        
        guard let uiImage = uiImage else { return nil }
        
        return Image(uiImage: uiImage)
    }
    //座標情報
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = latitude else { return nil }
        guard let longitude = longitude else { return nil }
        
        return .init(latitude: latitude, longitude: longitude)
    }
    //一般的な機能設定
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
