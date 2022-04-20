//
//  HitsoryViewController.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-20.
//

import UIKit
import CoreData

class HitsoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var managedContext: NSManagedObjectContext!
    var user: UserMO!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let fetch: NSFetchRequest<WaterRecordMO> = WaterRecordMO.fetchRequest()
        
        fetch.predicate = NSPredicate(format: "date != nil")
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        let count = (try? managedContext.count(for: fetch)) ?? 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetch: NSFetchRequest<WaterRecordMO> = WaterRecordMO.fetchRequest()
        
        fetch.predicate = NSPredicate(format: "date != nil")
        
        let count = (try? managedContext.count(for: fetch)) ?? 0
        
        let request: NSFetchRequest<UserMO> = UserMO.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(UserMO.user), "user"])
        
        do {
            let results = try managedContext.fetch(request)
            user = results.first
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    
        
        
        //records are too long
        
            print(count)
            do{
                let records = try managedContext.fetch(fetch)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                dateFormatter.locale = Locale(identifier: "en_US")
                let date = dateFormatter.string(from:records[indexPath.row].date!)
                cell.date.text = "\(date)"
                cell.text.text = "You Drank \(records[indexPath.row].currentWater!) / \(user.waterGoal) Cups!"
                
            }catch{
                fatalError("Yikes! \(error)")
            }
        return cell;
    }
         //good to make new record
       
    

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
