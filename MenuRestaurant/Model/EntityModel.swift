// Builder maket for User entity
import UIKit
import Firebase

class User {
    var userLogin: String
    var userPassword: String
    
    init (userLogin: String, userPassword: String) {
        self.userLogin = userLogin
        self.userPassword = userPassword
    }
    
    func saveIntoDatabase() {
        
    }
    
}
