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
    @IBOutlet weak var streaksUnitLabel: WKInterfaceLabel!
    @IBOutlet weak var graph: WKInterfaceImage!

    // TODO: ユーザ名を自由に指定できるようにする(要: AppGroup?)
    lazy var github : Github? = {
        if let username = AppGroup.userDefaults().stringForKey("username") {
            return Github(user: username)
        } else {
            return nil
        }
    }()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        github?.contributions { (_ : Int, weekStreaks: Int, data: [ContributionByDate]) -> Void in
            self.currentStreaks.setText("\(weekStreaks)")
            self.streaksUnitLabel.setText(weekStreaks == 1 ? "week" : "weeks")
            let image = ContributionsCalendar(data: data).draw(CGSizeMake(272, 203))
            self.graph.setImage(image)
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
