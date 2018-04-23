
import Foundation
import UIKit

var totalHunts = NSDictionary()

extension UIViewController{
    
    func hideKeyBoardWhenTapped(){
        let tap = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
}
