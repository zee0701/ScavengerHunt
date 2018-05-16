
import Foundation
import UIKit

var totalHunts = NSDictionary()

extension UIViewController{
    
    func hideKeyBoardWhenTapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
}
