//
//  Graph.swift
//  HackDukeApp
//
//  Created by Andy Kotz on 12/11/20.
//

import Foundation
import Charts

class Graph {
    var dataEntries: [BarChartDataEntry] = []
    var dataList: [Int] = [Int]()
    init(data: [Int]) {
        dataList = data
    }
    
    func graphData() {
        for i in 0..<dataList.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataList[i]))
            dataEntries.append(dataEntry)
        }
    }
}
