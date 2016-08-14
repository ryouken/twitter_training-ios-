import UIKit
import SwiftyJSON
import Alamofire

class RegisterSecondViewController: UIViewController{
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var profileText: UITextField!
    
    @IBAction func nextButton(sender: AnyObject) {
        let email = delegate.emailText.text!
        let password = delegate.passwordText.text!
        let user_name = nameText.text!
        let profile_text = profileText.text!
        let json = [
            "email": email,
            "password": password,
            "user_name": user_name,
            "profile_text": profile_text]
        print(json)
        
        Alamofire.request(.POST, "http://localhost:9000/json/user/create", parameters: json, encoding: .JSON)
            .responseJSON { response in
                print(response.response) // URL response
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                print(json)
                
                json.forEach {(_, json) in
                    if (json == "create_success") {
                        // ログインページへ画面遷移
                        let storyboard: UIStoryboard = self.storyboard!
                        let nextVC = storyboard.instantiateViewControllerWithIdentifier("Login") as! LoginViewController
                        self.presentViewController(nextVC, animated: true, completion: nil)
                    } else {
                        let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
                        alertLabel.text = "新規会員登録に失敗しました。"
                        self.view.addSubview(alertLabel)
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