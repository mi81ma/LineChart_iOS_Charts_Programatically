//
//  ViewController.swift
//  LineChart_iOS_Charts_Programatically
//
//  Created by masato on 23/1/2019.
//  Copyright © 2019 masato. All rights reserved.
//


import UIKit
import Charts

class ViewController: UIViewController {

//======== 01. Chart Var setting =========

//    var chart: CandleStickChartView!
//    var candleDataSet: CandleChartDataSet!


    var chart02: LineChartView!
    var chart02DataSet: LineChartDataSet!

//========================================



    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func  viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//================= 02. Chart View setting ===================
//        // CandleStick Chart Instance
//        var candleStickData = CandleChartData()
//
//        //結合グラフに線グラフのデータ読み出し
//        //Data readout of line graph on connected graph
//        candleStickData = setGraph()
//
//        chart = CandleStickChartView(frame: CGRect(x: 0, y: view.safeAreaInsets.bottom, width: view.frame.width, height: 500))
//        chart.data = candleStickData
//        self.view.addSubview(chart)




        let lineChartData = setLineGraph()

        chart02 = LineChartView(frame: CGRect(x: 0, y: view.safeAreaInsets.bottom, width: view.frame.width, height: 500))
        chart02.data = lineChartData

        // Y軸の最小値の設定
        chart02.leftAxis.axisMinimum = 0

//        // Y軸の最大値の設定
//        chart02.leftAxis.axisMaximum = 50
        self.view.addSubview(chart02)

    }

