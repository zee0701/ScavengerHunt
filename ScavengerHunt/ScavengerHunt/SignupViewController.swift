

import UIKit


class SignupViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTapToHide()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    private func addTapToHide(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.keyboardHide))
        self.view.addGestureRecognizer(tap)
    }
    @objc func keyboardHide(){
        self.view.endEditing(true)
    }
    
    @IBAction func signupAction(_ sender: UIButton) {
        guard let username = usernameField.text, !username.isEmpty else{
            print("User Name invalid")
            return
        }
        
        guard let email = emailField.text,  !email.isEmpty else{
            print("Invalid email")
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else{
            print("Password can not be empty")
            return
        }
        
        self.signUp(email: email, password: password, username: username)
        
    }
    
    private func signUp(email: String, password: String, username: String){
        print("Signed up")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
