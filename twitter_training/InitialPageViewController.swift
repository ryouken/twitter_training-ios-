import UIKit

class InitialPageViewController: UIViewController {

    
    @IBAction func registerButton(sender: AnyObject) {
        // 会員登録ページ(1)への画面遷移
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("RegisterFirst") as! RegisterFirstViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func LoginButton(sender: AnyObject) {
        // ログインページへの画面遷移
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
