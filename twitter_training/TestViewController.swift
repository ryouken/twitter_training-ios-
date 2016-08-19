import UIKit
import SwiftCop

class TestViewController: UIViewController {
    @IBOutlet weak var emailMessage: UILabel!
//    @IBOutlet weak var passwordMessage: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var password: UITextField!
    
    let swiftCop = SwiftCop()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swiftCop.addSuspect(Suspect(view:self.emailTextField, sentence: "Invalid email", trial: Trial.Email))
//        swiftCop.addSuspect(Suspect(view:self.password, sentence: "Minimum 4 Characters", trial: Trial.Length(.Minimum, 4)))
    }
    
    @IBAction func validateEmail(sender: UITextField) {
        self.emailMessage.text = swiftCop.isGuilty(sender)?.verdict()
    }
    
//    @IBAction func validatePassword(sender: UITextField) {
//        self.passwordMessage.text = swiftCop.isGuilty(sender)?.verdict()
//    }
}
