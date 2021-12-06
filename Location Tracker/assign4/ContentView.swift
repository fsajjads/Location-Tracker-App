//
//  ContentView.swift
//  assign4
//
//  Created by Fahim Sajjad on 11/2/21.
//

import SwiftUI
import CoreData
import SwiftUI
import CoreLocation
import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct ContentView: View {
    @EnvironmentObject var lm : Locationer
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37, longitude: -67),
    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @State  var tabSelection:Int = 1
    var body: some View {
        // TabView
        TabView(selection: $tabSelection){
            MapView(tabSelection: $tabSelection)
                .tabItem{
                    Image(systemName: "map")
                    Text("Map")
                    
                }.tag(1)
            SavedTasks()
                .tabItem{
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text("Saved Tasks")
                }.tag(2)
        }
        
        
    }
}

struct MapView: View {
    @EnvironmentObject var lm : Locationer
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37, longitude: -67),
    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @State private var showDetails = false
    @State private var buttonName = "Start"
    @Binding var tabSelection : Int
    var body: some View {
        VStack {
            
            Map(coordinateRegion: $region,
                interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: lm.locationLists){
                MapAnnotation(coordinate:$0, content:  {
                  
                        Circle().strokeBorder(Color.red, lineWidth: 3).frame(width: 5, height: 5)
                })}.ignoresSafeArea()
            
            Button(showDetails == true ? "Stop" : "Start" ) {
              
             showDetails.toggle()
                if showDetails == true{
                    lm.trackData = true
                }else{
                    lm.trackData = false
                }
            
                if showDetails == false{
                    lm.addTrack(points: lm.points)
                    lm.points = []
                    tabSelection = 2
                }
            
            }
            
            .frame(width:80, height: 50)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(10)
            .clipShape(Rectangle())
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

