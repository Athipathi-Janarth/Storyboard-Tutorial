//
//  ProductType+CoreDataProperties.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/30/23.
//
//

import Foundation
import CoreData


extension ProductType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductType> {
        return NSFetchRequest<ProductType>(entityName: "ProductType")
    }

    @NSManaged public var id: Int64
    @NSManaged public var product_Type: String?

}

extension ProductType : Identifiable {

}
