//
//  ItemToSell+CoreDataProperties.swift
//  
//
//  Created by NguyenThanhTri on 17/05/2022.
//
//

import Foundation
import CoreData


extension ItemToSell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemToSell> {
        return NSFetchRequest<ItemToSell>(entityName: "ItemToSell")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var price: Int64
    @NSManaged public var quantity: Int64
    @NSManaged public var type: Int64

}
