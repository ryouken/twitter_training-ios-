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
                        // TODO: Alert共通化
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
                            // TODO: 画面遷移共通化
                            // ログインページへ画面遷移
                            let storyboard = self.storyboard!
                            let nextVC = storyboard.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
                            self.navigationController?.pushViewController(nextVC, animated: true)
                        } else {
                            // TODO: アラート共通化
                            let alert: UIAlertController = UIAlertController(title: "エラー", message: "入力に問題があります。", preferredStyle:  UIAlertControllerStyle.Alert)
                            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
                            })
                            alert.addAction(defaultAction)
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                    }
            }
        } else {
            
            // アラート共通化
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
}