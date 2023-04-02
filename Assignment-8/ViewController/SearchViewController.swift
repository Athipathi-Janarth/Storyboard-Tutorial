//
//  SearchViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 4/1/23.
//

import UIKit

class SearchViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
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
    @IBAction func ratingChange(_ sender: Any) {
        let productId = Rating.text ?? ""
        if productId.isEmpty  {
            let dialogMessage = UIAlertController(title: "Alert", message: "Please enter a Rating", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        guard let productIDs = Int(productId) else {
            let dialogMessage = UIAlertController(title: "Alert", message: "Rating need to be a number", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        let productList = try? context.fetch(Product.fetchRequest()).filter {$0.productRating == productIDs }
        var list:[Product_Post]
        list=[]
        for product in productList! {
            let productpost = try? context.fetch(Product_Post.fetchRequest()).filter{ $0.productID == product.id }
            list+=productpost!
        }
        products = list
        tableView.reloadData()
    }
    @IBAction func productIDChange(_ sender: Any) {
        let productId = productID.text ?? ""
        if productId.isEmpty  {
            let dialogMessage = UIAlertController(title: "Alert", message: "Please enter a Product ID", preferredStyle: .alert)

               return
           }
            guard let productIDs = Int(productId) else {
            let dialogMessage = UIAlertController(title: "Alert", message: "Product ID to be a number", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })

             dialogMessage.addAction(ok)
              self.present(dialogMessage, animated: true, completion: nil)
               return
        }
         let productpost = try? context.fetch(Product_Post.fetchRequest()).filter{ $0.id == productIDs }
        products = productpost!
        tableView.reloadData()
    }
    @IBAction func typeIDChange(_ sender: Any) {
        let productId = typeID.text ?? ""
        if productId.isEmpty  {
            let dialogMessage = UIAlertController(title: "Alert", message: "Please enter a Product Type ID", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        guard let productIDs = Int(productId) else {
            let dialogMessage = UIAlertController(title: "Alert", message: "ProductType ID to be a number", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        let productpost = try? context.fetch(Product_Post.fetchRequest()).filter{ $0.productTypeID == productIDs }
        products = productpost!
        tableView.reloadData()
    }
    @IBAction func postIDChange(_ sender: Any) {
        let productId = postID.text ?? ""
        if productId.isEmpty  {
            let dialogMessage = UIAlertController(title: "Alert", message: "Please enter a Post ID", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
               return
           }
            guard let productIDs = Int(productId) else {
            let dialogMessage = UIAlertController(title: "Alert", message: "Product ID to be a number", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
               return
        }
         let productpost = try? context.fetch(Product_Post.fetchRequest()).filter{ $0.id == productIDs }
        products = productpost!
        tableView.reloadData()
    }
    @IBAction func companyIDChange(_ sender: Any) {
        let productId = companyID.text ?? ""
        if productId.isEmpty  {
            let dialogMessage = UIAlertController(title: "Alert", message: "Please enter a Company ID", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        guard let productIDs = Int(productId) else {
            let dialogMessage = UIAlertController(title: "Alert", message: "Compay ID to be a number", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
            
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        let productpost = try? context.fetch(Product_Post.fetchRequest()).filter{ $0.companyID == productIDs }
        products = productpost!
        tableView.reloadData()
    }
    
    @IBOutlet weak var typeID: UITextField!
    @IBOutlet weak var productID: UITextField!
    @IBOutlet weak var companyID: UITextField!

    @IBOutlet weak var postID: UITextField!
    @IBOutlet weak var Rating: UITextField!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
