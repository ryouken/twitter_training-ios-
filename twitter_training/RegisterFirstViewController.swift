import UIKit
import SwiftCop

class RegisterFirstViewController: UIViewController, UITextFieldDelegate {
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
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
    
    // バリデーションのエラーを出す
    func validateAction() {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        
        if (allGuiltiesMessage.characters.count == 0) {
            // TODO: 画面遷移共通化
            // 新規会員登録(2)への画面遷移
            let storyboard = self.storyboard!
            let nextVC = storyboard.instantiateViewControllerWithIdentifier("RegisterSecond") as! RegisterSecondViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            // TODO: alert共通化
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "指定の方式で入力して下さい。", preferredStyle:  UIAlertControllerStyle.Alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
            })
            alert.addAction(defaultAction)
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }

    // TODO: バリデーション共通化
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
        
        // バリデーションの出力
        swiftCop.email(emailText)
        swiftCop.minimum_8(passwordText)
        swiftCop.max_20(passwordText)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}