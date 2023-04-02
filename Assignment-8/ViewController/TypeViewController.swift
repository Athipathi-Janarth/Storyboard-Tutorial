//
//  TypeViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/30/23.
//

import UIKit

class TypeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath) as! TypeViewCell
        cell.typeName?.text = productTypes[indexPath.row].product_Type
        cell.typeID?.text = String(productTypes[indexPath.row].id)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Remove the item from the data source
               let post : Int64
               if let index = try? context.fetch(ProductType.fetchRequest()).first(where: {$0.id == productTypes[indexPath.row].id }) {
                   post=index.id
                   context.delete(index)
                   if let index = try? context.fetch(Product_Post.fetchRequest()).first(where: {$0.productTypeID == post }) {
                       var order=index.id
                       if let orders = try? context.fetch(Order.fetchRequest()).first(where: {$0.postID == order   }) {
                           context.delete(orders)
                       }
                       context.delete(index)
                   }
                   try? context.save()
               }
               productTypes.remove(at: indexPath.row)
               // Remove the cell from the table view
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateType", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination =  segue.destination as? UpdateTypeViewController{
            destination.productType = productTypes[typeTableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
    
    var productTypes: [ProductType] = []
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        typeTableView.delegate = self
        typeTableView.dataSource = self
        productTypes = try! context.fetch(ProductType.fetchRequest())
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var typeTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productTypes = try! context.fetch(ProductType.fetchRequest())
        typeTableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
