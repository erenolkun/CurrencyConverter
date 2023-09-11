//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by FERDA OLKUN on 12.07.2023.
//

import UIKit

class ViewController: UIViewController {

     
    @IBOutlet weak var cadLabel: UILabel!
    
    
    @IBOutlet weak var chfLabel: UILabel!
    
    
    @IBOutlet weak var gbpLabel: UILabel!
    
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    
    @IBOutlet weak var usdLabel: UILabel!
    
    
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }

    @IBAction func getRatesClicked(_ sender: Any) {
//1.Request and Session
        let url = URL(string:"http://data.fixer.io/api/latest?access_key=1036b296570483ed8d202b6a9dd247c3")
        let session = URLSession.shared
//closure
        let task = session.dataTask(with: url!) { data ,response, error in
//error?.localizedDescription -> kullanıcıya internet bulunamadı gibi mesaj vermek için kullandım.
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil )

            }else{
//2.Response and Data
                if data != nil{
                
                     do {
                 let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                         
                        
                         //ASYNC
                         
                         DispatchQueue.main.async {
                             if let  rates = jsonResponse["rates"] as? [String : Any]{
                                 //print(rates)
                            
                                 if let cad = rates["CAD"] as? Double {
                                     self.cadLabel.text = "CAD: \(cad)"
                                     
                                 }
                                 
                                 if let chf = rates["CHF"] as? Double {
                                     self.chfLabel.text = "CHF: \(chf)"
                                     
                                 }
                                 if let gbp = rates["GBP"] as? Double {
                                     self.gbpLabel.text = "GBP: \(gbp)"
                                     
                                 }
                                 if let jpy = rates["JPY"] as? Double {
                                     self.jpyLabel.text = "JPY: \(jpy)"
                                     
                                 }
                                 
                                 if let usd  = rates["USD"] as? Double {
                                     self.usdLabel.text = "USD: \(usd)"
                                     
                                 }
                                 if let turkish = rates["TRY"] as? Double {
                                     self.tryLabel.text = "TRY: \(turkish)"
                                     
                                 }
                                 
                                 
                             }
                         }
                         
                         
                    } catch {
                        print("error")
                    }
                }
                
            }
        }
        task.resume()
    }
    
}

