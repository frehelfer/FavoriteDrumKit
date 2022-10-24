//
//  DataController.swift
//  FavoriteDrumKit
//
//  Created by Frédéric Helfer on 22/10/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DrumKit")
    @Published var savedEntities: [DrumKitEntity] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        fetchDrumKit()
    }
    
    func fetchDrumKit() {
        let request = NSFetchRequest<DrumKitEntity>(entityName: "DrumKitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetchin. \(error)")
        }
    }
    
    func saveData() {
        guard container.viewContext.hasChanges else { return }
        
        do {
            try container.viewContext.save()
            fetchDrumKit()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createDrumKit(name: String) {
        let newDrumKit = DrumKitEntity(context: container.viewContext)
        newDrumKit.name = name
        saveData()
    }
    
    func deleteDrumKit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let drumKit = savedEntities[index]
        
        container.viewContext.delete(drumKit)
        saveData()
    }
    
    func updateFavorite(kit: DrumKitEntity) {
        kit.favorite.toggle()
        
        saveData()
    }
    
}
