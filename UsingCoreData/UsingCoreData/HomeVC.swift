
import UIKit
import CoreData

class HomeVC: UIViewController {
  
    //MARK:properties
    var people = [Person]()
  
    //Mark : IBOutlets
    @IBOutlet weak var userProfileTableView: UITableView!
     //Mark : *---------View life Cycle-----*
     override func viewDidLoad() {
     super.viewDidLoad()
      
     //setting the title
     title = "Profile"
      
     //Register table view cell
     let cellnib = UINib(nibName: "InfoPageTableViewCell", bundle: nil)
     userProfileTableView.register(cellnib, forCellReuseIdentifier: "InfoPageTableViewCellID")
    
      //DataSource and delegates
     userProfileTableView.dataSource = self
      userProfileTableView.delegate = self
    
    }
  
  
     //*--------View Will Appear -----*
      override func viewWillAppear(_ animated: Bool) {
        
      super.viewWillAppear(animated)

      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
      
      }

      let managedContext = appDelegate.persistentContainer.viewContext

      let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
    
      do {
      
      people = try managedContext.fetch(fetchRequest)
      
      }
      
      catch let error as NSError {
      
      print("Could not fetch. \(error), \(error.userInfo)")
    
      }
      
       userProfileTableView.reloadData()
        
  }
  
  //IBAction of add button
   @IBAction func addName(_ sender: UIButton) {

    //once the addName button clicks new view controllers pushes
    guard let previewProfileInfo = storyboard?.instantiateViewController(withIdentifier: "InfoPageVCID") as? InfoPageVC
      
    else{
      
     fatalError("previewProfileInfo not found")
    
    }
    
     self.navigationController?.pushViewController(previewProfileInfo, animated: true)
    
    }
  
  }


// MARK: - UITableViewDataSource UITableViewDelegate
extension HomeVC: UITableViewDataSource , UITableViewDelegate{
  
  
  //Number of rows in Section
  func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
    
  return people.count
    
  }
  //Returns the cell
  func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell{

              let person = people[indexPath.row]
    
             //cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoPageTableViewCellID",for: indexPath) as? InfoPageTableViewCell
    
            //making label and storing the name of user in it
            cell?.textLabel?.text = person.name
    
          //return the cell
          return cell!
 
  }
  
  
  //called when the cell of homepageVC gets selected
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
           // new view controllers pushes
           let previewProfileInfo = storyboard?.instantiateViewController(withIdentifier: "EditTableViewVCID") as! EditTableViewVC
      
          //the indexpath of people goes to selectedPerson whic is an array
          previewProfileInfo.selectedPerson = people[indexPath.row]
          previewProfileInfo.selectionMode = .view
    
           self.navigationController?.pushViewController(previewProfileInfo, animated: true)
    
    
    
  }
  //for edit action of row
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
    
    //for editing the details of row
    let edit = UITableViewRowAction(style: .normal,
                                    title: "Edit",
                                    handler: {(action: UITableViewRowAction,index: IndexPath) -> Void in
                                      
                                      
                                      //pushing the UserdetailsVC view controller
                                      guard let userDetailPage = self.storyboard?.instantiateViewController(withIdentifier: "EditTableViewVCID") as? EditTableViewVC else {
                                        return
                                      }
                                      
                                      //storing the index path of selected user's cell
                                      userDetailPage.selectedPerson = self.people[indexPath.row]
                                      
                                      //selecting the edit mode
                                      userDetailPage.selectionMode = .edit
                                      
                                      self.navigationController?.pushViewController(userDetailPage, animated: true)
    })
    
    //for deleting the row
    let delete = UITableViewRowAction(style: .normal, title: "Delete", handler: {(action : UITableViewRowAction, index : IndexPath) -> Void  in
      
      // for genrating the alert of conformation
      let alert = UIAlertController(title: "Conform",
                                    message: "do you want to delete",
                                    preferredStyle: .alert)
      //for save action of alert
      let deleteAction = UIAlertAction(title: "delete", style: .default)
      {
        [unowned self] action in
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let person = self.people[indexPath.row]
        self.people.remove(at: indexPath.row)
        managedContext.delete(person)
        do {
          try managedContext.save()
        } catch let error as NSError {
          
          print("Could not save. \(error), \(error.userInfo)")
          
        }
        //reload table view after alert genration
        self.userProfileTableView.reloadData()
      }
      
      //for canclation of alert
      let cancleAction = UIAlertAction(title: "cancle", style: .cancel)
      alert.addAction(deleteAction)
      alert.addAction(cancleAction)
      
      self.present(alert, animated: true)
    })
    
    return [edit,delete]
  }
  
}
