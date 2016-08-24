import UIKit
import SwiftyJSON
import Alamofire

class TweetViewController: UIViewController, UITextViewDelegate {

    var myTweetVC: MyTweetViewController!
    
    @IBOutlet weak var tweetText: PlaceHolderTextView!
    
    @IBAction func backButton(sender: AnyObject) {
        // ツイート画面を閉じる
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tweetButton(sender: AnyObject) {
        let tweet_text = tweetText.text!
        let length = tweetText.text.characters.count
        let json: [String : AnyObject] = ["tweet_id": 0, "tweet_text": tweet_text]
        print(json)
        
        if (length > Constant.min && length <= Constant.max) {
            Alamofire.request(.POST, "\(Constant.url)/json/tweet/create", parameters: json, encoding: .JSON)
                .responseJSON { response in
                    print(response.response) // URL response
                    
                    guard let object = response.result.value else {
                        return
                    }
                    
                    let json = JSON(object)
                    print(json)
                    json.forEach {(_, json) in
                        if (json == "create_success") {
                            // メインページへの画面遷移
                            self.dismissViewControllerAnimated(false, completion: {
                                self.myTweetVC.getMyTweet()
                            })
                        } else {
                            let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
                            alertLabel.text = "ツイートに失敗しました。"
                            self.view.addSubview(alertLabel)
                        }
                    }
                }
        } else {
            // TODO: アラート共通化
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "適切な文字数で入力して下さい。", preferredStyle:  UIAlertControllerStyle.Alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
            })
            alert.addAction(defaultAction)
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    // TODO: キーボード共通化
    // 他のところをタップしたらキーボードを隠す
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //非表示にする。
        if(tweetText.isFirstResponder()){
            tweetText.resignFirstResponder()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetText.delegate = self
        
        // TODO: プレースホルダー共通化
        tweetText.placeHolder = "最近あった面白いことをつぶやこう！"
        tweetText.placeHolderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        tweetText.layer.borderWidth = 0.5
        tweetText.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
