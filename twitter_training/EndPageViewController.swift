import UIKit
import Alamofire
import SwiftyJSON

class EndPageViewController: UIViewController {

    @IBAction func editButton(sender: AnyObject) {
        // 会員情報編集ページの画面遷移
        let storyboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("EditFirst") as! EditFirstViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        Alamofire.request(.GET, "http://localhost:9000/json/user/logout")
            .responseJSON { response in
                print(response.response) // URL response
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach {(_, json) in
                    if (json == "logout_success") {
                        // 会員一覧ページへの画面遷移
                        let storyboard: UIStoryboard = self.storyboard!
                        let nextVC = storyboard.instantiateViewControllerWithIdentifier("InitialPage") as! InitialPageViewController
                        self.presentViewController(nextVC, animated: true, completion: nil)
                    } else {
                        let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
                        alertLabel.text = "ログアウトに失敗しました。"
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
