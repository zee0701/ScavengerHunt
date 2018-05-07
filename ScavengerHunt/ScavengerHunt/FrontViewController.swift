

import UIKit




class FrontViewController: UITableViewController {
    


    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var hunts = [String]()
    var selectedCat: String?
    var cache:NSCache<AnyObject, AnyObject>!
    var indicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readJsonFile()
        self.indicator = MessageBox.SetupIndicator(view: self.view)
        
        
        //indicator?.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
    }

    private func readJsonFile(){
        if let path = Bundle.main.path(forResource: "Hunts", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //print(jsonResult)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    if let th = jsonResult as? NSDictionary{
                        totalHunts = th
                    }
                    if let dictionary = jsonResult["Hunts"] as? NSDictionary{
                        
                        print("Dic not nul Exists")
                        let allValues = dictionary.allValues
                        if let all = allValues as? [String]{
                            print("Values obtained")
                            
                            for i in all{
                                print(i)
                                hunts.append(i)
                            }
                            
                        }
                    }
                }
            } catch let error {
                // handle error
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.cache.removeAllObjects()
        // Dispose of any resources that can be recreated.
    }
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Data.categoryForSearch = selectedCat
        
    }
 
    
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hunts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cat_cell", for: indexPath) as! FrontViewCell

        cell.contentView.backgroundColor = UIColor.clear
        
        //let whiteRoundedView : UIView = UIView(frame: CGRect(10, 8, self.view.frame.size.width - 20, 149))
        let whiteRoundedView: UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.width - 20, height: 200))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.8])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        cell.categoryLabel.text = self.hunts[indexPath.row]
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserInfo.SelectedHunt = self.hunts[indexPath.row]
        let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Play", style: .default) { (action) in
            self.performSegue(withIdentifier: "play", sender: self)
        }
        
        let actionScore = UIAlertAction(title: "Score Board", style: .default) { (action) in
            self.performSegue(withIdentifier: "scoreSegue", sender: self)
        }
        
        alert.addAction(action)
        alert.addAction(actionScore)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

//extension FrontViewController: AuthenticateUserDelegate{
//    func ReportHuntsRetrieved(hunts: [String]) {
//        indicator?.stopAnimating()
//        UIApplication.shared.endIgnoringInteractionEvents()
//        if hunts.count > 0{
//            self.hunts = hunts
//            self.tableView.reloadData()
//        }
//        else{
//            MessageBox.Show(message: "No Hunts Available", title: "Empty", view: self)
//        }
//    }
//}