//==========================================================

    func setLineGraph() -> LineChartData {

        // 01 Prepare Data Array
        var bidsDataEntries: [ChartDataEntry] = Array()
        var asksDataEntries: [ChartDataEntry] = Array()

        // 02 Input Data Set

        // Delete ", []", before JSONDecoding
        let data02 = data.replacingOccurrences(of: ", []", with: "")

        let data03 = data02.data(using: .utf8)!
        let depth = try! JSONDecoder().decode(Depth.self, from: data03)

        // Change String to Double
        let bidsArrayDouble: [[Double]] = depth.bids.map{$0.map{Double($0)!}}
        let asksArrayDoule = depth.asks.map{$0.map{Double($0)!}}

        var bidsIntegration:Double = 0
        var asksIntegration:Double = 0

        var bidsArrayDouble02 = [[Double]]()
        var asksArrayDouble02 = [[Double]]()


        // Bid Integrate Calculation
        for arrBid in bidsArrayDouble {
            let bidIntegrating = arrBid[1] + bidsIntegration
            bidsArrayDouble02.append([arrBid[0], bidIntegrating])
            bidsIntegration = bidIntegrating
        }

        // Reverse [[Double]] data
        let bidsArrayDouble03 = bidsArrayDouble02.reversed()


        // Ask Integrate Calculation
        for arrAsk in asksArrayDoule {
            let askIntegrating = arrAsk[1] + asksIntegration
            asksArrayDouble02.append([arrAsk[0], askIntegrating])
            asksIntegration = askIntegrating
        }


        // Double Data set into DataEntries
        for arr in bidsArrayDouble03 {
           bidsDataEntries.append(ChartDataEntry(x: arr[0], y: arr[1]))
        }

        for arr in asksArrayDouble02 {
            asksDataEntries.append(ChartDataEntry(x: arr[0], y: arr[1]))
        }


        //dataset & Label Name
        let bidsDataSet = LineChartDataSet(values: bidsDataEntries, label: "bid")
        let astksDataSet = LineChartDataSet(values: asksDataEntries, label: "ask")

        //delete Circles
        bidsDataSet.drawCirclesEnabled = false
        astksDataSet.drawCirclesEnabled = false

        bidsDataSet.setColor(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
        astksDataSet.setColor(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))

        print(bidsDataSet)
        print(astksDataSet)


        return LineChartData(dataSets: [bidsDataSet, astksDataSet])
    }



    let data = """
{
"lastUpdateId": 405346152,
"bids": [
["0.03295000", "13.88700000", []],
["0.03294600", "0.68300000", []],
["0.03294000", "0.03000000", []],
["0.03293500", "42.28000000", []],
["0.03293100", "4.43100000", []],
["0.03293000", "37.57200000", []],
["0.03291700", "0.10800000", []],
["0.03291600", "1.52300000", []],
["0.03291500", "30.24100000", []],
["0.03291200", "0.03100000", []],
["0.03291100", "25.17600000", []],
["0.03291000", "25.71800000", []],
["0.03290900", "25.00000000", []],
["0.03290000", "86.95500000", []],
["0.03289900", "0.90000000", []],
["0.03289700", "0.06700000", []],
["0.03289600", "0.23700000", []],
["0.03289500", "0.73400000", []],
["0.03289400", "0.15800000", []],
["0.03289300", "0.12200000", []],
["0.03289100", "5.08000000", []],
["0.03289000", "0.20000000", []],
["0.03288900", "0.04600000", []],
["0.03288600", "9.10500000", []],
["0.03288500", "2.44500000", []],
["0.03288400", "8.05600000", []],
["0.03288300", "49.03400000", []],
["0.03288100", "2.31500000", []],
["0.03288000", "2.30200000", []],
["0.03287800", "0.03100000", []],
["0.03287600", "6.10300000", []],
["0.03287500", "0.03500000", []],
["0.03287300", "1.29800000", []],
["0.03287200", "3.04100000", []],
["0.03286900", "1.37000000", []],
["0.03286800", "15.21200000", []],
["0.03286500", "0.50000000", []],
["0.03286000", "2.41700000", []],
["0.03285800", "0.99600000", []],
["0.03285700", "0.17400000", []],
["0.03285600", "0.13100000", []],
["0.03285500", "2.53300000", []],
["0.03285300", "18.83600000", []],
["0.03285200", "1.53300000", []],
["0.03285100", "12.01500000", []],
["0.03285000", "915.68700000", []],
["0.03284700", "0.04600000", []],
["0.03284300", "0.04400000", []],
["0.03284200", "0.04900000", []],
["0.03284100", "0.42600000", []]
],
"asks": [
["0.03295300", "2.23000000", []],
["0.03295500", "1.06800000", []],
["0.03295600", "4.00000000", []],
["0.03295800", "10.00000000", []],
["0.03296500", "10.00000000", []],
["0.03296700", "0.55700000", []],
["0.03296800", "0.73900000", []],
["0.03296900", "0.23600000", []],
["0.03297000", "41.41200000", []],
["0.03297300", "29.23500000", []],
["0.03297500", "0.54700000", []],
["0.03297700", "0.18500000", []],
["0.03298100", "8.90500000", []],
["0.03298200", "15.17600000", []],
["0.03298300", "1.82300000", []],
["0.03298600", "0.03200000", []],
["0.03298700", "0.85300000", []],
["0.03299300", "28.28200000", []],
["0.03299800", "17.37400000", []],
["0.03299900", "0.63200000", []],
["0.03300000", "3.94300000", []],
["0.03300200", "55.55600000", []],
["0.03300300", "9.10600000", []],
["0.03300400", "17.03400000", []],
["0.03300500", "2.09100000", []],
["0.03300600", "25.00000000", []],
["0.03300700", "0.03100000", []],
["0.03300900", "6.07000000", []],
["0.03301000", "5.59900000", []],
["0.03301200", "20.00000000", []],
["0.03301300", "0.12600000", []],
["0.03301800", "4.76900000", []],
["0.03302000", "14.95400000", []],
["0.03302300", "0.16000000", []],
["0.03302600", "5.02800000", []],
["0.03302700", "0.45600000", []],
["0.03303000", "1.00000000", []],
["0.03303600", "5.49900000", []],
["0.03303700", "2.48600000", []],
["0.03303800", "11.50500000", []],
["0.03303900", "2.00000000", []],
["0.03304300", "0.09100000", []],
["0.03304400", "0.65600000", []],
["0.03304900", "0.03500000", []],
["0.03305000", "45.50200000", []],
["0.03305300", "0.45200000", []],
["0.03305400", "0.51800000", []],
["0.03305500", "1.82400000", []],
["0.03305700", "3.60000000", []],
["0.03306800", "14.97000000", []]
]
}
"""

}


struct Depth : Codable {
    var lastUpdateId : Int
    var bids : [[String]]
    var asks : [[String]]
}
