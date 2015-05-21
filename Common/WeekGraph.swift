import UIKit

// 今週のコントリビューショングラフを作る
class WeekGraph {
    private let data : [Int]

    // 画面のサイズ
    let Width : CGFloat = 300
    let Height : CGFloat = 300

    // バーの幅
    let BarWidth : CGFloat = 20

    // 左からの距離
    let LeftPadding : CGFloat = 35
    let BottomPadding : CGFloat = 20

    // バー間の距離
    let Margin : CGFloat = 15

    // 最大値
    let DataMax = 15

    init(data : [Int]) {
        self.data = data
    }

    func draw() -> UIImage {
        let unit = (Height - BottomPadding) / CGFloat(DataMax)

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(Width, Height), false, 1.0)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.5, 1.0)
        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.5, 1.0)
        CGContextSetLineWidth(context, 2.0)

        // データをプロットする
        for (x, v) in enumerate(data) {
            let y = CGFloat(DataMax - v) * unit
            let r1 = CGRectMake(CGFloat(x) * (BarWidth + Margin) + LeftPadding, y , BarWidth, Height - BottomPadding - y)
            CGContextAddRect(context,r1)
        }
        CGContextFillPath(context)

        // 罫線を引く
        CGContextMoveToPoint(context, 10, Height - BottomPadding)
        CGContextAddLineToPoint(context, Width - 10, Height - BottomPadding)
        CGContextStrokePath(context)

        // TODO: ラベルを描画する。


        // 画像を生成する
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}