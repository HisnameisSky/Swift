//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by 澄界 on 2025/07/25.
//

import Foundation
import CoreData


extension Singer {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }
    
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }
    
    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}

extension Singer : Identifiable {
    
}
