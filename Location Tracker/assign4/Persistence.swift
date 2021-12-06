//
//  Persistence.swift
//  assign4
//
//  Created by Fahim Sajjad on 11/2/21.
//

import CoreData

class PersistenceController : ObservableObject {

    let container: NSPersistentContainer
    static let shared = PersistenceController()
    
    var viewContext: NSManagedObjectContext{
        return container.viewContext
    }
    
    
    init() {
        container = NSPersistentContainer(name: "assign4")
        
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
            
                fatalError("Unresolved error\(error.localizedDescription)")
            }
        })
    }
    
    func save(){
        do{
            try viewContext.save()
            
        }catch{
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }

    
    func fetchTracks() -> [GPXTrack]{
        
        let fetchRequest : NSFetchRequest<GPXTrack> = GPXTrack.fetchRequest()
        do{
           return try container.viewContext.fetch(fetchRequest)
            
        }catch{
            return []
        }
    }
    
    

}
