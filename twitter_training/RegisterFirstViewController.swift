import UIKit

class RegisterFirstViewController: UIViewController {
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func nextButton(sender: AnyObject) {
        self.delegate.emailText = emailText
        self.delegate.passwordText = passwordText

        // 新規会員登録(2)への画面遷移
        let storyboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("RegisterSecond") as! RegisterSecondViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
