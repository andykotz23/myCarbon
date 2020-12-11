//
//  LineTableViewController.swift
//  HackDukeApp
//
//  Created by Andy Kotz on 12/11/20.
//

import UIKit
import Charts

class LineTableViewController: UITableViewController, ChartViewDelegate {
    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        lineChart.center = view.center
        view.addSubview(lineChart)
        var entries = [ChartDataEntry]()
        let dataList = Total.dataList
        for i in 0...dataList.count - 1 {
            
            entries.append(ChartDataEntry(x: Double(i), y: Double(dataList[i])))
                
            }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
