//
//  UpdateCompanyViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/31/23.
//

import UIKit

class UpdateCompanyViewController: UIViewController {

    var company:Company?
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        let id=company?.id
        let zip=company?.zip
        companyId.text = "Company ID    \(id?.description ?? "Nil")"
        companyName.text = company?.name
        companyAddress.text = company?.address
        companyCountry.text = company?.country
        companyZip.text = "\(zip?.description ?? "Nil")"
        companyType.text = company?.companyType
        companyLogo.image = UIImage(data: company?.logo ?? Data())
        // Do any additional setup after loading the view.
    }
    
    
   @IBOutlet weak var companyId: UILabel!

    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var companyAddress: UITextField!
    @IBOutlet weak var companyType: UITextField!
    @IBOutlet weak var companyZip: UITextField!
    @IBOutlet weak var companyCountry: UITextField!
   
    func alert(_msg:String){
        let dialogMessage = UIAlertController(title: "Alert", message: _msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    @IBAction func onUpdateCompany(_ sender: UIButton) {
        let companyname = companyName.text ?? ""
        let companyaddress = companyAddress.text ?? ""
        let companycountry = companyCountry.text ?? ""
        let companyzip = companyZip.text ?? ""
        let companytype = companyType.text ?? ""
        if companyname.isEmpty  {
           alert(_msg: "Please enter a Company Name")
           }
        if companyaddress.isEmpty  {
            alert(_msg: "Please enter a Company Address")
           }
        if companycountry.isEmpty  {
            alert(_msg: "Please enter a Company Country")
           }
        if companyzip.isEmpty  {
            alert(_msg: "Please enter a Company Zip Code")
           }
            guard let zipCode = Int(companyzip) else {
                alert(_msg: "ZipCode Need to be a number")
                return
        }
        company?.name = companyname
        company?.address = companyaddress
        company?.country = companycountry
        company?.zip = Int64(zipCode)
        company?.companyType = companytype
        try? context.save()
        alert(_msg: "Company Updated Successfully")
        companyId.text = "Company ID"
        companyName.text=""
        companyAddress.text = ""
        companyCountry.text = ""
        companyZip.text = ""
        companyType.text = ""
        self.dismiss(animated: true)
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
