//
//  HBViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-19.
//

import UIKit

class HBViewController: UIViewController {
    //headers and info, indexes are corolated
    var headers = ["Healthy Blood", "Clean Bladder", "Less Pain", "Blood Pressure", "<3","Lose Weight","Hot Bod?","Less migraines","Productivity","Immune System","Less Stress","Working out?","Clogged Pipes","Great Skin","Rock Collection"]
    var info = ["Water helps to carry nutrients and oxygen throughout your bloodstream", "Drinking alot of water helps to clear bacteria from your bladder", "Water is proven to prevent constipation and cushion joint movements", "Drinking enough water daily helps to normalize blood pressure and stop spikes", "Water is proven to help stabilize the hearbeat","Water helps you feel full, and can help you lose weight","Water helps regulate body temperate and minimize both cold and hot spikes","Studies show drinking enough water decreases the amount of migraines experienced.","Having enough water and being hydrated increases our ability to focus on tasks","Drinking enough water increases your ability to fight off infection!","By being hydrated, we provide our brain with less opprotunites to stress!","Being properly hydrated allows the body to operate at peak efficency for longer. Making workouts better.","Water increases the bodies ability to make bowel movements easier","Water hydrates your skin and makes you look younger and more alive","By diluting harmful buildup, water decreases the chance for kidney stones to form. "]
    @IBOutlet var topHeader: UILabel!
    @IBOutlet var topInfo: UITextView!
    @IBOutlet var botHeader: UILabel!
    @IBOutlet var botInfo: UITextView!
    
    @IBAction func randomize(){
        let rand = Int.random(in: 0..<headers.count)
        var rand2 = Int.random(in: 0..<headers.count)
        while (rand == rand2){
            rand2 = Int.random(in: 0..<headers.count)
        }
        topHeader.text = headers[rand]
        topInfo.text = info[rand]
        botHeader.text = headers[rand2]
        botInfo.text = info[rand2]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rand = Int.random(in: 0..<headers.count)
        var rand2 = Int.random(in: 0..<headers.count)
        while (rand == rand2){
            rand2 = Int.random(in: 0..<headers.count)
        }
        topHeader.text = headers[rand]
        topInfo.text = info[rand]
        botHeader.text = headers[rand2]
        botInfo.text = info[rand2]
        
        
        

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
