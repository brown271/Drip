//
//  WipeViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-20.
//

import UIKit
import CoreData

class WipeViewController: UIViewController {
    
    var managedContext: NSManagedObjectContext!
    
    @IBAction func wipeData(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetch : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WaterRecord")
        
        
        let delete = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do{
            try managedContext.execute(delete)
            print ("water records wiped")
            performSegue(withIdentifier: "reset", sender: nil)
        }catch let error as NSError{
            print("yikes!, \(error)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
