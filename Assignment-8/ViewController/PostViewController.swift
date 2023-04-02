//
//  PostViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/31/23.
//

import UIKit

class PostViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostViewCell

        guard let product =  try? context.fetch(Product.fetchRequest()).first(where: {$0.id == products[indexPath.row].productID }) else{
            print("No Data")
            return cell
        }
        guard let type =  try? context.fetch(ProductType.fetchRequest()).first(where: {$0.id == products[indexPath.row].productTypeID }) else{
            print("No Data")
            return cell
        }
        cell.PostID?.text = String(products[indexPath.row].id)
        cell.ProductName?.text = product.name
        cell.ProductType?.text = type.product_Type
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Remove the item from the data source
               var order:Int64
               if let index = try? context.fetch(Product_Post.fetchRequest()).first(where: {$0.id == products[indexPath.row].id }) {
                   order=index.id
                   if let orders = try? context.fetch(Order.fetchRequest()).first(where: {$0.postID == order   }) {
                       context.delete(orders)
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
        performSegue(withIdentifier: "updatePost", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination =  segue.destination as? UpdatePostViewController{
           destination.post = products[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }

    
    var products: [Product_Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        products = try! context.fetch(Product_Post.fetchRequest())
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = try! context.fetch(Product_Post.fetchRequest())
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
