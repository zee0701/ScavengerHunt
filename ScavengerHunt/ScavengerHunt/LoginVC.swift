
import UIKit

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


