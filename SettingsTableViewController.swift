//
//  SettingsTableViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-19.
//

import UIKit
import CoreData

class SettingsTableViewController: UITableViewController {

    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var ageLbl: UILabel!
    @IBOutlet var cupsLbl: UILabel!
    
    @IBOutlet var weightSlider: UISlider!
    @IBOutlet var ageSlider: UISlider!
    @IBOutlet var cupsSlider: UISlider!
    
    var managedContext: NSManagedObjectContext!
    var age: Int32 = 25
    var weight: Int32 = 160

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        print(isUserSetup())
        
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateAge(){
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        let ageString = String(format: "%.0f", ageSlider.value)
        let num = Int32(ageString)

        ageLbl.text = "\(num!)"
        age = num!
        updateCups(age: age, weight: weight)
        //updateCups()
    }
    
    @IBAction func updateWeight(){
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        let weightString = String(format: "%.0f", weightSlider.value)
        let num = Int32(weightString)

        weightLbl.text = "\(num!)"
        weight = num!
        updateCups(age: age, weight: weight)
        
    }
    @IBAction func updateCups(){
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        let cupsString = String(format: "%.0f", cupsSlider.value)
        let num = Int32(cupsString)

        cupsLbl.text = "\(num!)"
      
       
    }
    
    func updateCups(age: Int32, weight: Int32){
        if (age > 0 && weight > 0){
            var multi = 40.0
            if (age >= 30 && age  < 55){
                multi = 35.0
            }
            else{
                multi = 30.0
            }
            let weightRatio = Double(weight) / 2.2
            let weightResult = weightRatio * Double(multi)
            var cups  = weightResult / 226.4
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.roundingMode = .halfUp
            formatter.maximumFractionDigits = 0
            if (cups > 16){
                cups = 16.0
            }
            let cupString = String(format: "%.0f", cups)

            cupsSlider.value = Float(cupString)!
            cupsLbl.text = "\(cupString)"

        }
    }
    
    func isUserSetup() -> Bool {
        
        let fetch: NSFetchRequest<UserMO> = UserMO.fetchRequest()
        
        fetch.predicate = NSPredicate(format: "user != nil")
        
        let count = (try? managedContext.count(for: fetch)) ?? 0
        print(count)
    
        //if there are entities with searchKey's, return
        if count > 0 {
            return  true//this means we already set up the user
        }
        else{
            return false
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
