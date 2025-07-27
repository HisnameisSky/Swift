//
//  EditView.swift
//  BucketList
//
//  Created by 澄界 on 2025/07/27.
//

import SwiftUI

//地図の編集機能の構造体
struct EditPlaceView: View {
    //アプリ全体への特定変更を適用
    @Environment(\.dismiss) var dismiss
    //情報はどこにも保存されない模様
    var onSave: (Location) -> Void
    //拡張Viewへの指定
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                }
                Section("Nearby") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please, try again.")
                    }
                }
            }
            .navigationTitle("Selected Place")
            .toolbar {
                Button("Save") {
                    onSave(viewModel.createNewLocation())
                    dismiss()
                }
            }
            //情報収集の宣言
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    //始動宣言
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        viewModel = ViewModel(location: location, name: location.name)
    }
}

#Preview {
    EditPlaceView(location: .example) { _ in }
}
