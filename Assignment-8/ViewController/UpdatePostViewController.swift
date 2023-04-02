//
//  UpdatePostViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 4/1/23.
//

import UIKit

class UpdatePostViewController: UIViewController {
    var post:Product_Post?
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    @IBOutlet weak var postID: UILabel!
    @IBOutlet weak var productID: UITextField!
    @IBOutlet weak var productTypeID: UITextField!
    @IBOutlet weak var companyID: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var postedDate: UIDatePicker!
    @IBOutlet weak var postDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let id=post?.id
        postID.text="Post ID    \(id?.description ?? "Nil")"
        let productid=post?.productID
        productID.text=productid?.description
        let typeid=post?.productTypeID
        productTypeID.text = typeid?.description
        let amount = post?.price
        price.text = amount?.description
        let date = post?.postedDate
        postedDate.date = date ?? Date()
        let companyid=post?.companyID
        companyID.text = companyid?.description
        postDescription.text = ""
        // Do any additional setup after loading the view.
    }

    func alert(_ msg:String){
        let dialogMessage = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func onPostUpdate(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let productId = productID.text ?? ""
        let prices = price.text ?? ""
        let typeId = productTypeID.text ?? ""
        let companyId = companyID.text ?? ""
        let description = postDescription.text ?? ""
        if productId.isEmpty  {
            alert( "Please enter a Product ID")
        }
        guard let productIDs = Int(productId) else {
            alert( "Product ID needs to be a number")
            return
            
        }
        guard let product =  try? context.fetch(Product.fetchRequest()).first(where: {$0.id == productIDs }) else{
            alert(" Product ID Invalid")
            return
        }
        if typeId.isEmpty  {
            alert("Please enter a Product Type")
            return
        }
        guard let typeID = Int(typeId) else {
            alert(" Product Type ID need to be a number")
            return
        }
        guard let productType =  try? context.fetch(ProductType.fetchRequest()).first(where: {$0.id == typeID }) else{
            alert(" Product Type ID Invalid")
            return
        }
        if prices.isEmpty  {
            alert("Please enter price")
            return
        }
        guard let Price = Float(prices) else {
            alert(" Price need to be a number")
            return
        }
        if companyId.isEmpty  {
            alert("Please enter CompanyID")
            return
        }
        guard let comapnyid = Int(companyId) else {
            alert(" Company ID need to be a number")
            return
        }
        guard let company = try? context.fetch(Company.fetchRequest()).first(where: {$0.id == comapnyid }) else{
            alert( " Company ID Invalid")
            return
        }
        
        post?.productTypeID = productType.id
        post?.companyID = company.id
        post?.productID = product.id
        post?.postedDate = postedDate.date
        post?.price = Price
        post?.postDescription = description
        postID.text="Post ID"
        productID.text=""
        productTypeID.text = ""
        price.text = ""
        postedDate.date=Date()
        companyID.text = ""
        postDescription.text = ""
        alert("Post Updated Successfully")
    }
    @IBAction func onCreateOrder(_ sender: UIButton) {
        var order=Order(context: self.context)
        order.productTypeID = post?.productTypeID  ??  0
        order.postID = post?.id ??  0
        order.productID = post?.productID ??  0
        order.order_id=Int64(AppDelegate.orderId)
        order.date=Date()
        try? context.save()
        AppDelegate.orderId+=1
        alert("Order has been placed. Your Order ID is \(order.order_id)")
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
