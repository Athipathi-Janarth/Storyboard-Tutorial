//
//  AppDelegate.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/27/23.
//

import UIKit
import CoreData
import SystemConfiguration
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    static var typeId=1
    static var productId=1
    static var postId=1
    static var companyId=1
    static var orderId=1

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        do {
            var type_items=try persistentContainer.viewContext.fetch(ProductType.fetchRequest())
            if let typelastID = type_items.last?.id {
                AppDelegate.typeId = Int(typelastID)+1
            } else {
                AppDelegate.typeId = 1
            }
        }
        catch{
            print("No Data")
        }
        do {
            var type_items=try persistentContainer.viewContext.fetch(Product_Post.fetchRequest())
            if let typelastID = type_items.last?.id {
                AppDelegate.postId = Int(typelastID)+1
            } else {
                AppDelegate.postId = 1
            }
        }
        catch{
            print("No Data")
        }
        do {
            var type_items=try persistentContainer.viewContext.fetch(Product.fetchRequest())
            if let typelastID = type_items.last?.id {
                AppDelegate.productId = Int(typelastID)+1
            } else {
                AppDelegate.productId = 1
            }
        }
        catch{
            print("No Data")
        }
        do {
            var type_items=try persistentContainer.viewContext.fetch(Company.fetchRequest())
            if let typelastID = type_items.last?.id {
                AppDelegate.companyId = Int(typelastID)
            } else {
                AppDelegate.companyId = 0
            }
        }
        catch{
            print("No Data")
        }
        do {
            var type_items=try persistentContainer.viewContext.fetch(Order.fetchRequest())
            if let typelastID = type_items.last?.order_id {
                AppDelegate.orderId = Int(typelastID)+1
            } else {
                AppDelegate.orderId = 1
                
            }
        }
        catch{
            print("No Data")
        }
        let url = URL(string: "https://6429924debb1476fcc4c36b2.mockapi.io/company");
        let reachability = SCNetworkReachabilityCreateWithName(nil, "6429924debb1476fcc4c36b2.mockapi.io/company")
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)

        if !isNetworkReachable(with: flags) {
            print("No Api Found")
        }
        // Do any additional setup after loading the view.
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                // Handle API request error
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // Handle invalid HTTP response
                print("Invalid HTTP response")
                return
            }

            guard let data = data else {
                // Handle missing API response data
                print("Missing API response data")
                return
            }

            do {
                let decoder = JSONDecoder()
                let companyList = try decoder.decode([CompanyJson].self, from: data)
                for companies in companyList{
                    var company=Company(context: self.persistentContainer.viewContext)
                    var id=Int(companies.id)
                    company.id = Int64((id ?? 0) + AppDelegate.companyId)
                    company.name=companies.name
                    company.country=companies.country
                    company.zip=Int64(companies.zipcode) ?? 0
                    company.address=companies.address
                    company.companyType=companies.companyType
                   let imageUrlString = companies.logo
                    if let imageUrl = URL(string: imageUrlString) {
                        let session = URLSession.shared
                        let dataTask = session.dataTask(with: imageUrl) { (data, response, error) in
                            if let imageData = data {
                                DispatchQueue.main.async {
                                    company.logo=imageData
                                }
                            } else if let error = error {
                                print("Error downloading image: \(error)")
                            }
                        }
                        dataTask.resume()
                    }
                    //try? self.saveContext()
                }
            } catch {
                // Handle JSON parsing error
                print("Error parsing JSON: \(error)")
            }
        }
        task.resume()
        return true
    }
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

