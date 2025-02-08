import UIKit

class KBTUVC: UIViewController {
    
    @IBOutlet weak var FirstImageView: UIImageView!

    @IBOutlet weak var SecondImageView: UIImageView!
    
    @IBOutlet weak var TextView: UITextView!
    

    @IBOutlet weak var FirstText: UITextField!
    
    let aboutMe = """
    Age: 20  
    Birthplace: Aktau  
    Family: Middle child  
    Study: KBTU, 22BD  
    Major: Computer Science and Software  
    Organizations: Arthouse  
    Skills: iOS Development, Golang, Web Development, Android Development  
    

    --------------Additional---------------
    - Holds a driver's license  
    - Watches Zamandas podcasts  
    - Studied arithmetic for 4 years  
    - Frequently listens to Hip-Hop & R&B  
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirstImageView.image = UIImage(named: "Nurken")
        
        SecondImageView.image = UIImage(named: "Arthouse")
        
        FirstText.text = "Atabay Nurken"
        
        TextView.text = aboutMe
    }
}
