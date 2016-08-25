import UIKit
import SwiftyJSON
import Alamofire
import SwiftCop

class RegisterSecondViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let scene = Scene()
    let alert = Alert()
    let http = HTTPRequest()
    let swiftCop = SwiftCop()

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var profileText: PlaceHolderTextView!
    @IBOutlet weak var nameError: UILabel!
    
    @IBAction func nextButton(sender: AnyObject) {
        let email = delegate.emailText.text!
        let password = delegate.passwordText.text!
        let user_name = nameText.text!
        let profile_text = profileText.text!
        let json: [String: AnyObject] = [
            "user_id"      : 0,
            "email"        : email,
            "password"     : password,
            "user_name"    : user_name,
            "profile_text" : profile_text]
        validateAction(json)
    }
    
    // バリデーションの結果で処理を分岐
    func validateAction(json: [String: AnyObject]) {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        if (allGuiltiesMessage.characters.count == 0 && profileText.text.characters.count <= Constant.max) {
            http.createUser(self, json: json)
        } else {
            alert.validationError(self)
        }
    }
    
    // バリデーションメソッド
    @IBAction func validateEmail(sender: UITextField) {
        self.nameError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    
    // TODO: キーボード共通化
    // 他のところをタップしたらキーボードを隠す
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //非表示にする。
        if(nameText.isFirstResponder()){
            nameText.resignFirstResponder()
        }
        if(profileText.isFirstResponder()){
            profileText.resignFirstResponder()
        }
    }
    // returnでキーボードを隠す
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.delegate = self
        profileText.delegate = self
        
        // バリデーションの出力
        swiftCop.minimum_2(nameText)
        swiftCop.max_20(nameText)
        
        // プロフィールのTextAreaをTextFieldと同じ設定に。
        profileText.placeHolder = "ここはプロフィール欄です。好きな芸人について語るもよし、ボケるもよし、ご自由に。(140文字以内)"
        profileText.layer.borderWidth = 0.5
        profileText.layer.cornerRadius = 5
    }

}