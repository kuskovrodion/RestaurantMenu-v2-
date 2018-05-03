import UIKit
import Firebase

class FirebaseFunctions {
    
    var xd: Test?
    
    static let sharedInstance = FirebaseFunctions()
    private init(){}

    var rvc: RegistrationViewController?
    var lvc: LoginViewController?
    

    @objc func saveUser() {
        guard let email = rvc?.emailTextField.text, let password = rvc?.passwordTextField.text else {
            print ("invalid")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            guard let uid = user?.uid else { return }
            let ref = Database.database().reference()
            let usersRef = ref.child("Users").child(uid)
            let values = ["Email" : email, "Password" : password]
            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print (err ?? "")
                    return
                }
                print ("SAVED")
            })
        }
    }
    
    @objc func loginUser() {
        guard let email = lvc?.emailTextField.text, let password = lvc?.passwordTextField.text else {
            print ("invalid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                self.xd?.test()
                print("SUCCESS")
                
            } else {
                let err = error?.localizedDescription
                print (err ?? "")
            }
        }
    }
}
