//
//  ViewController.swift
//  403Industries_Milestone2
//
//  Created by Brad on 2022-03-20.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var continueBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    var managedContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetch : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        
        
        let delete = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do{
            try managedContext.execute(delete)
            print ("data wiped")
        }catch let error as NSError{
            print("yikes!, \(error)")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkData(){
    
        if (isUserSetup()){
          performSegue(withIdentifier: "skipSetup", sender: nil)
        }
        else{
            performSegue(withIdentifier: "setup", sender: nil)
        }
    }
    
    @IBAction func addData(){
        print("new data added")
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
      let newUser = UserMO(entity: entity, insertInto: managedContext)
        newUser.age = 5
        newUser.waterGoal = 8
        newUser.user = "alex"
        newUser.weight = 5
            try!  managedContext.save()
      
      
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
    


}

