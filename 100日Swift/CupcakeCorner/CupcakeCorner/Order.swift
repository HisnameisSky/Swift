//
//  Order.swift
//  CupcakeCorner
//
//  Created by 澄界 on 2025/07/23.
//

import SwiftUI



@Observable

//[Order.()]
class Order: Codable {
    
    static let types = ["ヴァニラ", "苺", "チョコレート", "レインボー"]
    
    var type = 0
    var quantity = 3
    //特殊依頼の機能の追加設定
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    //ご注文の書類の条件に適う設定
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    //注文の詳細画面の設定
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    
    
    //お支払いの数字の設定
    var cost: Decimal {
        
        var cost = Decimal(quantity) * 2
        
        
        cost += Decimal(type) / 2
        
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}

class OrderObject: ObservableObject {
    @Published var order: Order = Order()
}

extension String {
    func isPureWhitespace() -> Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
