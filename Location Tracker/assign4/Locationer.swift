//
//  Locationer.swift
//  assign4
//
//  Created by Fahim Sajjad on 11/2/21.
//

import Foundation
import CoreLocation



class Locationer : NSObject, ObservableObject, CLLocationManagerDelegate {
    var lm = CLLocationManager()
    @Published var location: CLLocation? = nil
    @Published var locationLists: [CLLocationCoordinate2D] = []
    @Published var trackData: Bool = false
    @Published var count = 0
    @Published var points:[GPXPoint] = []
    @Published var allTracks: [GPXTrack] = []
    
    override init() {
        super.init()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.distanceFilter = kCLDistanceFilterNone
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
       allTracks =  getAllTracks()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
   
       
       
        self.location = location

        for newLocation in locations {
  
            if trackData == true {
                self.locationLists.append(CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude))
                
                let track = GPXPoint(context: PersistenceController.shared.viewContext)
                
                track.latitude = newLocation.coordinate.latitude
                track.longtitude = newLocation.coordinate.longitude
                points.append(track)
              
                
            }
            
           
            }
    }
  
    //save a track
    func addTrack(points: [GPXPoint]){
        let newTrack = GPXTrack(context: PersistenceController.shared.viewContext)
        
        let date = formatDate(value: Date())
        newTrack.name = "trk \(date)"
        
        newTrack.date = Date()
        newTrack.coord = NSSet(array: points)
        count += 1
        PersistenceController.shared.save()
        allTracks = getAllTracks()
        
    }
    
    func getAllTracks()-> [GPXTrack]{
        
       return PersistenceController.shared.fetchTracks()
        
    }
    
    func deleteTrack(indexSet: IndexSet){
           guard let index = indexSet.first else{
               return
           }
           let entity = allTracks[index]
           PersistenceController.shared.viewContext.delete(entity)
           PersistenceController.shared.save()
           allTracks = getAllTracks()
       }

    private func  formatDate(value : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm EEEE, MMM d, yyyy"
        return formatter.string(from: value)
    }

      
}

