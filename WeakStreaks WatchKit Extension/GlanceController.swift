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

    lazy var github : Github? = {
        if let username = AppGroup.userDefaults().stringForKey("username") {
            return Github(user: username)
        } else {
            return nil
        }
    }()
    
    let graphSize = CGSizeMake(WKInterfaceDevice.currentDevice().screenBounds.width, 100)

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        github?.contributions { (data: [ContributionByDate]) -> Void in
            let weekStreaks = WeekStreaks(data: data).call()
            self.currentStreaks.setText("\(weekStreaks)")
            self.streaksUnitLabel.setText(weekStreaks == 1 ? "week" : "weeks")
            let image = ContributionsCalendar(data: data).draw(self.graphSize)
            self.graph.setImage(image)
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
