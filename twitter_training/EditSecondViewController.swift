import UIKit
import SwiftyJSON
import Alamofire

class EditSecondViewController: UIViewController {
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var profileText: PlaceHolderTextView!
    
    @IBAction func editButton(sender: AnyObject) {
        let email = delegate.emailText.text!
        let password = delegate.passwordText.text!
        let user_name = nameText.text!
        let profile_text = profileText.text!
        let json: [String: AnyObject] = [
            "user_id"      : 0,
            "email"        : email,
            "password"     : password,
            "user_name"    : user_name,
            "profile_text" : profile_text]
        print(json)
        
        Alamofire.request(.PUT, "http://localhost:9000/json/user/update", parameters: json, encoding: .JSON)
            .responseJSON { response in
                print(response.response) // URL response
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                print(json)
                
                json.forEach {(_, json) in
                    if (json == "update_success") {
                        // メインページへ画面遷移
                        let storyboard = self.storyboard!
                        let nextVC = storyboard.instantiateViewControllerWithIdentifier("PageMenu") as! PageMenuViewController
                        self.presentViewController(nextVC, animated: true, completion: nil)
                    } else {
                        let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
                        alertLabel.text = "会員情報編集に失敗しました。"
                        self.view.addSubview(alertLabel)
                    }
                }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileText.placeHolder = "プロフィールを入力して下さい(140文字以内)。"
        profileText.placeHolderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        profileText.layer.borderWidth = 0.5
        profileText.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
