import Foundation
import UIKit


private let colors: [(min: Int, color: UIColor)] = [
    (11, UIColor(red:  17 / 255.0, green: 106 / 255.0, blue:  30 / 255.0, alpha: 1.0)),
    (8, UIColor(red:  56 / 255.0, green: 165 / 255.0, blue:  57 / 255.0, alpha: 1.0)),
    (4, UIColor(red: 135 / 255.0, green: 200 / 255.0, blue:  95 / 255.0, alpha: 1.0)),
    (1, UIColor(red: 212 / 255.0, green: 232 / 255.0, blue: 127 / 255.0, alpha: 1.0)),
    (0, UIColor(white: 238 / 255.0, alpha: 1.0)),
]
private func color(#contributions: Int) -> UIColor {
    for c in colors {
        if contributions >= c.min {
            return c.color
        }
    }
    return colors.last!.color
}

private let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
extension NSDate {
    var weekOfYear: Int {
        return calendar.component(.CalendarUnitWeekOfYear, fromDate: self)
    }
    var dayOfWeek: Int {
        return calendar.component(.CalendarUnitWeekday, fromDate: self)
    }
    
    func numberOfWeeksFromWeekOfDate(date: NSDate) -> Int {
        let sundayOfA = calendar.dateByAddingUnit(.CalendarUnitWeekday, value: 1 - date.dayOfWeek, toDate: date, options: nil)!
        let sundayOfB = calendar.dateByAddingUnit(.CalendarUnitWeekday, value: 1 - self.dayOfWeek, toDate: self, options: nil)!
        return calendar.components(.CalendarUnitWeekOfYear, fromDate: sundayOfA, toDate: sundayOfB, options: nil).weekOfYear
    }
}


class ContributionsCalendar {
    let data: [ContributionByDate]
    
    init(data : [ContributionByDate]) {
        self.data = data
    }
    
    func draw(size: CGSize) -> UIImage {
        let imageRect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContext(size)
        
        UIColor.blackColor().setFill()
        UIRectFill(imageRect)
        
        let cols = Int(7)
        let margin = CGFloat(1)
        let cellSide = floor((size.height - CGFloat(cols - 1) * margin) / CGFloat(cols))
        
        let today = NSDate()
        
        for d in data {
            let date = d.date
            color(contributions: d.count).setFill()
            
            let x = size.width - cellSide - CGFloat(today.numberOfWeeksFromWeekOfDate(date)) * (cellSide + margin)
            let y = CGFloat(date.dayOfWeek - 1) * (cellSide + margin)
            UIRectFill(CGRectMake(x, y, cellSide, cellSide))
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}