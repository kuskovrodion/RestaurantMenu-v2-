import UIKit
import Firebase
class AddDishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubwies()
        self.view.backgroundColor = .yellow
        addBackButton()
        setFields()
        setSaveButton()
        setRegisterButton()
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func handleGesture() {
        print ("Deleted")
    }
    
    func addSubwies() {
        self.view.addSubview(containerView)
        self.view.addSubview(saveButton)
        self.view.addSubview(deleteAccountButton)
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
    
    lazy var deleteAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 7
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Delete account?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        return button
    }()
    
    func setRegisterButton() {
        deleteAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteAccountButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor,constant: 10).isActive = true
        deleteAccountButton.widthAnchor.constraint(equalTo: saveButton.widthAnchor).isActive = true
        deleteAccountButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        deleteAccountButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var dishName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter dish name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        return textField
    }()

    var dishDesc: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter dish desc"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 7
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkAndSaveDish), for: .touchUpInside)
        return button
    }()
    
    func setSaveButton() {
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
        saveButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 2/3).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func setFields() {
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        containerView.isOpaque = false
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        containerView.addSubview(dishName)
        containerView.addSubview(dishDesc)
        
        dishName.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        dishName.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dishName.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        dishName.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/4).isActive = true
        
        dishDesc.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        dishDesc.topAnchor.constraint(equalTo: dishName.bottomAnchor, constant: 10).isActive = true
        dishDesc.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        dishDesc.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/4).isActive = true
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
    
    @objc func checkAndSaveDish() {
        if dishName.text != "" && dishDesc.text != "" {
            let dish = Dish(dishName: dishName.text!, dishDesc: dishDesc.text!)
            dish.saveIntoDatabase()
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Ooops...", message: "One of fields cannot be blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
