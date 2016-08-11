import UIKit

class RegisterSecondViewController: UIViewController {

    
    @IBAction func nextButton(sender: AnyObject) {
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
