import UIKit
import Alamofire
import SwiftyJSON

class UserListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var pageMenu: CAPSPageMenu?
    var users: [[String: String?]] = [] // usersのcase class的なものをつくる
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        getUsers()
        print("userList:" + users.description)
    }
    
    func getUsers() {
        Alamofire.request(.GET, "http://localhost:9000/json/user/list")
            .responseJSON { response in
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                print(json)
                json.forEach { (_, json) in
                    json.forEach { (_, user) in
                    let user: [String: String?] = [
                        "user_id": user["user_id"].description,
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
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell") // いつか落ちる。再利用。
        let user = users[indexPath.row]
        cell.textLabel?.text = user["profile_text"]!
        cell.textLabel?.font = UIFont(name: "Arial", size: 20)
        cell.detailTextLabel?.text = user["user_name"]!
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 16)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let user = users[indexPath.row]
        
        let alert = UIAlertController(title: user["user_name"]!, message: "フォローしますか？", preferredStyle:  UIAlertControllerStyle.Alert)
        
        let defaultAction = UIAlertAction(title: "フォロー", style: UIAlertActionStyle.Default, handler: { action in
            let num : Int? = user["user_id"]!.flatMap{ Int($0) }
            let json: [String : Int] = ["relation_id": 0, "followed_id": num!]
            
            // APIサーバーとのやり取り
            Alamofire.request(.POST, "http://localhost:9000/json/follow/create", parameters: json, encoding: .JSON)
                .responseJSON { response in
                    print(response.response) // URL response
                    
                    guard let object = response.result.value else {
                        return
                    }
                    
                    let json = JSON(object)
                    json.forEach {(_, json) in
                        if (json == "create_success") {
                            // メインページへの画面遷移
                            let storyboard = self.storyboard!
                            let nextVC = storyboard.instantiateViewControllerWithIdentifier("PageMenu") as! PageMenuViewController
                            self.presentViewController(nextVC, animated: true, completion: nil)
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