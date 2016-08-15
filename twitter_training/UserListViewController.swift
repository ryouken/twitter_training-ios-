import UIKit
import Alamofire
import SwiftyJSON

class UserListViewController: UIViewController, UITableViewDataSource {
    var pageMenu : CAPSPageMenu?
    var users: [[String: String?]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func editButton(sender: AnyObject) {
        // 会員編集ページの画面遷移
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("MyTweet") as! MyTweetViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        getUsers()
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
//        
//        let text = (0...indexPath.row).map { _ in "AAA" }.joinWithSeparator("\n")
//        (cell.viewWithTag(10) as? UILabel)?.text = text
//        
//        return cell
//    }
    
    func getUsers() {
        Alamofire.request(.GET, "http://localhost:9000/json/user/list")
            .responseJSON { response in
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach { (_, json) in
                    json.forEach { (_, user) in
                    let user: [String: String?] = [
                        "user_name": user["user_name"].string,
                        "profile_text": user["profile_text"].string
                    ]
                    self.users.append(user)
                    }
                }
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        let user = users[indexPath.row]
        cell.textLabel?.text = user["user_name"]!
        cell.textLabel?.font = UIFont(name: "Arial", size: 20)
        cell.detailTextLabel?.text = user["profile_text"]!
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 20)
        cell.detailTextLabel?.numberOfLines=0
//        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        cell.detailTextLabel?.sizeToFit()
        

        return cell
    }
}