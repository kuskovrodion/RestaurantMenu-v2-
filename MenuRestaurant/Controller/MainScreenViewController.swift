import UIKit
import Firebase

class MainScreenViewController: UITableViewController {
    
    var dishes = ["1","2","3","4","5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DishCell.self, forCellReuseIdentifier: "cellID")
        self.view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAcc))
        checkIfUserIsLoggedIn()
        //----------
//        let tabBarController = UITabBarController()
    
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! DishCell
        cell.textLabel!.text = "\(dishes[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
//    @objc func addDishButton() {
//        let addDishController = AddDishViewController()
//        let lc = UINavigationController(rootViewController: addDishController)
//        present(lc, animated: true, completion: nil)
//    }
    
        @objc func goToAcc() {
            let addDishController = AccountViewController()
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
    
    


}
