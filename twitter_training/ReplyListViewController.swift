import UIKit
import SwiftyJSON
import Alamofire

class ReplyListViewController: UIViewController, UITableViewDataSource {
    var tweetId: Int!
    var tweetText: String!
    var replies: [[String: String?]] = []

    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = tweetText
        let json: [String: Int] = ["tweet_id": tweetId]
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        getReplies(json)
    }
    
    func getReplies(json: [String: Int]) {
        print(json)
        Alamofire.request(.POST, "\(Constant.url)/json/reply/list", parameters: json, encoding: .JSON)
            .responseJSON { response in
                print(response.response)
                
                guard let object = response.result.value else {
                    return
                }
                
                self.replies.removeAll()
                let json = JSON(object)
                print(json)
//                json.forEach { (_, json) in
                    json.forEach { (_, reply) in
                        let reply: [String: String?] = [
                            "reply_id": reply["reply_id"].string,
                            "reply_user_name": reply["reply_user_name"].string,
                            "reply_text": reply["reply_text"].string
                        ]
                        self.replies.append(reply)
                    }
//                }
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        let reply = replies[indexPath.row]
        cell.textLabel?.text = reply["reply_text"]!
        cell.textLabel?.font = UIFont(name: "Arial", size: 24)
        cell.detailTextLabel?.text = "@" + reply["reply_user_name"]!!
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 16)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
