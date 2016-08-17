import UIKit
import SwiftyJSON
import Alamofire

class TimelineViewController: UIViewController, UITableViewDataSource {
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
        Alamofire.request(.GET, "http://localhost:9000/json/tweet/timeline")
            .responseJSON { response in
                print(response.response)
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                    json.forEach { (_, tweet) in
                        let tweet: [String: String?] = [
                            "tweet_id": tweet["tweet_id"].string,
                            "user_name": tweet["user_name"].string,
                            "tweet_text": tweet["tweet_text"].string
                        ]
                        self.tweets.append(tweet)
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
        cell.textLabel?.font = UIFont(name: "Arial", size: 20)
        cell.detailTextLabel?.text = tweet["user_name"]!
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 16)
        cell.textLabel?.numberOfLines=0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        return cell
    }

}

