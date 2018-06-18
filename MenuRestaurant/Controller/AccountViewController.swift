import UIKit
import Firebase

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        view.addSubview(registrationContainer)
        view.addSubview(registrationButton)
        
        setRegistrationContainer()
        setRegisterButton()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButton))
    }
    
    let registrationContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    
    lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 7
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.setTitle("DELETE", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        return button
    }()
    
    func setRegisterButton() {
        registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationButton.topAnchor.constraint(equalTo: registrationContainer.bottomAnchor,constant: 10).isActive = true
        registrationButton.widthAnchor.constraint(equalTo: registrationContainer.widthAnchor).isActive = true
        registrationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registrationButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        
        
    }
    func setRegistrationContainer() {
        registrationContainer.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        registrationContainer.isOpaque = false
        registrationContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        registrationContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15).isActive = true
        registrationContainer.heightAnchor.constraint(equalToConstant: 170).isActive = true

    }
    
    @objc func deleteUser() {
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error{
                print(error.localizedDescription)
            }else {
                let alertView = UIAlertView(title: "Delete Account", message: "You have successfully deleted your acoount. We are sorry to see you leaving us this way.", delegate: self, cancelButtonTitle: "OK, Thanks")
                alertView.show()
                let loginController = LoginViewController()
                let lc = UINavigationController(rootViewController: loginController)
                self.present(lc, animated: true, completion: nil)
            }
        })
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
