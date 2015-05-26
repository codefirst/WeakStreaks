import Alamofire
import Foundation

typealias ContributionByDate = (date: NSDate, count: Int)

// Githubの情報を https://github.com/suer/ghstreaks-service を用いて取得する。
//
// このアプリの拡張にあわせてghstreaks-serviceも拡張するので、1つのAPIで必要な情報の(ほぼ)すべてを取得できる
// という前提で実装する。
class Github {
    private let user : String
    private let ENTRY_POINT = "https://weakstreaks-service.herokuapp.com/streaks"

    init(user : String) {
        self.user = user
    }

    func contributions(f : (dayStreaks: Int, weekStreaks: Int, data : [ContributionByDate]) -> Void) {
        Alamofire
            .request(.GET, "\(ENTRY_POINT)/\(user)")
            .responseJSON { (_, _, json, _) in
                let dict = json as? NSDictionary
                let dayStreaks = dict?["current_streaks"] as? Int
                let data = (dict?["data"] as? [String:Int]).map{ self.parseData($0) }
                let weekStreaks = data.map{ self.parseWeekStreak($0)}
                f(dayStreaks: dayStreaks ?? 0, weekStreaks: weekStreaks ?? 0,data: data ?? [])
        }
    }

    private func parseWeekStreak(data : [ContributionByDate]) -> Int {
        // TODO: ここで計算するのではなく、weakstreaks-service側でやってもいいかも?
        let today = NSDate()
        var weekStreaks = 0
        for w in 0...51 {
            let contributionsOfTheWeek = data.filter { today.numberOfWeeksFromWeekOfDate($0.date) == w }

            // 今日の分がまだ取得データに載っていなく，その週のデータ数がゼロの場合はスキップ(前週から数える)
            if contributionsOfTheWeek.reduce(0, combine: {$0 + $1.count}) > 0 {
                weekStreaks += 1
            } else {
                break
            }
        }
        return weekStreaks
    }

    private func parseData(xs : [String:Int]) -> [ContributionByDate]{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        var ys : [ContributionByDate] = []

        for (dateStr,count) in xs {
            if let date = dateFormatter.dateFromString(dateStr) {
                ys.append((date: date, count: count))
            }
        }
        return ys
    }
}