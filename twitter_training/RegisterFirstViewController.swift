import UIKit
import SwiftCop

class RegisterFirstViewController: UIViewController {
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
            // 新規会員登録(2)への画面遷移
            let storyboard = self.storyboard!
            let nextVC = storyboard.instantiateViewControllerWithIdentifier("RegisterSecond") as! RegisterSecondViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
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
        self.emailError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    @IBAction func validatePassword(sender: UITextField) {
        self.passwordError.text = swiftCop.isGuilty(sender)?.verdict()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // バリデーションの出力
        swiftCop.addSuspect(Suspect(view:self.emailText, sentence: "emailの形式でご入力下さい。", trial: Trial.Email))
        swiftCop.addSuspect(Suspect(view:self.passwordText, sentence: "8文字以上でご入力下さい。", trial: Trial.Length(.Minimum, 8)))
        swiftCop.addSuspect(Suspect(view:self.passwordText, sentence: "20文字以下でご入力下さい。", trial: Trial.Length(.Maximum, 20)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}