//
//  ViewController.swift
//  AuthentificationWithCoreData
//
//  Created by Walid Sassi on 05/01/2017.
//  Copyright © 2017 Walid Sassi. All rights reserved.
//

import UIKit
// don't foget to import
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var btConnect: UIButton!
    
    
    // verify login and password
    @IBAction func logIn(_ sender: UIButton) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let newvalue = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newvalue.setValue(login.text, forKey: "login")
        newvalue.setValue(passwd.text, forKey: "passwd")
        do{
            try context.save()
            login.alpha = 0
            passwd.alpha = 0
            message.alpha = 1
            btConnect.alpha = 0
            message.text = "Hi " + login.text! + "!"
        }
        catch{
          print("error in saved")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // configure connection to coreData
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        // define the fetchrequest object
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        // execute context to fetch data from User table
        do{
        let results = try context.fetch(request)
            for result in results as![NSManagedObject]{
                if let name = result.value(forKey: "login") as? String {
                    login.alpha = 0
                    passwd.alpha = 0
                    message.alpha = 1
                    btConnect.alpha = 0
                    message.text = "Hi " + name + "!"
                }else{
                    
                }
            }
            
        }
        catch {
            print("there was an error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

