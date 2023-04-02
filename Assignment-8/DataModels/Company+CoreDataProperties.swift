//
//  Company+CoreDataProperties.swift
//  Assignment-8
//
//  Created by AthiPathi on 4/1/23.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var address: String?
    @NSManaged public var companyType: String?
    @NSManaged public var country: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var zip: Int64
    @NSManaged public var logo: Data?

}

extension Company : Identifiable {

}
