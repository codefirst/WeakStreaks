// 日ごとのContribution数から WeekStreaksを計算する
//
// 毎週1回以上contributeしていれば、streaksが継続しているとみなす
class WeekStreaks {
    private let data : [ContributionByDate]
    init(data : [ContributionByDate]) {
        self.data = data
    }

    func call() -> Int {
        return call(NSDate())
    }

    // 日付指定でweek streakを計算する(ほぼテストから使うのが目的)
    func call(today: NSDate) -> Int {
        var weekStreaks = 0
        for w in 0...51 {
            let contributionsOfTheWeek = data.filter { today.numberOfWeeksFromWeekOfDate($0.date) == w }

            // 今日の分がまだ取得データに載っていなく，その週のデータ数がゼロの場合はスキップ(前週から数える)
            if w == 0 && contributionsOfTheWeek.count == 0 { continue }

            if contributionsOfTheWeek.reduce(0, combine: {$0 + $1.count}) > 0 {
                weekStreaks += 1
            } else {
                break
            }
        }
        return weekStreaks
    }
}