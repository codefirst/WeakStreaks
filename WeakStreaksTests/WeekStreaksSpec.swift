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
                expect(metrics.call(today)).to(equal(0))
            }
            it("1つの場合") {
                let metrics = WeekStreaks(data: [
                    (date: today, count: 1)
                ])
                expect(metrics.call(today)).to(equal(1))
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
                expect(metrics.call(SpecHelper.date("2015-06-20"))).to(equal(3))
            }

            it("翌日曜日はStreakが継続している") {
                expect(metrics.call(SpecHelper.date("2015-06-21"))).to(equal(3))
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
                expect(metrics.call(SpecHelper.date("2015-06-28"))).to(equal(0))
            }
        }
    }
}
