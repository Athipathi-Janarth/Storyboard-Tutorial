//
//  OrderViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 4/1/23.
//

import UIKit

class OrderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderViewCell

        guard let product =  try? context.fetch(Product.fetchRequest()).first(where: {$0.id == products[indexPath.row].productID }) else{
            print("No Data")
            return UITableViewCell()

        }
        guard let post =  try? context.fetch(Product_Post.fetchRequest()).first(where: {$0.id == products[indexPath.row].postID }) else{
            print("No Data")
            return UITableViewCell()
        }
        cell.OrderID?.text = String(products[indexPath.row].order_id)
        cell.ProductName?.text = product.name
        cell.Price?.text = String(post.price)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Remove the item from the data source
               
               if let index = try? context.fetch(Order.fetchRequest()).first(where: {$0.id == products[indexPath.row].id }) {
                   context.delete(index)
                   try? context.save()
               }
               products.remove(at: indexPath.row)
               // Remove the cell from the table view
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
    var products: [Order] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        products = try! context.fetch(Order.fetchRequest())
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = try! context.fetch(Order.fetchRequest())
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
