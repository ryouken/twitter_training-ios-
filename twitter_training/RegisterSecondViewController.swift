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
        let user = User(vc: self)
        validateAction(user)
    }
    
    // バリデーションの結果で処理を分岐
    func validateAction(user: User) {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        if (allGuiltiesMessage.characters.count == 0 && profileText.text.characters.count <= Constant.max) {
            http.createUser(self, user: user)
        } else {
            alert.validationError(self, message: "指定した方式で入力して下さい")
        }
    }
    
    // バリデーションメソッド
    @IBAction func validateEmail(sender: UITextField) {
        self.nameError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    
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
        
        profileText.placeHolder = "ここはプロフィール欄です。好きな芸人について語るもよし、ボケるもよし、ご自由に。(140文字以内)"
        profileText.layer.borderWidth = 0.5
        profileText.layer.cornerRadius = 5
    }

}