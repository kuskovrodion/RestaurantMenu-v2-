import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        addSubwies()
        setRegistrationContainer()
        setRegisterButton()
    }
    
    func addSubwies() {
        self.view.addSubview(mainLabel)
        self.view.addSubview(containerView)
        self.view.addSubview(registrationButton)

    }
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 36, y: 40, width: 300, height: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Registration"
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your e-mail adres"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let fieldEmailSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let fieldPasswordSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 7
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.setTitle("Registration", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
        return button
    }()
    
    @objc func saveUser(sender: UIButton!) {
            guard let email = emailTextField.text, let password = passwordTextField.text else { print ("invalid form"); return }
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                guard let uid = user?.uid else { return }
                let ref = Database.database().reference()
                let usersRef = ref.child("Users").child(uid)
                let values = ["Email" : email, "Password" : password]
                usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if err != nil {
                        print (err)
                        return
                    }
                    print ("SAVED")
                })
            }
    }
    
    func setRegisterButton() {
        registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
        registrationButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/3).isActive = true
        registrationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setRegistrationContainer() {
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        containerView.isOpaque = false
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        containerView.addSubview(emailTextField)
        containerView.addSubview(fieldEmailSeparator)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(fieldPasswordSeparator)
        
        emailTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        emailTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3).isActive = true
        
        fieldEmailSeparator.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        fieldEmailSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        fieldEmailSeparator.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -40).isActive = true
        fieldEmailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: fieldEmailSeparator.bottomAnchor, constant: 10).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3).isActive = true
        
        fieldPasswordSeparator.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        fieldPasswordSeparator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        fieldPasswordSeparator.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -40).isActive = true
        fieldPasswordSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}
