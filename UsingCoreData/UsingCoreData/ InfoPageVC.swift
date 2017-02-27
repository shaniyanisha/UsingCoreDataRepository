//
//  InfoPageVCViewController.swift
//  HitList
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit
import CoreData
class InfoPageVC: UIViewController {
  
    //mark : IBOutlets
    @IBOutlet weak var infoTableview: UITableView!
  
    //Mark:Variables
    var tableIndexPath = [IndexPath]()
    var people = [Person]()
    var arrayOfIndexpath = [IndexPath]()
   // var selectedPerson = Person()
    
    
  
   var infoList = ["Name","Gender","Address"]
  
  
    @IBOutlet weak var doneButton: UIButton!
  
    //Mark: View Life Cycle
    override func viewDidLoad() {
      
        super.viewDidLoad()
      
        // datasource and delegate
        infoTableview.dataSource = self
        infoTableview.delegate = self
      
        //Rgesiter tableview cell
        let cellnib = UINib(nibName: "TableViewCell", bundle: nil)
        infoTableview.register(cellnib, forCellReuseIdentifier: "TableViewCellID")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //IBAction of done button
    @IBAction func done(_ sender: UIButton) {
      
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
       
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext
      
      let entity = NSEntityDescription.entity(forEntityName: "Person",
                                              in: managedContext)!
      
      let person = Person(entity: entity, insertInto: managedContext)
      
      //for loop that goes when the indexpath of people goes to selectedPerson array
      for indices in tableIndexPath.indices{
      
      let cell = infoTableview.cellForRow(at: tableIndexPath[indices]) as! TableViewCell
        
        
      switch indices{
        
      case 0 :
        person.name = cell.requirmentAnswer.text
        
      case 1 :
        person.gender = cell.requirmentAnswer.text
        
        
      case 2 :
        person.address = cell.requirmentAnswer.text
        
        
              
      default: break
        
        }
        
      }

        do {
        
        try managedContext.save()
        
        people.append(person)
        
        }
        
        catch let error as NSError {
        
        print("Could not save. \(error), \(error.userInfo)")
        
      }
      
      
    }

}
//Mark : extension od InfoPageVc
extension  InfoPageVC : UITableViewDataSource,UITableViewDelegate{
  
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
    return infoList.count
    
    }
  
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
  
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellID", for: indexPath) as! TableViewCell
    
      
        cell.requirement.text = infoList[indexPath.row]
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        cell.requirmentAnswer.placeholder = infoList[indexPath.row]
        tableIndexPath.append(indexPath)
      
  
        return cell
      
   }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
    
   return 90
    
  }
  
     
}




  
    
    
  


