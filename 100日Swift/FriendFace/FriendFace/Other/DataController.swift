//
//  DataController.swift
//  FriendFace
//
//  Created by 澄界 on 2025/07/26.
//

import CoreData
import Foundation
//アプリが作動できるようにするclass構造体
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FriendFace")
    
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
