//
//  AddPostViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/31/23.
//

import UIKit

class AddPostViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var productID: UITextField!
    @IBOutlet weak var productTypeID: UITextField!
    @IBOutlet weak var companyID: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var postDescription: UITextField!
    
    @IBOutlet weak var postedDate: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
   
    func alert(_ msg:String){
        let dialogMessage = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
  
    @IBAction func createPost(_ sender: UIButton) {
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
        guard let product = try? context.fetch(Product.fetchRequest()).first(where: {$0.id == productIDs }) else{
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
        guard let company =  try? context.fetch(Company.fetchRequest()).first(where: {$0.id == comapnyid }) else{
            alert( " Company ID Invalid")
            return
        }
        
        var post=Product_Post(context: self.context)
        post.id=Int64(AppDelegate.postId)
        post.productTypeID = productType.id
        post.companyID = company.id
        post.productID = product.id
        post.postedDate = datePicker.date
        post.price = Price
        post.postDescription = description
        try? context.save()
        AppDelegate.postId+=1
        productID.text=""
        productTypeID.text = ""
        price.text = ""
        companyID.text = ""
        postDescription.text = ""
        alert("Post Created Successfully")
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
