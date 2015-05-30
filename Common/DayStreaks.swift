import Foundation
// 日ごとのContribution数から DayStreaksを計算する
//
// 毎日1回以上contributeしていれば、streaksが継続しているとみなす
class DayStreaks {
    private let data : [ContributionByDate]
    init(data : [ContributionByDate]) {
        self.data = data
    }

    func call() -> Int {
        return call(NSDate())
    }

    // 日付指定でweek streakを計算する(ほぼテストから使うのが目的)
    func call(today: NSDate) -> Int {
        return data.reverse().filter{
            $0.date.compare(today) != .OrderedDescending
        }.takeWhile{
            $0.count > 0
        }.count
    }
}
