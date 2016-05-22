//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class LineChartController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var unit: LineChartView!
    @IBOutlet weak var bath: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setUnit(months, values: unitsSold)
        setBath(months, values: unitsSold)
        
    }
    
    func setUnit(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Unit")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        unit.data = lineChartData
    }
    func setBath(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Bath")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        bath.data = lineChartData
    }
}