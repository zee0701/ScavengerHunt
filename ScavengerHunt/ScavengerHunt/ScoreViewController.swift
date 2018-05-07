//
//  ScoreViewController.swift
//  ScavengerHunt
//
//  Created by Salman on 5/5/18.
//  Copyright © 2018 Salman. All rights reserved.
//

import UIKit
import Firebase

class Score{
    var score: Int = 0
    var total: Int = 0
    var userid: String?
    var puzzle: String?
    var name: String?
}



class ScoreViewController: UIViewController {

    var scores = [Score]()
    
    @IBOutlet weak var scoreTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScore()
        self.scoreTable.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let name = UserInfo.SelectedHunt{
            self.title = name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadScore(){
        var path = ""
        if let hunt = UserInfo.SelectedHunt{
            path = "score/\(hunt)"
        }
        Database.database().reference(withPath: path).observeSingleEvent(of: .value, with: {(snapshot) in
            print(snapshot)
            if let dic = snapshot.value as? NSDictionary{
                if let keys = dic.allKeys as? [String]{
                    for key in keys{
                        let score = Score()
                        score.userid = key
                        if let d = dic[key] as? NSDictionary{
                            if let s = d["score"] as? NSNumber{
                                score.score = s.intValue
                            }
                            if let total = d["total"] as? NSNumber{
                                score.total = total.intValue
                            }
                        }
                        self.scores.append(score)
                    }
                }
            }
            DispatchQueue.main.async {
                self.scoreTable.reloadData()
            }
        })
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


extension ScoreViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scores.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        guard let nameLabel = cell.viewWithTag(349) as? UILabel else{
            return cell
        }
        guard let scoreLabel = cell.viewWithTag(24) as? UILabel else{
            return cell
        }
        if indexPath.row == 0{
            nameLabel.text = "Name"
            scoreLabel.text = "Score/Total"
        }
        else{
            scoreLabel.text = "\(self.scores[indexPath.row - 1].score) / \(self.scores[indexPath.row - 1].total)"
            if let name = self.scores[indexPath.row - 1].name{
                nameLabel.text = self.scores[indexPath.row - 1].name
            }
            else{
                if let id = self.scores[indexPath.row - 1].userid{
                    Database.database().reference(withPath: "users/\(id)").observeSingleEvent(of: .value, with: {(snapshot) in
                        if let dic = snapshot.value as? NSDictionary{
                            if let name = dic.value(forKey: "username") as? String{
                                self.scores[indexPath.row - 1].name = name
                                nameLabel.text = name
                            }
                        }
                    })
                }
                
            }
        }
        
        
        return cell
    }
    
}
