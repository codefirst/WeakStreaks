//
//  InterfaceController.swift
//  WeakStreaks WatchKit Extension
//
//  Created by mzp on 5/20/15.
//  Copyright (c) 2015 mzp. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var weekStreaks: WKInterfaceLabel!
    @IBOutlet weak var weekStreaksUnit: WKInterfaceLabel!
    
    @IBOutlet weak var dayStreaks: WKInterfaceLabel!
    @IBOutlet weak var dayStreaksUnit: WKInterfaceLabel!

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
            self.weekStreaks.setText("\(weekStreaks)")
            self.weekStreaksUnit.setText(weekStreaks == 1 ? "week" : "weeks")

            let dayStreaks = DayStreaks(data: data).call()
            self.dayStreaks.setText("\(dayStreaks)")
            self.dayStreaksUnit.setText(dayStreaks == 1 ? "day" : "days")

            let image = ContributionsCalendar(data: data).draw(self.graphSize)
            self.graph.setImage(image)
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
