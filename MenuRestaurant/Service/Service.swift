import UIKit
import Firebase

class Service {
    
    var lvc: LoginViewController?
    var rvc: RegistrationViewController?
    
    static let sharedInstance = Service()
    private init(){}
    
    func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
        let mainContainer: UIView = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        mainContainer.alpha = 1
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = .black
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if startAnimate!{
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
        }else{
            for subview in viewContainer.subviews{
                if subview.tag == 789456123{
                    subview.removeFromSuperview()
                }
            }
        }
        return activityIndicatorView
    }
    

    
    
    
    
//    @objc func saveUser() {
//        guard let email = rvc?.emailTextField.text, let password = rvc?.passwordTextField.text else {
//            print ("invalid")
//            return
//        }
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//            if error != nil {
//                print(error ?? "")
//                return
//            }
//            guard let uid = user?.uid else { return }
//            let ref = Database.database().reference()
//            let usersRef = ref.child("Users").child(uid)
//            let values = ["Email" : email, "Password" : password]
//            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
//                if err != nil {
//                    print (err ?? "")
//                    return
//                }
//                print ("SAVED")
//            })
//        }
//    }
//
//    @objc func loginUser() {
//        guard let email = lvc?.emailTextField.text, let password = lvc?.passwordTextField.text else {
//            print ("invalid")
//            return
//        }
//
//        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//            if user != nil {
//                print("SUCCESS")
//
//            } else {
//                let err = error?.localizedDescription
//                print (err ?? "")
//            }
//        }
//    }
}
