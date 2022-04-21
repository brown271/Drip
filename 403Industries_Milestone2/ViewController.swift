//
//  ViewController.swift
//  403Industries_Milestone2
//
//  Created by Brad on 2022-03-20.
//

import UIKit
import CoreData
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var continueBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    var managedContext: NSManagedObjectContext!
    //buttonSounds
    var audioPlayer = AVAudioPlayer()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //do function to play audio on button press
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "waterdrop2", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }catch{
            print(error)
        }
        
        
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        
        
        
        
       
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound] ){success, error in
            if (success){
                //notif 1
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                let notif = UNMutableNotificationContent()
                notif.title = "Let's drink some water."
                notif.body = "Hey there, looks like you should have some water."
                notif.sound = UNNotificationSound.default
                notif.badge = 1
                
                var date = DateComponents()
                date.hour = 13
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: "waterNotif", content: notif, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request){ (error) in
                    if let error = error{
                        print ("Error: \(error)")
                    }else{
                        print("Notification Scheduled")
                    }
                }
                //notif 2
                    let notif2 = UNMutableNotificationContent()
                    notif2.title = "Let's drink some more water."
                    notif2.body = "Hey there, looks like you should have some water."
                    notif2.sound = UNNotificationSound.default
                    notif2.badge = 1
                    
                    var date2 = DateComponents()
                    date2.hour = 20
                    let trigger2 = UNCalendarNotificationTrigger(dateMatching: date2, repeats: true)
                    let request2 = UNNotificationRequest(identifier: "waterNotif2", content: notif2, trigger: trigger2)
                    
                    center.add(request2){ (error) in
                        if let error = error{
                            print ("Error: \(error)")
                        }else{
                            print("Notification 2 Scheduled")
                        }
                    }
                   
                
            }else if let error = error {
                print("Yikes \(error)")
            }
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
    //get started button drip sounds
    @IBAction func Play(_ sender: Any){
        audioPlayer.play()
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

