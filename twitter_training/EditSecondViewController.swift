import UIKit
import SwiftyJSON
import Alamofire
import SwiftCop

class EditSecondViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let alert = Alert()
    let http = HTTPRequest()
    let swiftCop = SwiftCop()
    var editFirstVC: EditFirstViewController!
    var default_user_name: String!
    var default_profile_text: String!

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var profileText: PlaceHolderTextView!
    @IBOutlet weak var nameError: UILabel!
    
    // 会員情報編集ページ(1)に戻る
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func editButton(sender: AnyObject) {
        let user = User(vc: self)
        validateAction(user)
    }
    
    // バリデーションの結果で処理を分岐
    func validateAction(user: User) {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        if (allGuiltiesMessage.characters.count == 0 && profileText.text.characters.count <= Constant.max) {
            http.updateUser(self, user: user)
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
        http.getUser(self)
        
        // バリデーションの出力
        swiftCop.minimum_2(nameText)
        swiftCop.max_20(nameText)
        
        profileText.layer.borderWidth = 0.5
        profileText.layer.cornerRadius = 5
    }

}
