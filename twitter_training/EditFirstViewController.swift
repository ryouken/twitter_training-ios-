import UIKit
import SwiftCop
import SwiftyJSON
import Alamofire

class EditFirstViewController: UIViewController {
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let swiftCop = SwiftCop()
    var email: String!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBAction func backButton(sender: AnyObject) {
        // メインページへの画面遷移
        let storyboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("PageMenu") as! PageMenuViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    @IBAction func nextButton(sender: AnyObject) {
        self.delegate.emailText = emailText
        self.delegate.passwordText = passwordText
        
        validateAction()
    }
    
    func validateAction() {
        let allGuiltiesMessage = swiftCop.allGuilties().map{ return $0.sentence}.joinWithSeparator("\n")
        
        if (allGuiltiesMessage.characters.count == 0) {
            // 会員編集(2)への画面遷移
            let storyboard = self.storyboard!
            let nextVC = storyboard.instantiateViewControllerWithIdentifier("EditSecond") as! EditSecondViewController
            self.presentViewController(nextVC, animated: true, completion: nil)
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
    
    func getUser() {
        Alamofire.request(.GET, "http://localhost:9000/json/user/edit")
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        
        // バリデーションの出力
        swiftCop.addSuspect(Suspect(view:self.emailText, sentence: "emailの形式でご入力下さい。", trial: Trial.Email))
        swiftCop.addSuspect(Suspect(view:self.passwordText, sentence: "8文字以上でご入力下さい。", trial: Trial.Length(.Minimum, 8)))
        swiftCop.addSuspect(Suspect(view:self.passwordText, sentence: "20文字以下でご入力下さい。", trial: Trial.Length(.Maximum, 20)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
