//
//  BarTableViewController.swift
//  HackDukeApp
//
//  Created by Andy Kotz on 12/11/20.
//

import UIKit
import Charts

class BarTableViewController: UITableViewController, ChartViewDelegate {
    var barChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        barChart.center = view.center
        view.addSubview(barChart)
        var entries = [BarChartDataEntry]()
        let dataList = Total.dataList
        for i in 0...dataList.count - 1 {
            
            entries.append(BarChartDataEntry(x: Double(i), y: Double(dataList[i])))
                
            }
        
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
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
