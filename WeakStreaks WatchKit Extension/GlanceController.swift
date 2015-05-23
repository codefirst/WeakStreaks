//
//  GlanceController.swift
//  WeakStreaks WatchKit Extension
//
//  Created by mzp on 5/20/15.
//  Copyright (c) 2015 mzp. All rights reserved.
//

import WatchKit
import Foundation


private extension Array {
    func takeWhile(@noescape f: (Element) -> Bool) -> Array {
        var a = [Element]()
        for elem in self {
            if f(elem) {
                a.append(elem)
            } else {
                break
            }
        }
        return a
    }
}


class GlanceController: WKInterfaceController {
    @IBOutlet weak var currentStreaks: WKInterfaceLabel!
    @IBOutlet weak var graph: WKInterfaceImage!

    // TODO: ユーザ名を自由に指定できるようにする(要: AppGroup?)
    let github = Github(user: "mzp")
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        github.contributions { (data: [ContributionByDate]) -> Void in
            let streaks = data.reverse().takeWhile{$0.count > 0}.count
            self.currentStreaks.setText("\(streaks)")
            let image = ContributionsCalendar(data: data).draw(CGSizeMake(272, 203))
            self.graph.setImage(image)
        }
        return
//        
//        github.contributions { (currentStreaks : Int, currentWeek: [Int]?) in
//            self.currentStreaks.setText("\(currentStreaks)")
//
//            if let data = currentWeek {
//                // FIXME: http://qiita.com/_tid_/items/55667b00ce158a28428a を使って結果をキャッシュする
//                let image = WeekGraph(data: data).draw()
//                self.graph.setImage(image)
//            }
//        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
