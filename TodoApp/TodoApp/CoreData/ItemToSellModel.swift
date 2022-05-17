//
//  DataPersistence.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import Foundation
import CoreData
import UIKit

class ItemToSellModel: NSObject, NSFetchedResultsControllerDelegate {
    private var fetchedResultsController: NSFetchedResultsController<ItemToSell>!
    
    static let shared = ItemToSellModel()
    
    func insert(name: String, id: Int, price: Int, type: Int, quantity: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ItemToSell", in: managedContext)!
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(name, forKey: "name")
        item.setValue(id, forKey: "id")
        item.setValue(price, forKey: "price")
        item.setValue(type, forKey: "type")
        item.setValue(quantity, forKey: "quantity")
        
        //save context
        do {
            try managedContext.save()
            print("Did save.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getAll() -> [ItemToSell] {
        let fetchRequest: NSFetchRequest<ItemToSell> = ItemToSell.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: managedContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            return fetchedResultsController.fetchedObjects ?? []
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
}
