
 
import Foundation
import UIKit


class MessageBox{
    
    public static func Show(message: String, title: String, view: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let dismisAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(dismisAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    public static func SetupIndicator(view: UIViewController)->UIActivityIndicatorView{
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.hidesWhenStopped = true
        indicator.center = view.view.center
        view.view.addSubview(indicator)
        return indicator
    }
    
    public static func SetupIndicatorWhite(view: UIView)->UIActivityIndicatorView{
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.hidesWhenStopped = true
        indicator.center = view.center
        view.addSubview(indicator)
        return indicator
    }
    
    public static func SetupIndicator(view: UIView)->UIActivityIndicatorView{
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.hidesWhenStopped = true
        indicator.center = view.center
        view.addSubview(indicator)
        return indicator
    }
    
//    public static func ShowSnackbar(message: String){
//        let bar = TTGSnackbar(message: message, duration: .middle)
//        bar.show()
//    }
}
