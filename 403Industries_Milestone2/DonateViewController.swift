//
//  DonateViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-20.
//

import UIKit

class DonateViewController: UIViewController {
    
    @IBAction func donate(){
        //inform user to save their money
        let alert = UIAlertController(title: "Thanks :)", message: "Thanks for offering to donate, please keep your money. If you want to help, let others know about Drip!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true, completion: nil)
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
