import Alamofire

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

    func contributions(f : (currentStreaks: Int, currentWeek : [Int]?) -> Void) {
        Alamofire
            .request(.GET, "\(ENTRY_POINT)/\(user)")
            .responseJSON { (_, _, json, _) in
                let dict = json as? NSDictionary
                let currentStreaks = dict?.valueForKey("current_streaks") as? Int
                let currentWeek = dict?.valueForKey("current_week") as? [Int]
                f(currentStreaks: currentStreaks ?? 0, currentWeek: currentWeek)
        }
    }
    
    func contributions(f: ([ContributionByDate]) -> Void) {
        Alamofire
            .request(.GET, "https://github.com/users/\(user)/contributions")
            .responseString { (_, _, string, _) in
                if let svg = string {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    // FIXME: let more robust matches
                    let regex = NSRegularExpression(pattern: "data-count=\"(\\d+)\"\\s+data-date=\"(\\d+-\\d+-\\d+)\"", options: nil, error: nil)!
                    let matches = regex.matchesInString(svg, options: nil, range: NSMakeRange(0, svg.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))) as! [NSTextCheckingResult]
                    let data =  matches.flatMap { m -> [ContributionByDate] in
                        let count = (svg as NSString).substringWithRange(m.rangeAtIndex(1)).toInt()
                        let date = dateFormatter.dateFromString((svg as NSString).substringWithRange(m.rangeAtIndex(2)))
                        
                        if let count = count, let date = date {
                            return [(date: date, count: count)]
                        } else {
                            return []
                        }
                        }.sorted { (a: ContributionByDate, b: ContributionByDate) -> Bool in
                            a.date.compare(b.date) == .OrderedAscending
                    }
                    f(data)
                }
        }
    }
}