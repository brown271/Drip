//
//  baseViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-16.
//

import UIKit
import CoreData
import AVFoundation

class baseViewController: UIViewController {
    
    @IBOutlet var currentCups: UILabel!
    @IBOutlet var cupGoal:UILabel!
    
    var user: UserMO!
    var currentDay: WaterRecordMO!
    var managedContext: NSManagedObjectContext!
    var audioPlayer3 = AVAudioPlayer()

    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        super.viewDidLoad()
        loadUser()
        cupGoal.text = "\(user.waterGoal)"
        loadRecord()
        // Do any additional setup after loading the view.
        
        //sound function 3
        do{
            audioPlayer3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "waterdrop8", ofType: "mp3")!))
            audioPlayer3.prepareToPlay()
        }catch{
            print(error)
        }
    }
    
    @IBAction func Play3(_ sender: Any){
        audioPlayer3.play()
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
        
        var isCurrentDay = false
        //records are too long
        
            print(count)
            do{
                let records = try managedContext.fetch(fetch)
                var oldest = records.first
                for r in records{
                    print(r.date!)
                    if (r.date! < oldest!.date!){
                        oldest = r
                    }
                    if (isSameDay(date1: r.date!, date2: Date.now)){
                        isCurrentDay = true;
                        currentDay = r
                        currentCups.text = "\(r.currentWater!)"
                    }
                }
                if count > 8 {
                print("deleting oldest record")
                 managedContext.delete(oldest!)
                try managedContext.save()
                }
            }catch{
                fatalError("Yikes! \(error)")
            }
            
        
         //good to make new record
        if(!isCurrentDay){
            print("New Day new Record!")
            let entity = NSEntityDescription.entity(forEntityName: "WaterRecord", in: managedContext)!
          let currentDay = WaterRecordMO(entity: entity, insertInto: managedContext)
            currentDay.date = Date.now
            currentDay.currentWater = 0.0
                try!  managedContext.save()
            currentCups.text = "0"
        }
            
        
    }
    
    
    
  
    func isSameDay(date1: Date, date2: Date) ->Bool{
        let dayDiff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if (dayDiff.day == 0){
            return true
        }
        return false
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
