
import UIKit

class PlayVC: UIViewController, UITextFieldDelegate{
    
    var allClues = NSDictionary()
    var puzzles = [Puzzle]()
    var currentPuzzle = 0
    var timer: Timer?
    var timerTick = 0
    var pChar = [Character]()
    var reward: String?
    
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var puzzleField: UITextView!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.hideKeyBoardWhenTapped()
        answerField.delegate = self
        
        if let yes = UserDefaults.standard.value(forKey: UserInfo.SelectedHunt! + "completed") as? String{
            if yes == "yes"{
                MessageBox.ShowSnackbar(message: "You already have completed this Hunt")
            }
        }
        
        if let index: Int = UserDefaults.standard.value(forKey: UserInfo.SelectedHunt!) as? Int{
            currentPuzzle = index
        }
        self.retrieveAllClues()
        //FireCon.getInstance().reporterDelegate = self
        //FireCon.getInstance().retrieveAllClues(name: UserInfo.SelectedHunt!)
    }
    
    func retrieveAllClues(){
        print(UserInfo.SelectedHunt)
        if let hunt = UserInfo.SelectedHunt{
            print(totalHunts)
            if let clue = totalHunts[hunt] as? NSDictionary{
                self.ReportCluesRetrieved(clues: clue)
            }
        }
    }
    
    func getNum(string: String)-> Int{
        let component = string.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        
        let list = component.filter({ $0 != "" }) // filter out all the empty strings in the component
        //print(list)
        return Int(list[0])!
    }
    
    
    
    
    
    func ReportCluesRetrieved(clues: NSDictionary){
        self.allClues = clues
        if let keys = self.allClues.allKeys as? [String]{
            for k in keys{
                if k == "reward"{
                    if let r = allClues[k] as? String{
                        self.reward = r
                    }
                }
                else if k != "total"{
                    var value = allClues[k] as? String
                    if let v = value{
                        var pz = Puzzle(puzzle: v, answer: k)
                        puzzles.append(pz)
                        print("Element added to puzzles")
                    }
                }
            }
        }
        var sortedPux = puzzles.sorted(by: {$0.puzzle! < $1.puzzle!})
        
        for i in 0..<sortedPux.count{
            for j in 0..<sortedPux.count - 1{
                var num1 = getNum(string: sortedPux[j].puzzle!)
                var num2 = getNum(string: sortedPux[j+1].puzzle!)
                if (num1 > num2){
                    //  print("Swaping \(num1) : \(num2)")
                    var first = sortedPux[j]
                    sortedPux[j] = sortedPux[j+1]
                    sortedPux[j+1] = first
                }
            }
        }
        
        
        puzzles = sortedPux
        
        if puzzles.count > 0{
            fillAndStartTimer()
        }
        //puzzleField.text = puzzles[currentPuzzle].puzzle
    }
    
    
    func timerKicked(){
        puzzleField.text = puzzleField.text + String(pChar[timerTick])
        
        timerTick += 1
        if timerTick == pChar.count{
            timer?.invalidate()
        }
        print("Timer Kicking")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func fillAndStartTimer(){
        puzzleField.text = ""
        pChar.removeAll()
        timerTick = 0
        var shouldStartFilling = false
        for i in (puzzles[currentPuzzle].puzzle?.characters)!{
            if shouldStartFilling == true{
                pChar.append(i)
            }
            if i == "_"{
                shouldStartFilling = true
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: Selector("timerKicked"), userInfo: nil, repeats: true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("end Editing")
        animateView(up: false, distance: 80)
        
        var ans = textField.text
        if ans == puzzles[currentPuzzle].answer{
            MessageBox.ShowSnackbar(message: "Correct Answer")
            currentPuzzle += 1
            if currentPuzzle < puzzles.count{
                //puzzleField.text = puzzles[currentPuzzle].puzzle
                fillAndStartTimer()
                textField.text = ""
                UserDefaults.standard.set(currentPuzzle, forKey: UserInfo.SelectedHunt!)
            }
            else{
//                MessageBox.Show(message: "Congrats, you have completed all the puzzles, go back and choose another hunt", title: "Congratulation", view: self)
                UserDefaults.standard.set("yes", forKey: UserInfo.SelectedHunt! + "completed")
                currentPuzzle = 0
                UserDefaults.standard.set(currentPuzzle, forKey: UserInfo.SelectedHunt!)
                //RewardVC.reward = self.reward
                self.performSegue(withIdentifier: "reward", sender: self)
                //self.dismiss(animated: true, completion: nil)
            }
        }
        else{
             MessageBox.ShowSnackbar(message: "Wrong Answer")
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateView(up: true, distance: 80)
        print("begin Editing")
    }
    
    
    
    func animateView(up: Bool, distance: CGFloat){
        UIView.beginAnimations("answerField", context: nil)
        UIView.setAnimationDuration(0.3)
        UIView.setAnimationBeginsFromCurrentState(true)
        let movement:CGFloat = ( up ? -distance : distance)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
}




