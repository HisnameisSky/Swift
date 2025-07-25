//
//  DataController.swift
//  CoreDataProject
//
//  Created by 澄界 on 2025/07/25.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy
                .mergeByPropertyObjectTrump
        }
    }
}
