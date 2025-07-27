//
//  ContentView.swift
//  BucketList
//
//  Created by 澄界 on 2025/07/27.
//

import CoreLocation
import SwiftUI
import MapKit

//情報の構造体
struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    @State private var isStandardMap = true
    
    
    var body: some View {
        //認証できた場合
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(isStandardMap ? .standard : .hybrid)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditPlaceView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
                VStack {
                    Spacer()
                    Button(isStandardMap ? "Change to hybrid" :  "Change to standard") {
                        isStandardMap.toggle()
                    }
                    .padding()
                    .background(.white)
                    .clipShape(.capsule)
                    .buttonStyle(.plain)
                }
            }
            //未だ認証されていない場合
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .buttonStyle(.borderedProminent)
                .alert("Unable to use biometrics", isPresented: $viewModel.isShowingAlert) {
                    Button("Okay", role: .cancel) { }
                } message: {
                    Text("Please check your settings.")
                }
        }
    }
}




#Preview {
    ContentView()
}
