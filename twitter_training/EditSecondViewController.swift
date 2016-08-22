import UIKit
import SwiftyJSON
import Alamofire
import SwiftCop

class EditSecondViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let swiftCop = SwiftCop()
    var editFirstVC: EditFirstViewController!
    var default_user_name: String!
    var default_profile_text: String!

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var profileText: PlaceHolderTextView!
    @IBOutlet weak var nameError: UILabel!
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func editButton(sender: AnyObject) {
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
    
    func validateAction(json: [String: AnyObject]) {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        
        if (allGuiltiesMessage.characters.count == 0 && profileText.text.characters.count <= Constant.max) {
            Alamofire.request(.PUT, "\(Constant.url)/json/user/update", parameters: json, encoding: .JSON)
                .responseJSON { response in
                    print(response.response) // URL response
                    
                    guard let object = response.result.value else {
                        return
                    }
                    
                    let json = JSON(object)
                    print(json)
                    
                    json.forEach {(_, json) in
                        if (json == "update_success") {
                            // メインページへ画面遷移
                            self.dismissViewControllerAnimated(false, completion: nil)
                            self.editFirstVC.dismissViewControllerAnimated(false, completion: nil)
                        } else {
                            let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
                            alertLabel.text = "会員情報編集に失敗しました。"
                            self.view.addSubview(alertLabel)
                        }
                    }
            }
        } else {
            
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "指定の方式で入力して下さい。", preferredStyle:  UIAlertControllerStyle.Alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
            })
            
            alert.addAction(defaultAction)
            
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }

    
    // バリデーションメソッド
    @IBAction func validateEmail(sender: UITextField) {
        self.nameError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    
    func getUser() {
        Alamofire.request(.GET, "\(Constant.url)/json/user/edit")
            .responseJSON { response in
                
                guard let object = response.result.value else {
                    return
                }
                
                JSON(object).forEach { (_, user) in
                    self.default_user_name = user["user_name"].string!
                    self.default_profile_text = user["profile_text"].string!
                    self.nameText.text = self.default_user_name
                    self.profileText.text = self.default_profile_text
                }
        }
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
        
        getUser()
        
        // バリデーションの出力
        swiftCop.addSuspect(Suspect(view:self.nameText, sentence: "2文字以上でご入力下さい。", trial: Trial.Length(.Minimum, 2)))
        swiftCop.addSuspect(Suspect(view:self.nameText, sentence: "20文字以内でご入力下さい。", trial: Trial.Length(.Maximum, 20)))
        
        // プロフィールのTextAreaをTextFieldと同じ設定に。
        profileText.placeHolder = "プロフィールを入力して下さい(140文字以内)。"
        profileText.placeHolderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        profileText.layer.borderWidth = 0.5
        profileText.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
