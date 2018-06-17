import UIKit

class AddDishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubwies()
        self.view.backgroundColor = .yellow
        addBackButton()
        setFields()
        setSaveButton()
    }
    
    func addSubwies() {
        self.view.addSubview(containerView)
        self.view.addSubview(saveButton)
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
//        button.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
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
    
    
    
    
}
