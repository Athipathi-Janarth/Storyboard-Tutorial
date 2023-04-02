//
//  AddCompanyViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/30/23.
//

import UIKit

class AddCompanyViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum

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
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var companyCountry: UITextField!
    @IBOutlet weak var companyZip: UITextField!
    @IBOutlet weak var companyType: UITextField!
    @IBOutlet weak var companyLogo: UIImageView!
    
    @IBOutlet weak var companyAddress: UITextField!
    
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided with the following: \(info)")
        }
        
        // Use the selected image
        companyLogo.image = selectedImage
        
        // Dismiss the image picker
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createCompany(_ sender: UIButton) {
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
        var company = Company(context: self.context)
        company.id=Int64(AppDelegate.companyId)
        company.name=companyname
        company.address=companyaddress
        company.country=companycountry
        company.zip=Int64(zipCode)
        company.companyType=companytype
        company.logo=companyLogo.image?.jpegData(compressionQuality: 1.0)
        AppDelegate.companyId+=1
        try? context.save()
        alert(_msg: "Company Added Successfully")
        companyLogo.image=UIImage()
        companyName.text=""
        companyAddress.text = ""
        companyCountry.text = ""
        companyZip.text = ""
        companyType.text = ""
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
