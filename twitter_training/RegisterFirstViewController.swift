import UIKit
import SwiftCop

class RegisterFirstViewController: UIViewController, UITextFieldDelegate {
    
    var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let scene = Scene()
    let alert = Alert()
    let swiftCop = SwiftCop()
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBAction func nextButton(sender: AnyObject) {
        self.delegate.emailText = emailText
        self.delegate.passwordText = passwordText
        validateAction()
    }
    
    // バリデーションの結果で処理を分岐
    func validateAction() {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        if (allGuiltiesMessage.characters.count == 0) {
            // 新規会員登録(2)への画面遷移
            scene.navTransition(self, storyboardId: "RegisterSecond")
        } else {
            alert.validationError(self, message: "指定した方式で入力して下さい")
        }
    }

    // バリデーションメソッド
    @IBAction func validateEmail(sender: UITextField) {
        self.emailError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    @IBAction func validatePassword(sender: UITextField) {
        self.passwordError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    
    // 他のところをタップしたらキーボードを隠す
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
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
        
        // バリデーションの出力
        swiftCop.email(emailText)
        swiftCop.minimum_8(passwordText)
        swiftCop.max_20(passwordText)
    }

}