import UIKit
import SwiftCop
import SwiftyJSON
import Alamofire

class EditFirstViewController: UIViewController, UITextFieldDelegate {
    
    var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let scene = Scene()
    let alert = Alert()
    let http = HTTPRequest()
    let swiftCop = SwiftCop()
    var email: String!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    // メインページに戻る
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        self.delegate.emailText = emailText
        self.delegate.passwordText = passwordText
        validateAction()
    }
    
    // バリデーションの結果で処理を分岐
    func validateAction() {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        if (allGuiltiesMessage.characters.count == 0) {
            // 会員編集(2)への画面遷移
            scene.editTransition(self)
        } else {
            alert.validationError(self)
        }
    }
    
    // バリデーションメソッド
    @IBAction func validateEmail(sender: UITextField) {
        self.emailError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    @IBAction func validatePassword(sender: UITextField) {
        self.passwordError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    
    // TODO: キーボード処理共通化
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
        http.getUser(self)
        
        // バリデーションの出力
        swiftCop.email(emailText)
        swiftCop.minimum_8(passwordText)
        swiftCop.max_20(passwordText)
    }

}
