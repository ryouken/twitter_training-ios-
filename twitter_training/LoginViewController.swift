import UIKit

class LoginViewController: UIViewController {
    var emailtext = email.text
    
    @IBAction func nextButton(sender: AnyObject) {
        // 会員一覧ページへの画面遷移
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("UserList") as! UserListViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}
    