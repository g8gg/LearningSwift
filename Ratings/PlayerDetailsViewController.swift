//
//  PlayerDetailsViewControllerTableViewController.swift
//  Ratings
//
//  Created by freeda.ma on 15/10/9.
//  Copyright © 2015年 FPSS 1999-2015. All rights reserved.
//
//http://www.raywenderlich.com/113394/storyboards-tutorial-in-ios-9-part-1
//http://www.raywenderlich.com/113394/storyboards-tutorial-in-ios-9-part-2

import UIKit

class PlayerDetailsViewController: UITableViewController {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    var player:Player?
    
    var game:String = "Chess" {
        didSet {
            detailLabel.text? = game
        }
    }
    
    //The other view controllers are not instantiated until you segue to them. When you close these view controllers they are immediately deallocated, so only the actively used view controllers are in memory.
    required init?(coder aDecoder: NSCoder) {
        print("init PlayerDetailsViewController")
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("deinit PlayerDetailsViewController")
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SavePlayerDetail" {
            player = Player(name: nameTextField.text, game:game, rating: 1)
        }
        
        
        //One more thing – when you choose a game, return to the Add Player scene, then try to choose a game again, the game you chose before should have a checkmark by it. The solution is to pass the selected game stored in PlayerDetailsViewController over to the GamePickerViewController when you segue.
        if segue.identifier == "PickGame" {
            if let gamePickerViewController = segue.destinationViewController as? GamePickerViewController {
                gamePickerViewController.selectedGame = game
            }
        }
    }
   
    
    
    @IBAction func unwindWithSelectedGame(segue:UIStoryboardSegue) {
        if let gamePickerViewController = segue.sourceViewController as? GamePickerViewController,
            selectedGame = gamePickerViewController.selectedGame {
                game = selectedGame
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /**
    *  When you use static cells, your table view controller doesn’t need a data source. Because you used an Xcode template to create the PlayerDetailsViewController class, it still has some placeholder code for the data source and that will prevent the static cells from working properly – that’s why your static content wasn’t visible here. Time to fix it!
    
    One more thing about static cells: they only work in UITableViewController. Even though Interface Builder will let you add them to a Table View object inside a regular UIViewController, this won’t work during runtime. The reason for this is that UITableViewController provides some extra magic to take care of the data source for the static cells. Xcode even prevents you from compiling such a project with the error message: “Illegal Configuration: Static table views are only valid when embedded in UITableViewController instances”. Prototype cells, on the other hand, work just fine in a table view that you place inside a regular view controller.
    
    Note: If you’re building a scene that has a lot of static cells — more than can fit in the visible frame — then you can scroll through them in Interface Builder with the scroll gesture on the mouse or trackpad (2 finger swipe). This might not be immediately obvious, but it does work.
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }//This just says that if the user tapped the first cell, the app should activate the text field. There is only one cell in the section so you only need to test for the section index. Making the text field the first responder will automatically bring up the keyboard. It’s just a little tweak, but one that can save users a bit of frustration.
    
    /**
    *  Tip: when adding a delegate method, or overriding a view controller method, just start typing the method name (without preceding it with “func”), and then you will be able to select the correct method from the list available.
    */
    
}
