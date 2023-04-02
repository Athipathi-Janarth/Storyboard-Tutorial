//
//  AddProductViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/31/23.
//

import UIKit

class AddProductViewController: UIViewController {

  
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var companyID: UITextField!
    @IBOutlet weak var Rating: UITextField!
    @IBOutlet weak var Quantity: UITextField!
    @IBOutlet weak var productDescription: UITextField!
    
    
    func alert(_msg:String){
        let dialogMessage = UIAlertController(title: "Alert", message: _msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    @IBAction func createProduct(_ sender: UIButton) {
        let productname = productName.text ?? ""
        let productRating = Rating.text ?? ""
        let productQuantity = Quantity.text ?? ""
        let companyId = companyID.text ?? ""
        let productDescriptions = productDescription.text ?? ""
        if productname.isEmpty  {
           alert(_msg: "Please enter a Product Name")
           }
        if productRating.isEmpty  {
            alert(_msg: "Please enter a Rating")
           }
        guard let rating = Int(productRating) else {
            alert(_msg: "Rating Need to be a number")
            return
    }
        if companyId.isEmpty  {
            alert(_msg: "Please enter a Company ID")
           }
        guard let companyid = Int(companyId) else {
            alert(_msg: "companyID Need to be a number")
            return
    }
        guard let company =  try? context.fetch(Company.fetchRequest()).first(where: {$0.id == companyid }) else{
            alert(_msg: "company ID doesn't exists")
            return
        }
        if productQuantity.isEmpty  {
            alert(_msg: "Please enter the Quantity")
           }
            guard let quantity = Int(productQuantity) else {
                alert(_msg: "Quantity Need to be a number")
                return
        }
        var product=Product(context: self.context)
        product.id=Int64(AppDelegate.productId)
        product.name = productname
        product.productDescription = productDescriptions
        product.productRating = Int64(rating)
        product.companyID = Int64(companyid)
        product.quantity = Int64(quantity)
        try? context.save()
        AppDelegate.productId+=1
        alert(_msg: "Product Added Successfully")
        productName.text=""
        Rating.text = ""
        Quantity.text = ""
        productDescription.text = ""
        companyID.text = ""
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
