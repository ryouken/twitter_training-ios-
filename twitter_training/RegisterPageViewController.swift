import UIKit

class RegisterPageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .Forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    func getFirst() -> RegisterFirstViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("RegisterFirst") as! RegisterFirstViewController
    }
    
    func getSecond() -> RegisterSecondViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("RegisterSecond") as! RegisterSecondViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RegisterPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        if viewController.isKindOfClass(RegisterSecondViewController) {
            // 2 -> 1
            return getFirst()
        } else {
            // 1 -> end of the road
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(RegisterFirstViewController) {
            // 1 -> 2
            return getSecond()
        } else {
            // 2 -> end of the road
            return nil
        }
    }
    
    //全ページ数を返すメソッド
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    //ページコントロールの最初の位置を返すメソッド
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}