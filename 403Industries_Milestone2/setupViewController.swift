//
//  setupViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-16.
//

import UIKit
import CoreData

class setupViewController: UIViewController {
    
    @IBOutlet var cupDisplay: UILabel!
    
    var managedContext: NSManagedObjectContext!
    var num: Decimal = 8.0

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func setGoal(){
        print("new data added")
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
      let newUser = UserMO(entity: entity, insertInto: managedContext)
        newUser.age = 25.0 as NSDecimalNumber
        newUser.waterGoal = num as NSDecimalNumber
        newUser.user = "user"
        newUser.weight = 160.0 as NSDecimalNumber
            try!  managedContext.save()
        performSegue(withIdentifier: "setupToMain", sender: nil)
    }
    
    @IBAction func calculate(){
        performSegue(withIdentifier: "calculate", sender: nil)
    }
    
    @IBAction func increase(){
        var canIncrease = true;
       
        if (num >= 16){
            canIncrease = false;
        }
        if (canIncrease){
            num += 1
            cupDisplay.text = "\(num)"
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Cant have more than 15 cups per day!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert,animated: true, completion: nil)
        }
    }
    @IBAction func decrease(){
        var canDecrease = true;
        if (num <= 1){
            canDecrease = false;
        }
        if (canDecrease){
            num -= 1
            cupDisplay.text = "\(num)"
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Cant have less than 1 cups per day!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert,animated: true, completion: nil)
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
