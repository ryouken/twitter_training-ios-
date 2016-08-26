import UIKit
import SwiftyJSON
import Alamofire

class TweetViewController: UIViewController, UITextViewDelegate {
    
    let alert = Alert()
    let http = HTTPRequest()
    var myTweetVC: MyTweetViewController!
    
    @IBOutlet weak var tweetText: PlaceHolderTextView!
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tweetButton(sender: AnyObject) {
        // 文字カウントで処理を分岐
        let length = tweetText.text.characters.count
        if (length > Constant.min && length <= Constant.max) {
            http.createTweet(self, tweet_text: tweetText.text!)
        } else {
            alert.textCountError(self)
        }
    }
    
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
        tweetText.placeHolder = "最近あった面白いことをつぶやこう！"
        tweetText.layer.borderWidth = 0.5
        tweetText.layer.cornerRadius = 5
    }

}
