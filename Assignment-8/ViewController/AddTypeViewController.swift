//
//  AddTypeViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/30/23.
//

import UIKit

class AddTypeViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
   
    func alert(_msg:String){
        let dialogMessage = UIAlertController(title: "Alert", message: _msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    @IBOutlet weak var typeName: UITextField!
    @IBAction func AddProduct(_ sender: UIButton) {
        let typename = typeName.text ?? ""
        if typename.isEmpty  {
            alert(_msg: "Name is Required")
        }
        var product = ProductType(context: self.context)
        product.id=Int64(AppDelegate.typeId)
        product.product_Type=typename
        do {
            try context.save()
            AppDelegate.typeId+=1
        }
        catch{
            alert(_msg: "Unable to Add Type")
            return
        }
        typeName.text=""
        alert(_msg: "Type Added Succesfully")
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
