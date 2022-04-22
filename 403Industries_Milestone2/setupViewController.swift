//
//  setupViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-16.
//

import UIKit
import CoreData
import AVFoundation

class setupViewController: UIViewController {
    
    @IBOutlet var cupDisplay: UILabel!
    
    var managedContext: NSManagedObjectContext!
    //defauly cup number
    var num: Int32 = 8
    var audioPlayer2 = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        // Do any additional setup after loading the view.
        
        //sounds function 2
        do{
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "waterdrop6", ofType: "mp3")!))
            audioPlayer2.prepareToPlay()
        }catch{
            print(error)
        }
    }
    
    
    
    
    @IBAction func setGoal(){
        //create a user with some defualt values
        print("new data added")
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
      let newUser = UserMO(entity: entity, insertInto: managedContext)
        newUser.age = 25
        newUser.waterGoal = num
        newUser.user = "user"
        newUser.weight = 160
            try!  managedContext.save()
        //segue out to next page
        performSegue(withIdentifier: "setupToMain", sender: nil)
    }
    
    @IBAction func calculate(){
        performSegue(withIdentifier: "calculate", sender: nil)
    }
    
    @IBAction func Play2(_ sender: Any){
        audioPlayer2.play()
    }
    
    //increase by one and alert user if too many cups
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
    //decrease by one and alert user if too many cups
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
