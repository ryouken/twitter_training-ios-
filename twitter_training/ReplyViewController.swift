import UIKit
import SwiftyJSON
import Alamofire

class ReplyViewController: UIViewController, UITextViewDelegate {
    
    let alert = Alert()
    let http = HTTPRequest()
    var tweetId: Int!

    @IBOutlet weak var replyText: PlaceHolderTextView!
    
    // リプライ画面を閉じる
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func replyButton(sender: AnyObject) {
        let reply_text = replyText.text!
        let length = replyText.text.characters.count
        let json: [String : AnyObject] = ["reply_id": 0, "tweet_id": tweetId, "reply_text": reply_text]
        // 文字カウントで処理を分岐
        if (length > Constant.min && length <= Constant.max) {
            http.createReply(self, json: json)
        } else {
           alert.textCountError(self)
        }
    }
    
    // TODO: キーボード共通化
    // 他のところをタップしたらキーボードを隠す
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //非表示にする。
        if(replyText.isFirstResponder()){
            replyText.resignFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replyText.delegate = self
        replyText.placeHolder = "なんでやねん！"
        replyText.layer.borderWidth = 0.5
        replyText.layer.cornerRadius = 5
    }

}
