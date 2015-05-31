// 日ごとのContribution数から WeekStreaksを計算する
//
// 毎週1回以上contributeしていれば、streaksが継続しているとみなす
class WeekStreaks {
    private let data : [ContributionByDate]
    init(data : [ContributionByDate]) {
        self.data = data
    }

    /// :returns: count: 週数, continued: 今週継続しているかどうか
    func call() -> (count: Int, continued: Bool) {
        return call(NSDate())
    }

    // 日付指定でweek streakを計算する(ほぼテストから使うのが目的)
    func call(today: NSDate) -> (count: Int, continued: Bool) {
        var weekStreaks = 0
        var continued = true
        for w in 0...51 {
            let contributionsOfTheWeek = data.filter { today.numberOfWeeksFromWeekOfDate($0.date) == w }
            let hasNonZeroContributions = contributionsOfTheWeek.reduce(0, combine: {$0 + $1.count}) > 0

            // その週のcontributionが無いときは，前週から数える
            if w == 0 && !hasNonZeroContributions {
                continued = false
                continue
            }

            if hasNonZeroContributions {
                weekStreaks += 1
            } else {
                break
            }
        }
        return (weekStreaks, continued)
    }
}