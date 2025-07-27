//
//  EditPlaceView-ViewModel.swift
//  BucketList
//
//  Created by 澄界 on 2025/07/27.
//

import Foundation


//拡張機能の設定[a.b]()
extension EditPlaceView {
    enum LoadingState {
        case loading, loaded, failed
    }
    @Observable
    class ViewModel {
        var location: Location
        var name: String
        var loadingState = LoadingState.loading
        var pages = [Page]()
        
        init(location: Location, name: String) {
            self.location = location
            self.name = location.name
        }
        
        func createNewLocation() -> Location {
            var newLocation = self.location
            newLocation.id = UUID()
            newLocation.name = self.name
            return newLocation
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(self.location.latitude)%7C\(self.location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            guard let url = URL(string: urlString) else {
                print("Wrong url: \(urlString)")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(Result.self, from: data)
                self.pages = decoded.query.pages.values.sorted()
                self.loadingState = .loaded
            } catch {
                self.loadingState = .failed
            }
        }
    }
}
