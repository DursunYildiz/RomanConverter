//
//  ViewController.swift
//  RomanNumbers
//
//  Created by A101Mac on 9.01.2022.
//

import CoreData
import UIKit
class ViewController: UIViewController {
    var number: String = ""
    
    @IBOutlet var romanTextField: UITextField!
    
    @IBOutlet var intLabel: UILabel!
    let dictRomanValue: [String: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000, "MM": 2000, "MMM": 3000, "MMMM": 4000]
    
    @IBOutlet var addToFavitesOutlet: UIButton!
    @IBOutlet var convertButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        addToFavitesOutlet.isUserInteractionEnabled = false
    }

    @IBAction func addToFavoritesButton(_ sender: Any) {
        if number != "" {
            saveCoreData(number: number)
        }
    }

    @IBAction func goToFavoritesClicked(_ sender: Any) {
        performSegue(withIdentifier: "goFavorites", sender: nil)
    }
    
    @IBAction func convertBtn(_ sender: Any) {
        number = ""
        var wrongCharacters: [String] = []
        let romanNumber = romanTextField.text ?? ""
        let myDic = Dictionary(grouping: romanNumber, by: { $0 })
      
        for item in myDic {
            if let _ = dictRomanValue.keys.firstIndex(of: String(item.key)) {
            } else {
                wrongCharacters.append(String(item.key))
            }
        }

        if romanNumber.isRoman() {
            if wrongCharacters.isEmpty {
                addToFavitesOutlet.isUserInteractionEnabled = true
               
                number = romanNumber + " : " + romanNumber.convertToRoman()
               
                intLabel.text = "Hesaplanan değer :" + romanNumber.convertToRoman()
               
            } else {
                intLabel.text = "Hesaplanan değer : \(romanNumber.convertToRoman()) \n Hatalı bulunan karakterler \(wrongCharacters.joined(separator: ",")) "
            }
        } else {
            alertDialog()
        }
    }

    func alertDialog() {
        let alert = UIAlertController(title: "Uyarı", message: "Lütfen geçerli roma rakamı giriniz", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { _ in
        }
           
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveCoreData(number: String) {
        if getCoreData(number: number).isEmpty {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate!.persistentContainer.viewContext
            let fetchRequest = FavoritesRoman(context: context)
            fetchRequest.number = number
            
            do {
                try? context.save()
            }
        }
    }
    
    func getCoreData(number: String) -> [FavoritesRoman] {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoritesRoman> = NSFetchRequest(entityName: "FavoritesRoman")
        
        fetchRequest.predicate = NSPredicate(format: "number = %@", number)
        do {
            let results = try? context.fetch(fetchRequest)
            return results ?? []
        }
    }
}

