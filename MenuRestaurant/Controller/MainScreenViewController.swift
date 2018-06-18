import UIKit
import Firebase

class MainScreenViewController: UITableViewController {
    
    var dishes = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DishCell.self, forCellReuseIdentifier: "cellID")
        self.view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAcc))
        inserting()
        checkIfUserIsLoggedIn()
        print(dishes)
    }

    func inserting() {
        Database.database().reference().child("Dish").observe(.childAdded) { (snapshot) in
            DispatchQueue.main.async {
                let newDish = Dish(snapshot: snapshot)
                self.dishes.insert(newDish, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .top)
                print(snapshot)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = DishCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellID")
        let dish = dishes[indexPath.row ]
        cell.textLabel?.text = dish.dishName
        cell.detailTextLabel?.text = dish.dishDesc
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    @objc func goToAcc() {
        let addDishController = AddDishViewController()
        let lc = UINavigationController(rootViewController: addDishController)
        present(lc, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    print(snapshot)
                    self.navigationItem.title = dictionary["Email"] as? String
                } else {
                    self.navigationItem.title = "anonymous"
                }
            }, withCancel: nil)
        }
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            print("Success")
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginViewController()
        let lc = UINavigationController(rootViewController: loginController)
        present(lc, animated: true, completion: nil)

    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }

}
