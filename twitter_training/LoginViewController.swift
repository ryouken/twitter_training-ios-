import UIKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let scene = Scene()
    let alert = Alert()
    let http = HTTPRequest()
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    // ログイン
    @IBAction func nextButton(sender: AnyObject) {
        let email = emailText.text!
        let password = passwordText.text!
        let json = ["email": email, "password": password]
        http.login(self, json: json)
    }
    
    // TODO: キーボード共通化
    // 他のところをタップしたらキーボードを隠す
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //非表示にする。
        if(emailText.isFirstResponder()){
            emailText.resignFirstResponder()
        }
        if(passwordText.isFirstResponder()){
            passwordText.resignFirstResponder()
        }
    }
    // returnでキーボードを隠す
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.delegate = self
        passwordText.delegate = self
    }
  
}
    