//
//  ContentView.swift
//  CoreDataProject
//
//  Created by 澄界 on 2025/07/25.
//

import SwiftUI

//CoreDataの元で働くアプリはApple Developerが必須なので、誤作動が発生してしまう可能性あり
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(
                filterKey: "lastName",
                predicate: .beginsWith,
                filterValue: lastNameFilter,
                sortDescriptors: [
                    NSSortDescriptor(key: "lastName", ascending: true)
                ]
            )
            { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

#Preview {
    ContentView()
}
