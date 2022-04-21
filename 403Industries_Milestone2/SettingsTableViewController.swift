//
//  SettingsTableViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-19.
//

import UIKit
import CoreData
import UserNotifications

class SettingsTableViewController: UITableViewController {

    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var ageLbl: UILabel!
    @IBOutlet var cupsLbl: UILabel!
    
    @IBOutlet var weightSlider: UISlider!
    @IBOutlet var ageSlider: UISlider!
    @IBOutlet var cupsSlider: UISlider!
    
    @IBOutlet var notifSwitch: UISwitch!
    
    var user: UserMO!
    
    
    
    @IBAction func updateNotifs(){
        let current = UNUserNotificationCenter.current()
        
        if (notifSwitch.isOn){
            current.getNotificationSettings(completionHandler:{ (settings) in
                if (settings.authorizationStatus == .notDetermined){
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound] ){ success, error in
                        if (success){
                            print("bababooey")
                            self.addNotifications()
                        }
                    }
                    
                }else if settings.authorizationStatus == .denied{
                    print("yeah")
                    DispatchQueue.main.async{
                        
                    let alert = UIAlertController(title: "Error", message: "Looks like notifications are off. Please turn them on in settings.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert,animated: true, completion: nil)
                        self.notifSwitch.isOn = false
                    }
                    
                } else if settings.authorizationStatus == .authorized{
                    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    self.addNotifications()
                }
            })
            
        }else{
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

            
        }
    }
    
    var managedContext: NSManagedObjectContext!
    var age: Int32 = 25
    var weight: Int32 = 160
    
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
    
    @IBAction func showPriv(){
        let alert = UIAlertController(title: "Hi There!", message: "Drip doesn't send any of your information anywhere. It's all stored locally on your phone and never accesed by us.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cool, Thanks!", style: .default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        print(isUserSetup())
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: {(settings) in
            if settings.authorizationStatus != .authorized{
                DispatchQueue.main.async{
                    self.notifSwitch.isOn = false
                }
            }
        })
        loadUser()
        ageLbl.text = "\(user.age)"
        age = user.age
        ageSlider.value = Float(age)
        weightLbl.text = "\(user.weight)"
        weight = user.weight
        weightSlider.value = Float(weight)
        cupsLbl.text = "\(user.waterGoal)"
        cupsSlider.value = Float(user.waterGoal)
        
       

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
    
    func addNotifications(){
        //notif 1
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
           
            let fetch : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
            
            
            let delete = NSBatchDeleteRequest(fetchRequest: fetch)
            do{
                try managedContext.execute(delete)
                print ("User Updated")
            }catch let error as NSError{
                print("yikes!, \(error)")
            }
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
            let newUser = UserMO(entity: entity, insertInto: managedContext)
            newUser.age = age
        newUser.waterGoal = Int32(Int(cupsLbl.text!)!)
            newUser.user = "user"
            newUser.weight = weight
       
                try!  managedContext.save()

        
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
