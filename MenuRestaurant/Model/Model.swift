// Builder maket for entities
import UIKit
import Firebase

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
    var dishWeight: Double
    var dishCost: Double
    var dishImage: UIImage
    
    init (dishName: String, dishDesc: String, dishWeight: Double, dishCost: Double, dishImage: UIImage) {
        self.dishName = dishName
        self.dishDesc = dishDesc
        self.dishWeight = dishWeight
        self.dishCost = dishCost
        self.dishImage = dishImage
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






























