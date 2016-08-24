import UIKit

class InitialPageViewController: UIViewController {

    // TODO: 画面遷移共通化
    @IBAction func registerButton(sender: AnyObject) {
        // 会員登録ページ(1)への画面遷移
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("RegisterFirst") as! RegisterFirstViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func LoginButton(sender: AnyObject) {
        // ログインページへの画面遷移
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
