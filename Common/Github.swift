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

    func contributions(f : (data : [ContributionByDate]) -> Void) {
        Alamofire
            .request(.GET, "\(ENTRY_POINT)/\(user)")
            .responseJSON { (_, _, json, _) in
                let dict = json as? NSDictionary
                let data = (dict?["data"] as? [String:Int]).map{ self.parseData($0) }
                f(data: data ?? [])
        }
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
        ys.sort {
            $0.date.compare($1.date) == .OrderedAscending
        }

        return ys
    }
}