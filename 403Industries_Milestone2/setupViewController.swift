//
//  setupViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-16.
//

import UIKit

class setupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet var cupDisplay: UILabel!
    
    @IBAction func setGoal(){
        
    }
    
    @IBAction func calculate(){
        performSegue(withIdentifier: "calculate", sender: nil)
    }
    
    @IBAction func increase(){
        var canIncrease = true;
        let num = Decimal(string: cupDisplay.text!)!
        if (num >= 15){
            canIncrease = false;
        }
        if (canIncrease){
            cupDisplay.text = "\(num + 0.5)"
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Cant have more than 15 cups per day!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert,animated: true, completion: nil)
        }
    }
    @IBAction func decrease(){
        var canDecrease = true;
        let num = Decimal(string: cupDisplay.text!)!
        if (num <= 1){
            canDecrease = false;
        }
        if (canDecrease){
            cupDisplay.text = "\(num - 0.5)"
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
