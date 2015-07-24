import Foundation

private let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!

// NSDateを拡張し、曜日に関するメソッドを追加する
extension NSDate {
    var weekOfYear: Int {
        return calendar.component(.WeekOfYear, fromDate: self)
    }
    var dayOfWeek: Int {
        return calendar.component(.Weekday, fromDate: self)
    }

    func numberOfWeeksFromWeekOfDate(date: NSDate) -> Int {
        let sundayOfA = calendar.dateByAddingUnit(.Weekday, value: 1 - date.dayOfWeek, toDate: date, options: [])!
        let sundayOfB = calendar.dateByAddingUnit(.Weekday, value: 1 - self.dayOfWeek, toDate: self, options: [])!
        return calendar.components(.WeekOfYear, fromDate: sundayOfA, toDate: sundayOfB, options: []).weekOfYear
    }
}

extension Array {
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