import UIKit
import SwiftyJSON
import Alamofire

class MyTweetViewController: UIViewController, UITableViewDataSource {
    var pageMenu : CAPSPageMenu?
    var tweets: [[String: String?]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        getTimeline()
    }
    
    func getTimeline() {
        Alamofire.request(.GET, "http://localhost:9000/json/tweet/mylist")
            .responseJSON { response in
                print(response.response)
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach { (_, json) in
                    json.forEach { (_, tweet) in
                        let tweet: [String: String?] = [
                            "tweet_id": tweet["tweet_id"].string,
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
        cell.detailTextLabel?.text = tweet["tweet_text"]!
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 20)
        cell.detailTextLabel?.numberOfLines=0
        //        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //        cell.detailTextLabel?.sizeToFit()
        
        
        return cell
    }
    
}
