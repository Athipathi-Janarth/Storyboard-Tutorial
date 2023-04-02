//
//  Product_Post+CoreDataProperties.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/30/23.
//
//

import Foundation
import CoreData


extension Product_Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product_Post> {
        return NSFetchRequest<Product_Post>(entityName: "Product_Post")
    }

    @NSManaged public var companyID: Int64
    @NSManaged public var id: Int64
    @NSManaged public var postDescription: String?
    @NSManaged public var postedDate: Date?
    @NSManaged public var price: Float
    @NSManaged public var productID: Int64
    @NSManaged public var productTypeID: Int64

}

extension Product_Post : Identifiable {

}
