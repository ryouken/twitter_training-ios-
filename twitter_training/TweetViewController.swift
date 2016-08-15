import UIKit
import SwiftyJSON
import Alamofire

class TweetViewController: UIViewController {

    
    @IBOutlet weak var tweetText: PlaceHolderTextView!
    @IBAction func tweetButton(sender: AnyObject) {
        let tweet_text = tweetText.text!
        
        let json = ["tweet_id": 0, "tweet_text": tweet_text]
        print(json)
        
        Alamofire.request(.POST, "http://localhost:9000/json/tweet/create", parameters: json as! [String : AnyObject], encoding: .JSON)
            .responseJSON { response in
                print(response.response) // URL response
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach {(_, json) in
                    if (json == "create_success") {
                        // 会員一覧ページへの画面遷移
                        let storyboard: UIStoryboard = self.storyboard!
                        let nextVC = storyboard.instantiateViewControllerWithIdentifier("UserList") as! UserListViewController
                        self.presentViewController(nextVC, animated: true, completion: nil)
                    } else {
                        let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
                        alertLabel.text = "ツイートに失敗しました。"
                        self.view.addSubview(alertLabel)
                    }
                }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.placeHolder = "思ったことをつぶやいてみよう！"
        tweetText.placeHolderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        tweetText.layer.borderWidth = 0.5
        tweetText.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
