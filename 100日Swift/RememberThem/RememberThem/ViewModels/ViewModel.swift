//
//  ViewModel.swift
//  RememberThem
//
//  Created by 澄界 on 2025/07/28.
//

import Foundation


class ViewModel: ObservableObject {
    //別の構造体の定義を借りる
    @Published var people: [Person]
    //保存先の定義
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPersons")
    
    //ディスクから情報を読み取る
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Person].self, from: data).sorted()
        } catch {
            people = []
        }
    }
    
    //情報をディスクに保存する
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(
                to: savePath,
                options: [.atomic, .completeFileProtection]
            )
        } catch {
            print("Unable to save data.")
        }
    }
    //人物の追加
    func addPerson(_ person: Person) {
        people.append(person)
        people.sort()
        save()
    }
    //人物の削除
    func removePerson(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
        save()
    }
}

