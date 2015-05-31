import Foundation

private let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!

// NSDateを拡張し、曜日に関するメソッドを追加する
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