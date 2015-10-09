//
//  GamePickerViewController.swift
//  Ratings
//
//  Created by freeda.ma on 15/10/9.
//  Copyright © 2015年 FPSS 1999-2015. All rights reserved.
//

import UIKit

class GamePickerViewController: UITableViewController {
    
    var games:[String] = [
        "Angry Birds",
        "Chess",
        "Russian Roulette",
        "Spin the Bottle",
        "Texas Hold'em Poker",
        "Tic-Tac-Toe"]
    
    //add properties to hold the name and the index of the currently selected game
    var selectedGame:String? {
        didSet {
            if let game = selectedGame {
                selectedGameIndex = games.indexOf(game)!
            }
        }
    }
    var selectedGameIndex:Int?
    
    /**
    nfortunately, the unwind segue method is performed before tableView(_:didSelectRowAtIndexPath:), so that the selectedGameIndex is not updated in time. Fortunately, you can override prepareForSegue(_:sender:) and complete that operation before the unwind happens.
    
    In GamePickerViewController, override prepareForSegue(_:sender:):
    */
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath)
        cell.textLabel?.text = games[indexPath.row]
        
        if indexPath.row == selectedGameIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedGameIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        selectedGame = games[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedGame" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                if let index = indexPath?.row {
                    selectedGame = games[index]
                }
            }
        }
    }
}
