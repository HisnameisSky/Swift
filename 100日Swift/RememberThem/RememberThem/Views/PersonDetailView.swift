//
//  PersonDetailView.swift
//  RememberThem
//
//  Created by 澄界 on 2025/07/28.
//

import SwiftUI
import MapKit


//[]()
struct PersonDetailView: View {
    
    var person: Person
    let deltaSpan = 0.0025
    
    var body: some View {
        
        VStack(spacing: 20) {
            person.image?
                .resizable()
                .scaledToFit()
            
            if let coordinate = person.coordinate {
                VStack {
                    LocationMetLabel(title: "Here's where you met them", status: .known)
                        .font(.headline)
                    //人物情報における地図による座標情報
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: .init(latitude: coordinate.latitude, longitude: coordinate.longitude), span: .init(latitudeDelta: deltaSpan, longitudeDelta: deltaSpan))), annotationItems: [person]) { _ in
                        MapAnnotation(coordinate: coordinate) {
                            Circle()
                                .stroke(.primary, lineWidth: 3)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            } else {
                //座標の情報が不明
                LocationMetLabel(title: "Unknown meeting location...", status: .unknown)
                    .font(.headline)
            }
        }
        .padding()
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}
