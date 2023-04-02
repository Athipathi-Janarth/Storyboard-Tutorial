//
//  Product+CoreDataProperties.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/30/23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var companyID: Int64
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var productRating: Int64
    @NSManaged public var quantity: Int64

}

extension Product : Identifiable {

}
