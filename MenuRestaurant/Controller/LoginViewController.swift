import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var service: Service?
    var msc: MainScreenViewController?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        addSubwies()
        setRegistrationContainer()
        setButtons()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Registration", style: .plain, target: self, action: #selector(toRegistrationController))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true )
    }
    
    func addSubwies() {
        self.view.addSubview(mainLabel)
        self.view.addSubview(containerView)
        self.view.addSubview(loginButton)
        self.view.addSubview(anonButton)
        self.view.addSubview(resetPWButton)
    }
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 36, y: 40, width: 300, height: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Login"
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    var emailTextField: UITextField = {
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
    
    var passwordTextField: UITextField = {
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
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 7
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginUser), for: .touchUpInside)

        return button
    }()
    
    lazy var anonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.setTitle("Go as anonym", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(anonymAuth), for: .touchUpInside)
        return button
    }()
    
    lazy var resetPWButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.setTitle("Forgot password?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toResetPasswordViewController), for: .touchUpInside)
        return button
    }()
    
    
    func setButtons() {
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
        loginButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 2/3).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        anonButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        anonButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        anonButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor, multiplier: 2/3).isActive = true
        anonButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        resetPWButton.centerXAnchor.constraint(equalTo: anonButton.centerXAnchor).isActive = true
        resetPWButton.topAnchor.constraint(equalTo: anonButton.bottomAnchor, constant: 10).isActive = true
        resetPWButton.widthAnchor.constraint(equalTo: anonButton.widthAnchor, multiplier: 1).isActive = true
        resetPWButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
    
    @objc func toRegistrationController() {
        let regController = RegistrationViewController()
        let navController = UINavigationController(rootViewController: regController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func toMainScreenViewController() {
        let regController = MainScreenViewController()
        let navController = UINavigationController(rootViewController: regController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func toResetPasswordViewController() {
        let regController = ResetPasswordViewController()
        let navController = UINavigationController(rootViewController: regController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func anonymAuth() {
        self.service = Service.sharedInstance
        self.service?.customActivityIndicatory(self.view, startAnimate: true)
        Auth.auth().signInAnonymously() { (user, error) in
            if error != nil {
                self.service?.customActivityIndicatory(self.view, startAnimate: false)
                print (error ?? "")
                return
            } else {
                print ("User anon uid: \(user?.uid)")
                self.service?.customActivityIndicatory(self.view, startAnimate: false)
                self.toMainScreenViewController()
            }
        }
    }
    
    @objc func loginUser() {
        self.service = Service.sharedInstance
        self.service?.customActivityIndicatory(self.view, startAnimate: true)
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print ("invalid")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                self.service?.customActivityIndicatory(self.view, startAnimate: false)
                self.dismiss(animated: true, completion: nil)
                print("SUCCESS")
            } else {
                self.service?.customActivityIndicatory(self.view, startAnimate: false)
                let alert = UIAlertController(title: "Login Error", message: "Please check that you have entered your login and password correctly.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
