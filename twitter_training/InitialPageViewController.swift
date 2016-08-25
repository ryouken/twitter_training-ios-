import UIKit

class InitialPageViewController: UIViewController {
    
    let scene = Scene()

    // 会員登録ページ(1)への画面遷移
    @IBAction func registerButton(sender: AnyObject) {
        scene.navTransition(self, storyboardId: "RegisterFirst")
    }
    
    // ログインページへの画面遷移
    @IBAction func LoginButton(sender: AnyObject) {
        scene.navTransition(self, storyboardId: "Login")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
