//
//  ProductViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/31/23.
//

import UIKit

class ProductViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductViewCell
        cell.Name?.text = products[indexPath.row].name
        cell.Rating?.text = String(products[indexPath.row].productRating)+"/5"
        cell.ID?.text = String(products[indexPath.row].id)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Remove the item from the data source
               var post:Int64
               if let index = try? context.fetch(Product.fetchRequest()).first(where: {$0.id == products[indexPath.row].id }) {
                   post=index.id
                   if let posted = try? context.fetch(Product_Post.fetchRequest()).first(where: {$0.productID == post }) {
                       var order=index.id
                       if let orders = try? context.fetch(Order.fetchRequest()).first(where: {$0.postID == order   }) {
                           context.delete(orders)
                       }
                       context.delete(posted)
                   }
                   context.delete(index)
                   try? context.save()
               }
               products.remove(at: indexPath.row)
               // Remove the cell from the table view
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateProduct", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination =  segue.destination as? UpdateProductViewController{
           destination.product = products[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }

    
    var products: [Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        products = try! context.fetch(Product.fetchRequest())
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = try! context.fetch(Product.fetchRequest())
        tableView.reloadData()
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
