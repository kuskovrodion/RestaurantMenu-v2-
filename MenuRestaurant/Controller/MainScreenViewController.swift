import UIKit
import Firebase

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        checkIfUserIsLoggedIn()
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
