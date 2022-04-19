//
//  caluclateViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-18.
//

import UIKit
import CoreData

class caluclateViewController: UIViewController {

    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var ageLbl: UILabel!
    @IBOutlet var cupDisplay: UILabel!
    @IBOutlet var cupAmtDisplay: UILabel!
    @IBOutlet var continueBtn: UIButton!
    var managedContext: NSManagedObjectContext!

    
    var weight: Int32 = 180
    var age: Int32 = 20

    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        super.viewDidLoad()
        cupDisplay.text = ""
        cupAmtDisplay.text = ""
        weightLbl.text = "\(weight)"
        ageLbl.text = "\(age)"
        continueBtn.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueToMain(){
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
        let cupString = String(format: "%.0f", cups)
        let num =   formatter.number(from: cupString) as? NSDecimalNumber ?? 0
            print("new data added")
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
          let newUser = UserMO(entity: entity, insertInto: managedContext)
            newUser.age = Decimal(age) as NSDecimalNumber
            newUser.waterGoal = num
            newUser.user = "user"
            newUser.weight = Decimal(weight) as NSDecimalNumber
            print(newUser.weight!)
                try!  managedContext.save()
            performSegue(withIdentifier: "calToMain", sender: nil)
        }
        
    }
    
    @IBAction func incWeight(){
        if (weight < 1000){
            weight+=2
            weightLbl.text = "\(weight)"
        }
    }
    
    @IBAction func decWeight(){
        if (weight > 49){
            weight-=2
            weightLbl.text = "\(weight)"
        }
    }
    
    @IBAction func incAge(){
        if (age < 110){
            age+=2
            ageLbl.text = "\(age)"
        }
    }
    
    @IBAction func decAge(){
        if (age > 13){
            age-=2
            ageLbl.text = "\(age)"
        }
    }
    
    @IBAction func calculate(){
        
        
      

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
            let cupNum = String(format: "%.0f", cups)
    
            cupAmtDisplay.text = "\(cupNum)"
            cupDisplay.text  = "CUPS"
            continueBtn.isHidden = false
        }

       

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
