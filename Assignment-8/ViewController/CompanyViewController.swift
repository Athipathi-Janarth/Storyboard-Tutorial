//
//  CompanyViewController.swift
//  Assignment-8
//
//  Created by AthiPathi on 3/30/23.
//

import UIKit

class CompanyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyViewCell
        cell.CompanyName?.text = companies[indexPath.row].name
        cell.country?.text = companies[indexPath.row].country
        cell.companyID?.text = String(companies[indexPath.row].id)
        cell.companyLogo?.image = UIImage(data: companies[indexPath.row].logo ?? Data())
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Remove the item from the data source
               var company:Int64
               if let index = try? context.fetch(Company.fetchRequest()).first(where: {$0.id == companies[indexPath.row].id }) {
                   company=index.id
                   if let product = try? context.fetch(Product.fetchRequest()).first(where: {$0.companyID == company }) {
                       context.delete(product)
                   }
                   if let post = try? context.fetch(Product_Post.fetchRequest()).first(where: {$0.companyID == company }) {
                       var order=index.id
                       if let orders = try? context.fetch(Order.fetchRequest()).first(where: {$0.postID == order   }) {
                           context.delete(orders)
                       }
                       context.delete(post)
                   }
                   context.delete(index)
                   try? context.save()
               }
               companies.remove(at: indexPath.row)
               // Remove the cell from the table view
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateCompany", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination =  segue.destination as? UpdateCompanyViewController{
            destination.company = companies[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }

    
    var companies: [Company] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        companies = try! context.fetch(Company.fetchRequest())
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        companies = try! context.fetch(Company.fetchRequest())
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
