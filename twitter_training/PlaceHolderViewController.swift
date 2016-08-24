import UIKit

public class PlaceHolderTextView: UITextView {
    
    lazy var placeHolderLabel:UILabel = UILabel()
    var placeHolderColor:UIColor      = UIColor.lightGrayColor()
    var placeHolder:NSString          = ""
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlaceHolderTextView.textChanged(_:)), name: UITextViewTextDidChangeNotification, object: nil)
    }
    
    override public func drawRect(rect: CGRect) {
        if(self.placeHolder.length > 0) {
            self.placeHolderLabel.frame           = CGRectMake(8,8,self.bounds.size.width - 16,0)
            self.placeHolderLabel.lineBreakMode   = NSLineBreakMode.ByWordWrapping
            self.placeHolderLabel.numberOfLines   = 0
            self.placeHolderLabel.font            = self.font
            self.placeHolderLabel.backgroundColor = UIColor.clearColor()
            self.placeHolderLabel.textColor       = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
            self.placeHolderLabel.alpha           = 0
            self.placeHolderLabel.tag             = 1
            self.placeHolderLabel.text = self.placeHolder as String
            self.placeHolderLabel.sizeToFit()
            self.addSubview(placeHolderLabel)
        }
        
        self.sendSubviewToBack(placeHolderLabel)
        
        if(self.text.utf16.count == 0 && self.placeHolder.length > 0){
            self.viewWithTag(1)?.alpha = 1
        }
        
        super.drawRect(rect)
    }
    
    public func textChanged(notification:NSNotification?) -> (Void) {
        if(self.placeHolder.length == 0){
            return
        }
        
        if(self.text.utf16.count == 0) {
            self.viewWithTag(1)?.alpha = 1
        }else{
            self.viewWithTag(1)?.alpha = 0
        }
    }
    
}