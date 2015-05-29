//
//  ViewController.swift
//  WeakStreaks
//
//  Created by mzp on 5/20/15.
//  Copyright (c) 2015 mzp. All rights reserved.
//

import UIKit

class ViewController: SafeTableViewController {
    private let usernameField = UITextField(frame: CGRectZero)
    private lazy var doneButton : UIBarButtonItem = UIBarButtonItem(
        title: NSLocalizedString("Save", comment:""),
        style: .Done, target:self, action: Selector("save"))


    init() {
        super.init(style: .Grouped)
        self.navigationItem.rightBarButtonItem = doneButton
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - view controller
    override func viewDidLoad() {
        super.viewDidLoad()

        println(AppGroup.appGroupID())
        if let username = AppGroup.userDefaults().stringForKey("username") {
            usernameField.text = username
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: table view

    let kCellID = "Cell"

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellID) as? UITableViewCell ?? UITableViewCell(style: .Default, reuseIdentifier: kCellID)

        cell.textLabel?.text = NSLocalizedString("Username", comment:"")
        usernameField.frame = CGRectMake(0, 0, cell.frame.width - 80, 130)
        usernameField.clearButtonMode = .WhileEditing
        usernameField.placeholder = "user name"
        usernameField.contentVerticalAlignment = .Center
        cell.accessoryView = usernameField
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }


    // MARK: - actions
    @objc private func save() {
        let userDefaults = AppGroup.userDefaults()
        userDefaults.setObject(usernameField.text, forKey: "username")
        userDefaults.synchronize()
    }


}

