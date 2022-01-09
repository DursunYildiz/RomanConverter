//
//  FavoritesViewController.swift
//  RomanNumbers
//
//  Created by A101Mac on 9.01.2022.
//

import UIKit
import CoreData
class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    

    @IBOutlet weak var favoritesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = getCoreData()[indexPath.row].number
        return cell
    }
    func getCoreData () -> [FavoritesRoman] {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoritesRoman> = NSFetchRequest(entityName: "FavoritesRoman")
        do {
                       let results = try? context.fetch(fetchRequest)
            return results ?? []
           
        }
       
    }
}
