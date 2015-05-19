//
//  GlanceController.swift
//  WeakStreaks WatchKit Extension
//
//  Created by mzp on 5/20/15.
//  Copyright (c) 2015 mzp. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
    @IBOutlet weak var currentStreaks: WKInterfaceLabel!

    // TODO: ユーザ名を自由に指定できるようにする(要: AppGroup?)
    let github = Github(user: "mzp")
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        github.contributions { (currentStreaks : Int) in
            self.currentStreaks.setText("\(currentStreaks)")
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
