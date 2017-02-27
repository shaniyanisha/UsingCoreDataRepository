//
//  EditTableViewVC.swift
//  HitList
//
//  Created by Appinventiv on 27/02/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit
import CoreData
class EditTableViewVC: UIViewController {
  
  
    @IBOutlet weak var infoTableView: UITableView!
  
    //Mark:Variables
    var tableIndexPath = [IndexPath]()
    var people = [Person]()
   // var arrayOfIndexpath = [IndexPath]()
    var selectedPerson : Person!
    var selectionMode : Modes = .edit
    
    var infoList = ["Name","Gender","Address"]
    
    @IBOutlet weak var doneButton: UIButton!
    
   
    
    //Mark: View Life Cycle
    override func viewDidLoad() {
      
      super.viewDidLoad()
      
      // datasource and delegate
      infoTableView.dataSource = self
      infoTableView.delegate = self
      
      //Rgesiter tableview cell
      let cellnib = UINib(nibName: "EditTableViewCell", bundle: nil)
      infoTableView.register(cellnib, forCellReuseIdentifier: "EditTableViewCellID")
      if selectionMode == .edit{
        
        infoTableView.isUserInteractionEnabled = true
        doneButton.isHidden = false
      }
      else{
        
        infoTableView.isUserInteractionEnabled = false
        doneButton.isHidden = true
        
      }
  
    }
    
  
    @IBAction func done(_ sender: UIButton) {
      
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        
        return
      }
      
      let managedContext = appDelegate.persistentContainer.viewContext
      
        for indices in tableIndexPath.indices{
        
        let cell = self.infoTableView.cellForRow(at: tableIndexPath[indices]) as! EditTableViewCell
        
        
        switch indices{
          
        case 0 :
          selectedPerson.name = cell.requirementAnswer.text
          
        case 1 :
          selectedPerson.gender = cell.requirementAnswer.text
          
          
        case 2 :
          selectedPerson.address = cell.requirementAnswer.text
          
          
          
        default: break
          
        }
        
      }

      
      
      do {
        
        try managedContext.save()
        
        
        
      }
        
      catch let error as NSError {
        
        print("Could not save. \(error), \(error.userInfo)")
        
      }
      
      
    }
  
  }

  //Mark : extension od InfoPageVc
  extension  EditTableViewVC : UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
      
      return infoList.count
      
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCellID", for: indexPath) as! EditTableViewCell
      
      
      cell.requirement.text = infoList[indexPath.row]
      cell.layer.borderColor = UIColor.gray.cgColor
      cell.layer.borderWidth = 1
      cell.requirementAnswer.placeholder = infoList[indexPath.row]
      tableIndexPath.append(indexPath)
      
        switch indexPath.row {
          
        case 0:
          cell.requirementAnswer.text =  selectedPerson.name
          
        case 1:
          cell.requirementAnswer.text =  selectedPerson.gender
          
        case 2:
          cell.requirementAnswer.text =  selectedPerson.address
          
          
        default:
          print("break")
          
        }
        
      
      return cell
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
      
      return 90
      
    }
    
    
  }
  
  
  
  
  
  
  
  
  
  
