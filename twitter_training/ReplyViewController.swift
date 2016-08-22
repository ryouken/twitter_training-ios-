import UIKit
import SwiftyJSON
import Alamofire

class ReplyViewController: UIViewController, UITextViewDelegate {
    var tweetId: Int!

    @IBOutlet weak var replyText: PlaceHolderTextView!
    
    @IBAction func backButton(sender: AnyObject) {
        // リプライ画面を閉じる
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func replyButton(sender: AnyObject) {
        let reply_text = replyText.text!
        let length = replyText.text.characters.count
        let json: [String : AnyObject] = ["reply_id": 0, "tweet_id": tweetId, "reply_text": reply_text]
        print(json)
        
        if (length > Constant.min && length <= Constant.max) {
            Alamofire.request(.POST, "\(Constant.url)/json/reply/create", parameters: json, encoding: .JSON)
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
                            })
                        } else {
                            let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
                            alertLabel.text = "リプライに失敗しました。"
                            self.view.addSubview(alertLabel)
                        }
                    }
            }
        } else {
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "適切な文字数で入力して下さい。", preferredStyle:  UIAlertControllerStyle.Alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
            })
            alert.addAction(defaultAction)
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
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
        replyText.placeHolderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        replyText.layer.borderWidth = 0.5
        replyText.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
