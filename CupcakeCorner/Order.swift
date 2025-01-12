//
//  Order.swift
//  CupcakeCorner
//
//  Created by Gary on 25/12/2024.
//

import Foundation

@Observable
class Order: Codable {
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
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0 {
        didSet { saveToUserDefault() }
    }
    var quantity = 3 {
        didSet { saveToUserDefault() }
    }
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
            saveToUserDefault()
        }
    }
    var extraFrosting = false {
        didSet { saveToUserDefault() }
    }
    var addSprinkles = false {
        didSet { saveToUserDefault() }
    }
    var name = "" {
        didSet { saveToUserDefault() }
    }
    var streetAddress = "" {
        didSet { saveToUserDefault() }
    }
    var city = "" {
        didSet { saveToUserDefault() }
    }
    var zip = "" {
        didSet { saveToUserDefault() }
    }
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
            city.trimmingCharacters(in: .whitespaces).isEmpty ||
            zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }

        return true
    }
    
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
    
    // MARK: UserDefault
    private static let userDefaultsKey = "SavedOrder"
    
    func saveToUserDefault() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.setValue(encoded, forKey: Order.userDefaultsKey)
        }
    }
    
    static func loadFromUserDefault() -> Order {
        if let savedOrder = UserDefaults.standard.data(forKey: Order.userDefaultsKey) {
            if let decoded = try? JSONDecoder().decode(Order.self, from: savedOrder) {
                return decoded
            }
        }
        
        return Order()
    }
}
