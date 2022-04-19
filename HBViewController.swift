//
//  HBViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-19.
//

import UIKit

class HBViewController: UIViewController {
    var headers = ["H1", "H2", "H3", "H4", "H5"]
    var info = ["First header info", "Second header info", "Third header info", "Fourth header info", "fifth header info"]

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
