import UIKit

class BreakingVC: UIViewController {
    
    @IBOutlet weak var FirstImageView: UIImageView!
    
    @IBOutlet weak var SecondImageView: UIImageView!
    
    @IBOutlet weak var TextField: UITextField!
    
    @IBOutlet weak var TextView: UITextView!
    let aboutMe = """
Breaking since: 2018
Teams: Wild West Crew, Crazy Boys, SPASSKI team
Competitions: Gorrila Style ward, Red Bull BC One Kazakhstan, Just Grove it, Just a battle, etc
Goals: Candidate of Masters of Sports from Uralsk nathional battle
Style: Footwork, Flow
Favorutie DJs: Leg1oner, Akee, Mukhin Rock, 
"""
    override func viewDidLoad() {
        super.viewDidLoad()
        FirstImageView.image = UIImage(named: "Antsy2")
        
        SecondImageView.image = UIImage(named: "WildWestCrew")
        
        TextField.text = "Bboy Antsy"
        
        TextView.text = aboutMe
    }
}
