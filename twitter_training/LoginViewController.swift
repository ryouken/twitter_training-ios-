import UIKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController  {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func nextButton(sender: AnyObject) {
        let email: String = emailText.text!
        let password: String = passwordText.text!
        let json = ["email": email, "password": password]
        
        Alamofire.request(.POST, "http://localhost:9000/json/user/authenticate", parameters: json, encoding: .JSON)
            .responseJSON { response in
                print(response.response) // URL response
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach {(_, json) in
                    if (json == "login_success") {
                        // メインページへの画面遷移
                        let storyboard = self.storyboard!
                        let nextVC = storyboard.instantiateViewControllerWithIdentifier("PageMenu") as! PageMenuViewController
                        self.presentViewController(nextVC, animated: true, completion: nil)
                    } else {
                        let alert: UIAlertController = UIAlertController(title: "エラー", message: "入力情報が間違っています。", preferredStyle:  UIAlertControllerStyle.Alert)
                        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
                        })
                        alert.addAction(defaultAction)
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}
    