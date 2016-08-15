import UIKit
import SwiftyJSON
import Alamofire

class FollowedListViewController: UIViewController, UITableViewDataSource {
    var pageMenu : CAPSPageMenu?
    var follows: [[String: String?]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        getTimeline()
    }
    
    func getTimeline() {
        Alamofire.request(.GET, "http://localhost:9000/json/followed/list")
            .responseJSON { response in
                print(response.response)
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach { (_, follow) in
                    let follow: [String: String?] = [
                        "user_name": follow["user_name"].string,
                        "profile_text": follow["profile_text"].string
                    ]
                    self.follows.append(follow)
                }
                self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follows.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        let follow = follows[indexPath.row]
        cell.textLabel?.text = follow["user_name"]!
        cell.textLabel?.font = UIFont(name: "Arial", size: 20)
        cell.detailTextLabel?.text = follow["profile_text"]!
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 20)
        cell.detailTextLabel?.numberOfLines=0
        //        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //        cell.detailTextLabel?.sizeToFit()
        
        
        return cell
    }
    
}