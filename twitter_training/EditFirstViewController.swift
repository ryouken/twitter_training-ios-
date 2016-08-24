import UIKit
import SwiftCop
import SwiftyJSON
import Alamofire

class EditFirstViewController: UIViewController, UITextFieldDelegate {
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let swiftCop = SwiftCop()
    var email: String!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBAction func backButton(sender: AnyObject) {
        // メインページへの画面遷移
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        self.delegate.emailText = emailText
        self.delegate.passwordText = passwordText
        
        validateAction()
    }
    
    func validateAction() {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        
        if (allGuiltiesMessage.characters.count == 0) {
            // TODO: 画面遷移共通化
            // 会員編集(2)への画面遷移
            let storyboard = self.storyboard!
            let nextVC = storyboard.instantiateViewControllerWithIdentifier("EditSecond") as! EditSecondViewController
            nextVC.editFirstVC = self
            self.presentViewController(nextVC, animated: true, completion: nil)
        } else {
            // TODO: alert共通化
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "指定の方式で入力して下さい。", preferredStyle:  UIAlertControllerStyle.Alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
            })
            alert.addAction(defaultAction)
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }

    
    // バリデーションメソッド
    @IBAction func validateEmail(sender: UITextField) {
        self.emailError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    @IBAction func validatePassword(sender: UITextField) {
        self.passwordError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    
    // TODO: getMethod共通化
    func getUser() {
        Alamofire.request(.GET, "\(Constant.url)/json/user/edit")
            .responseJSON { response in
                
            guard let object = response.result.value else {
                return
            }
            
            JSON(object).forEach { (_, user) in
                self.email = user["email"].string!
                self.emailText.text = self.email
            }
        }
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
        getUser()
        
        // バリデーションの出力
        swiftCop.email(emailText)
        swiftCop.minimum_8(passwordText)
        swiftCop.max_20(passwordText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
