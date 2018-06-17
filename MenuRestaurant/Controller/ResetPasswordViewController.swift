import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        addBackButton()
        
        view.addSubview(ResetText)
        view.addSubview(ResetInstructionText)
        
        view.addSubview(registrationContainer)
        view.addSubview(resetButton)
        setupEmailTextField()
        setupResetButton()
    }
    
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setTitle("Cancel", for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
    let ResetText: UILabel = {
        var text = UILabel()
        text.frame = CGRect(x: 28, y: 100, width: 330, height: 40)
        text.font = UIFont(name: "Hoefler Text", size: 40)
        text.textColor = UIColor.orange
        text.textAlignment = NSTextAlignment.center
        text.text = "Password retrieval"
        return text
    }()
    
    let ResetInstructionText: UILabel = {
        let text = UILabel ()
        text.text = "Please enter email that you used to  sign in to the site."
        text.frame = CGRect(x: 33, y: 250, width: 300, height: 40)
        text.font = UIFont(name: "Hoefler Text", size: 17)
        text.lineBreakMode = .byWordWrapping
        text.textAlignment = NSTextAlignment.center;
        text.numberOfLines = 0
        text.textColor = .black
        return text
    }()
    
    let registrationContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let userEmailTextField: UITextField = {
        let uetf = UITextField()
        uetf.placeholder = "Enter your email"
        uetf.translatesAutoresizingMaskIntoConstraints = false
        return uetf
    }()
    
    lazy var resetButton: UIButton = {
        let resetButton = UIButton(type: .system)
        resetButton.setTitleColor(UIColor.orange, for: UIControlState.normal)
        resetButton.setTitle("Sumbit", for: .normal)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        return resetButton
        
    }()
    
    func setupResetButton() {
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.topAnchor.constraint(equalTo: registrationContainer.bottomAnchor,constant: 10).isActive = true
        resetButton.widthAnchor.constraint(equalTo: registrationContainer.widthAnchor).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        resetButton.addTarget(self, action: #selector(reseting), for: .touchUpInside)
        self.view.addSubview(resetButton)
    }
    
    func setupEmailTextField() {
        
        registrationContainer.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        registrationContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        registrationContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15).isActive = true
        registrationContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registrationContainer.addSubview(userEmailTextField)
        
        userEmailTextField.leftAnchor.constraint(equalTo: registrationContainer.leftAnchor, constant: 12).isActive = true
        userEmailTextField.topAnchor.constraint(equalTo: registrationContainer.topAnchor).isActive = true
        userEmailTextField.widthAnchor.constraint(equalTo: registrationContainer.widthAnchor).isActive = true
        userEmailTextField.heightAnchor.constraint(equalTo: registrationContainer.heightAnchor, multiplier: 1/1).isActive = true
        
        
    }
    
    
    @objc func reseting() {
        if self.userEmailTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Email field can't be empty. Enter an email.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().sendPasswordReset(withEmail: self.userEmailTextField.text!, completion: { (error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "There are no users with this email. Check email and try againg.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.userEmailTextField.text = ""
                    let alert = UIAlertController(title: "Success!", message: "Check your email.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    
    
    
    
    
}
