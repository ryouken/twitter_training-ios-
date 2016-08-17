import UIKit

class EditFirstViewController: UIViewController {
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func backButton(sender: AnyObject) {
        // メインページへの画面遷移
        let storyboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("PageMenu") as! PageMenuViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    @IBAction func nextButton(sender: AnyObject) {
        self.delegate.emailText = emailText
        self.delegate.passwordText = passwordText
        
        // 会員編集(2)への画面遷移
        let storyboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("EditSecond") as! EditSecondViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
