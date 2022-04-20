//
//  baseViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-16.
//

import UIKit
import CoreData

class baseViewController: UIViewController {
    
    @IBOutlet var currentCups: UILabel!
    @IBOutlet var cupGoal:UILabel!
    
    var user: UserMO!
    var currentDay: WaterRecordMO!
    var managedContext: NSManagedObjectContext!

    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        super.viewDidLoad()
        loadUser()
        cupGoal.text = "\(user.waterGoal)"
        loadRecord()
        // Do any additional setup after loading the view.
    }
    
    func loadUser(){
        let request: NSFetchRequest<UserMO> = UserMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(UserMO.user), "user"])
        
        do {
            let results = try managedContext.fetch(request)
            user = results.first
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    
    }
    
    func loadRecord(){
        let fetch: NSFetchRequest<WaterRecordMO> = WaterRecordMO.fetchRequest()
        
        fetch.predicate = NSPredicate(format: "date != nil")
        
        let count = (try? managedContext.count(for: fetch)) ?? 0
        
    
        //records are too long
        if count >= 3 {
            do{
                let records = try managedContext.fetch(fetch)
                for r in records{
                    print(r.date!)
                }
            }catch{
                fatalError("Yikes! \(error)")
            }
            
        }
        else{ //good to make new record
            let entity = NSEntityDescription.entity(forEntityName: "WaterRecord", in: managedContext)!
          let currentDay = WaterRecordMO(entity: entity, insertInto: managedContext)
            currentDay.date = Date.now
            currentDay.currentWater = 0.0
                try!  managedContext.save()
            currentCups.text = "0"
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
