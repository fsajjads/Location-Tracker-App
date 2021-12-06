//
//  SavedTasks.swift
//  assign4
//
//  Created by Fahim Sajjad on 11/3/21.
//

import SwiftUI
import CoreLocation
import MapKit
struct SavedTasks: View {
    @EnvironmentObject var lm : Locationer
    
    var body: some View {
      
        
     NavigationView {
      List{
            ForEach(lm.getAllTracks()) { item in
                let points = item.coord?.allObjects as! [GPXPoint]
                
                          NavigationLink {
                              TrackView(points: points, name: item.name ?? "", Date: item.date ?? Date(),
                                        lat: points[0].latitude,   long: points[0].longtitude
                              )
                          } label: {
                              Text(item.name ?? "")
                          }
                 }
                          .onDelete(perform: lm.deleteTrack)
         }.navigationTitle("All Tracks")
             .navigationBarTitleDisplayMode(.inline)
             
     }
        
    }
}

struct TrackView: View {
    let points : [GPXPoint]
    let name :  String
    let Date : Date
    let lat: Double
    let long: Double
    
    @EnvironmentObject var lm : Locationer
    
    var body: some View {
        VStack{
           

            Map(coordinateRegion:.constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:points[0].latitude, longitude: points[0].longtitude), span:MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))),
               annotationItems: points){
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longtitude), content:  {
                  
                        Circle().strokeBorder(Color.red, lineWidth: 5).frame(width: 5, height: 5)
                })}
            
            Text("Track \(name), \(points.count) pts")
        }
  
        
    }
}

struct SavedTasks_Previews: PreviewProvider {
    static var previews: some View {
        SavedTasks()
    }
}
