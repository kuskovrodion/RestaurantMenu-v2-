// Builder maket for entities
import UIKit
import Firebase
import SwiftyJSON

class User {
    var userLogin: String?
    var userPassword: String?
    
    init (dictionary: [String: AnyObject]) {
        self.userLogin = dictionary["login"] as? String
        self.userPassword = dictionary["pass"] as? String
    }
    
}

class Dish {
    var dishName: String
    var dishDesc: String
    
    init (dishName: String, dishDesc: String) {
        self.dishName = dishName
        self.dishDesc = dishDesc
    }
    
    init (snapshot: DataSnapshot) {
        let json = JSON(snapshot.value ?? "")
        self.dishName = json["Description"].stringValue
        self.dishDesc = json["Name"].stringValue
    }
    
    func saveIntoDatabase() {
        let dishRef = Database.database().reference().child("Dish").childByAutoId()
        let newDishDict = ["Name" : self.dishName, "Description": self.dishDesc]
        dishRef.setValue(newDishDict)
    }
}

class Drink {
    var drinkName: String
    var drinkDesc: String
    var drinkCapacity: Double
    var drinkCost: Double
    var drinkImage: UIImage
    
    init (drinkName: String, drinkDesc: String, drinkCapacity: Double, drinkCost: Double, drinkImage: UIImage) {
        self.drinkName = drinkName
        self.drinkDesc = drinkDesc
        self.drinkCapacity = drinkCapacity
        self.drinkCost = drinkCost
        self.drinkImage = drinkImage
    }
}

class Test: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}






























