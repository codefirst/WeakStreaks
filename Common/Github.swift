import Alamofire

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
}