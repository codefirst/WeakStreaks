import Nimble
import Quick

class DayStreaksSpec : QuickSpec {
    override func spec() {
        describe("境界値") {
            let today = SpecHelper.date("2015-06-20")
            it("空の場合") {
                let metrics = DayStreaks(data: [])
                expect(metrics.call(today)).to(equal(0))
            }
            it("1つの場合") {
                let metrics = DayStreaks(data: [
                    (date: today, count: 1)
                ])
                expect(metrics.call(today)).to(equal(1))
            }
        }

        describe("毎日コミットしているならStreakが継続とみなす") {
            let metrics = DayStreaks(data: [
                (date: SpecHelper.date("2015-06-11"), count: 1),
                (date: SpecHelper.date("2015-06-12"), count: 0),
                (date: SpecHelper.date("2015-06-13"), count: 1),
                (date: SpecHelper.date("2015-06-14"), count: 1)
            ])

            it("その日は継続する") {
                expect(metrics.call(SpecHelper.date("2015-06-14"))).to(equal(2))
            }
        }

        describe("コミットが一日以上空くとStreakがとぎれる") {
            let metrics = DayStreaks(data: [
                (date: SpecHelper.date("2015-06-11"), count: 1),
                (date: SpecHelper.date("2015-06-12"), count: 0),
                (date: SpecHelper.date("2015-06-13"), count: 1),
                (date: SpecHelper.date("2015-06-14"), count: 0)
            ])

            it("翌になると継続が途切れる"){
                expect(metrics.call(SpecHelper.date("2015-06-14"))).to(equal(0))
            }
        }


    }
}
