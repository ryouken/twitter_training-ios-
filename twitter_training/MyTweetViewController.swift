import UIKit
import SwiftyJSON
import Alamofire

class MyTweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var pageMenu : CAPSPageMenu?
    var tweets: [[String: String?]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        getMyTweet()
    }
    
    // getメソッド共通化
    func getMyTweet() {
        Alamofire.request(.GET, "\(Constant.url)/json/tweet/mylist")
            .responseJSON { response in
                print(response.response)
                
                guard let object = response.result.value else {
                    return
                }
                
                self.tweets.removeAll()
                let json = JSON(object)
                print(json)
                json.forEach { (_, json) in
                    json.forEach { (_, tweet) in
                        let tweet: [String: String?] = [
                            "tweet_id": tweet["tweet_id"].description,
                            "tweet_text": tweet["tweet_text"].string
                        ]
                        self.tweets.append(tweet)
                    }
                }
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        let tweet = tweets[indexPath.row]
        cell.textLabel?.text = tweet["tweet_text"]!
        cell.textLabel?.font = UIFont(name: "Arial", size: 24)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let tweet = tweets[indexPath.row]
        
        let alert = UIAlertController(title: "このボケに対して", message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        
        let defaultActionShow = UIAlertAction(title: "ツッコミを見る", style: UIAlertActionStyle.Default, handler: { action in
            let storyboard = self.storyboard!
            let nextVC = storyboard.instantiateViewControllerWithIdentifier("ReplyList") as! ReplyListViewController
            nextVC.tweetId = tweet["tweet_id"]!.flatMap{ Int($0) }
            nextVC.tweetText = tweet["tweet_text"]!
            self.presentViewController(nextVC, animated: true, completion: nil)
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultActionShow)
        
        presentViewController(alert, animated: true, completion: nil)
    }

    
}
