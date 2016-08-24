import UIKit
import SwiftyJSON
import Alamofire

class FollowedListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var pageMenu: CAPSPageMenu?
    var userListVC: UserListViewController!
    var timelineVC: TimelineViewController!
    var followListVC: FollowListViewController!
    var follows: [[String: String?]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        getFollowedList()
    }
    
    func getFollowedList() {
        Alamofire.request(.GET, "\(Constant.url)/json/followed/list")
            .responseJSON { response in
                print(response.response)
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach { (_, follow) in
                    let follow: [String: String?] = [
                        "user_id": follow["user_id"].description,
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
        cell.textLabel?.text = follow["profile_text"]!
        cell.textLabel?.font = UIFont(name: "Arial", size: 24)
        cell.detailTextLabel?.text = "@" + follow["user_name"]!!
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 16)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let follow = follows[indexPath.row]
        
        let alert = UIAlertController(title: follow["user_name"]!, message: "フォローしますか？", preferredStyle:  UIAlertControllerStyle.Alert)
        
        let defaultAction = UIAlertAction(title: "フォロー", style: UIAlertActionStyle.Default, handler: { action in
            let num: Int? = follow["user_id"]!.flatMap{ Int($0) }
            let json: [String : Int] = ["relation_id": 0, "followed_id": num!]
            
            // APIサーバーとのやり取り
            Alamofire.request(.POST, "\(Constant.url)/json/follow/create", parameters: json, encoding: .JSON)
                .responseJSON { response in
                    print(response.response) // URL response
                    
                    guard let object = response.result.value else {
                        return
                    }
                    
                    let json = JSON(object)
                    json.forEach {(_, json) in
                        if (json == "create_success") {
                            self.userListVC.getUsers()
                            self.timelineVC.getTimeline()
                            self.followListVC.getFollowList()
                        } else {
                            let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
                            alertLabel.text = "フォローに失敗しました。"
                            self.view.addSubview(alertLabel)
                        }
                    }
            }
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
}