//
//  RecipeTableViewController.swift
//  FoodPin
//
//  Created by  Артем Куртуков on 19.03.2020.
//  Copyright © 2020  Артем Куртуков. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Борщ", "Жаркое с паровым картофелем", "Брауни", "Картофель фри", "Макароны с колбасой и сыром в мультиварке", "Каша манная", "Ассорти рыбное", "Овсяные пряники" , "Вафельные трубочки", "Слойка с сахаром", "Каша ячневая", "Креветки на гриле", "Овощное рагу", "Сэндвич с тунцом и сыром", "Семга с горчицей и укропом", "Пицца с морепродуктами", "Бургер с рыбой", "Сэндвич с ветчиной и сыром", "Семга-гриль", "Суп-пюре с мясом"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
        
    var restaurantTypes = ["Супы", "Основные блюда", "Десерты", "Закуски", "Основные блюда", "Каши", "Закуски", "Десерты", "Выпечка", "Выпечка", "Каши", "Закуски", "Основные блюда", "Закуски", "Закуски", "Выпечка", "Основные блюда", "Закуски", "Основные блюда", "Супы", "Thai"]
    
    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.cellLayoutMarginsFollowReadableWidth = true
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantNames[indexPath.row])
        
        // Solution to exercise 2
        cell.heartImageView.isHidden = !self.restaurantIsVisited[indexPath.row]
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        // For iPad
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Add Call action
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }

        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        // Check-in action
        let checkInTitle = self.restaurantIsVisited[indexPath.row] ? "Undo Check in" : "Check in"
        let checkInAction = UIAlertAction(title: checkInTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
            
            // Solution to exercise 1
//            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .none : .checkmark
            
            // Solution to exercise 2
            // We use the isHidden property to control whether the image view is displayed or not
            cell?.heartImageView.isHidden = self.restaurantIsVisited[indexPath.row]
            
            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
        })
        optionMenu.addAction(checkInAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        // Deselect a row
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
