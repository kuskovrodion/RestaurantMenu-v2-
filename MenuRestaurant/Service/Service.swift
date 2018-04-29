import UIKit
import Firebase

class FirebaseFunctions {
    
    var xd: Test?
    
    static let sharedInstance = FirebaseFunctions()
    private init(){}

    var test: RegistrationViewController?

    @objc func saveUser() {
        guard let email = test?.emailTextField.text, let password = test?.passwordTextField.text else {
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
        guard let email = test?.emailTextField.text, let password = test?.passwordTextField.text else {
            print ("invalid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                print("SUCCESS?")
                self.xd?.test()
                print("DA")
                
            } else {
                let err = error?.localizedDescription
                print (err ?? "")
            }
        }
    }
}
