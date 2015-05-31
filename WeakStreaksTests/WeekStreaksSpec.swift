import Nimble
import Quick

class WeekStreaksSpec : QuickSpec {
    // テストデータに関するメモ
    //   第1週: 2015/5/31-2015/6/6
    //   第2週: 2015/6/7-2015/6/13
    //   第3週: 2015/6/14-2015/6/20
    //   第3週: 2015/6/21-2015/6/27
    override func spec() {

        describe("境界値") {
            let today = SpecHelper.date("2015-06-20")
            it("空の場合") {
                let metrics = WeekStreaks(data: [])
                expect(metrics.call(today).count).to(equal(0))
                expect(metrics.call(today).continued).to(equal(false))
            }
            it("1つの場合") {
                let metrics = WeekStreaks(data: [
                    (date: today, count: 1)
                ])
                expect(metrics.call(today).count).to(equal(1))
                expect(metrics.call(today).continued).to(equal(true))
            }
        }

        describe("週に1回以上コミットしているならStreakが継続とみなす") {
            let metrics = WeekStreaks(data: [
                // 第1週
                (date: SpecHelper.date("2015-05-31"), count: 1),

                // 第2週
                (date: SpecHelper.date("2015-06-07"), count: 1),
                (date: SpecHelper.date("2015-06-13"), count: 1),

                // 第3週
                (date: SpecHelper.date("2015-06-14"), count: 1)
            ])

            it("その週のうちは継続する") {
                expect(metrics.call(SpecHelper.date("2015-06-20")).count).to(equal(3))
                expect(metrics.call(SpecHelper.date("2015-06-20")).continued).to(equal(true))
            }
            
            it("翌日曜日はStreakは継続している数で取得するがその週で継続が途切れる状態になる") {
                expect(metrics.call(SpecHelper.date("2015-06-21")).count).to(equal(3))
                expect(metrics.call(SpecHelper.date("2015-06-21")).continued).to(equal(false))
            }
            
            it("翌週のうちはStreakは継続している数で取得するがその週で継続が途切れる状態になる") {
                expect(metrics.call(SpecHelper.date("2015-06-27")).count).to(equal(3))
                expect(metrics.call(SpecHelper.date("2015-06-27")).continued).to(equal(false))
            }
        }

        describe("週に1回以上コミットしないとStreakが継続がとぎれる") {
            let metrics = WeekStreaks(data: [
                // 第1週
                (date: SpecHelper.date("2015-05-31"), count: 1),

                // 第2週
                (date: SpecHelper.date("2015-06-07"), count: 1),
                (date: SpecHelper.date("2015-06-13"), count: 1),

                // 第3週
                (date: SpecHelper.date("2015-06-14"), count: 1),

                // 第4週
                (date: SpecHelper.date("2015-06-21"), count: 0),
                (date: SpecHelper.date("2015-06-22"), count: 0),

                // 第5週
                (date: SpecHelper.date("2015-06-28"), count: 0),
            ])

            it("翌々週になると継続が途切れる"){
                expect(metrics.call(SpecHelper.date("2015-06-28")).count).to(equal(0))
                expect(metrics.call(SpecHelper.date("2015-06-28")).continued).to(equal(false))
            }
        }
    }
}
