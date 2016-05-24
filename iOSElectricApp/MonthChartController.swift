//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class MonthChartController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var unit: LineChartView!
    @IBOutlet weak var bath: LineChartView!
    var textName = String()
    var calbath = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        let months = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"]
        
        let unitsSold = [0.0,0.0,0.0,400.0,350.7,0.0,0,0,0,0,0,0.0]

        var bathSold = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        
        //caculate bath
        var bath = 0.0
        for count in 0...unitsSold.count-1{
            for i in 0...Int(unitsSold[count]){
                if(i <= 5){
                    bath = 0
                }else if(i >= 6 && i <= 15){
                    bath = bath + 1.3576;
                }else if(i >= 16 && i <= 25){
                    bath = bath + 1.5445;
                }else if(i >= 26 && i <= 35){
                    bath = bath + 1.7968;
                }else if(i >= 36 && i <= 100){
                    bath = bath + 2.1800;
                }else if(i >= 101 && i <= 150){
                    bath = bath + 2.734;
                }else if(i >= 151 && i <= 400){
                    bath = bath + 2.7781;
                }else if(i>400){
                    bath = bath + 2.9780;
                }
            }
            if(unitsSold[count]<=150){
                bath = bath+8.19
            }else if(unitsSold[count]>150){
                bath = bath+40.90
            }
            bathSold[count]=bath
        }//end caculate
        setUnit(months, values: unitsSold)
        setBath(months, values: bathSold)
    }
    
    func setUnit(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Unit from Outlet Name: "+textName)
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        unit.data = lineChartData
    }
    func setBath(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Bath from Outlet Name: "+textName)
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        lineChartDataSet.circleColors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        bath.data = lineChartData
    }
}