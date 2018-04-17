
import UIKit
import Firebase

class LoginVC: UIViewController {

    var editingStarted = false
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fieldView: UIView!
    
    var indicator: UIActivityIndicatorView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setUpTextFields()
        self.hideKeyBoardWhenTapped()
        indicator = MessageBox.SetupIndicator(view: self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   
    @IBAction func beginEditingEmail(_ sender: UITextField) {
        if(editingStarted == false){
            textFieldDidBeginEditing(textField: sender)
            editingStarted = true
        }
    }
    

    @IBAction func endedEditingEmail(_ sender: UITextField) {
        if(editingStarted == true){
            textFieldDidEndEditing(textField: sender)
            editingStarted = false
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(up: true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(up: false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpTextFields(){
        emailField.leftViewMode = UITextFieldViewMode.always
        let emailImgContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: emailField.frame.height))
        let emailImView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25.0, height: 25))
        emailImView.image = UIImage(named: "messages")
        emailImView.contentMode = .scaleAspectFit
        emailImView.center = emailImgContainer.center
        emailImgContainer.addSubview(emailImView)
        emailField.leftView = emailImgContainer
        emailField.delegate = self
        
        password.leftViewMode = UITextFieldViewMode.always
        //let passImgContainer = UIView(frame: CGRect(x: password.frame.origin.x - 60, y: password.frame.origin.x - 40, width: 60, height: password.frame.height))
        let passImgContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: password.frame.height))
        let passImView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25.0, height: 25.0))
        passImView.image = UIImage(named: "password")
        passImView.contentMode = .scaleAspectFit
        passImView.center = passImgContainer.center
        passImgContainer.addSubview(passImView)
        password.leftView = passImgContainer
        password.delegate = self
    }

    @IBAction func LoginClicked(_ sender: UIButton) {
        indicator?.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        let email = self.emailField.text
        let password = self.password.text
        if let em = email, let pass = password{
            print(em, pass)
            self.signIn(email: em, password: pass)
        }

        
    }

    private func signIn(email: String, password: String){
        //var window = Popup.show(vc: self)
        //Auth.auth().signIn(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthResultCallback?##AuthResultCallback?##(User?, Error?) -> Void#>)
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            //Popup.hide(alertWindow: window)
            if let error = error{
                if let erCode = AuthErrorCode(rawValue: error._code)
                {
                    
                    switch erCode {
                    case AuthErrorCode.userNotFound:
                        DispatchQueue.main.async {
                            //MessageBox.showSnackbar(message:"No such user")
                            MessageBox.Show(message: "No such user", title: "Error", view: self)
                        }
                    case AuthErrorCode.invalidEmail:
                        DispatchQueue.main.async {
                            //MessageBox.showSnackbar(message:"Invalid email")
                            MessageBox.Show(message: "Invalid Email", title: "Error", view: self)
                        }
                    case AuthErrorCode.wrongPassword:
                        DispatchQueue.main.async {
                            //MessageBox.showSnackbar(message:"Wrong password")
                            MessageBox.Show(message: "Wrong password", title: "Error", view: self)
                        }
                    case AuthErrorCode.networkError:
                        DispatchQueue.main.async {
                            //MessageBox.showSnackbar(message:"Network error")
                            MessageBox.Show(message: "Network error", title: "Error", view: self)
                        }
                    default:
                        DispatchQueue.main.async {
                            MessageBox.Show(message: error.localizedDescription, title: "Error", view: self)
                        }
                    }
                }
                return
            }
            
            self.performSegue(withIdentifier: "main", sender: self)
            //self.performSegue(withIdentifier: "main", sender: self)
        }
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "cats", sender: self)
    }
    
}

extension LoginVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


