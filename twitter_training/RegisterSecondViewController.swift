import UIKit
import SwiftyJSON
import Alamofire
import SwiftCop

class RegisterSecondViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
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
    
    func validateAction(json: [String: AnyObject]) {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        
        if (allGuiltiesMessage.characters.count == 0 && profileText.text.characters.count <= Constant.max) {
            Alamofire.request(.POST, "\(Constant.url)/json/user/create", parameters: json, encoding: .JSON)
                .responseJSON { response in
                    print(response.response) // URL response
                    
                    guard let object = response.result.value else {
                        let alert: UIAlertController = UIAlertController(title: "エラー", message: "入力に問題があります。", preferredStyle:  UIAlertControllerStyle.Alert)
                        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
                        })
                        alert.addAction(defaultAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                        return
                    }
                    
                    let json = JSON(object)
                    print(json)
                    
                    json.forEach {(_, json) in
                        if (response.result.isSuccess == true) {
                            // ログインページへ画面遷移
                            let storyboard = self.storyboard!
                            let nextVC = storyboard.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
                            self.navigationController?.pushViewController(nextVC, animated: true)
                        } else {
                            let alert: UIAlertController = UIAlertController(title: "エラー", message: "入力に問題があります。", preferredStyle:  UIAlertControllerStyle.Alert)
                            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
                            })
                            alert.addAction(defaultAction)
                            self.presentViewController(alert, animated: true, completion: nil)
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
        swiftCop.addSuspect(Suspect(view:self.nameText, sentence: "2文字以上でご入力下さい。", trial: Trial.Length(.Minimum, 2)))
        swiftCop.addSuspect(Suspect(view:self.nameText, sentence: "20文字以内でご入力下さい。", trial: Trial.Length(.Maximum, 20)))
        
        // プロフィールのTextAreaをTextFieldと同じ設定に。
        profileText.placeHolder = "ここはプロフィール欄です。好きな芸人について語るもよし、ボケるもよし、ご自由に。(140文字以内)"
        profileText.placeHolderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        profileText.layer.borderWidth = 0.5
        profileText.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
}