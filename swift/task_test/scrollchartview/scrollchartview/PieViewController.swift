//
//  PieViewController.swift
//  scrollchartview
//
//  Created by Sujeong Lee on 2022/05/15.
//

import UIKit
import Charts
//import Then


class PieChartViewController: UIViewController {
    

    
    @IBOutlet weak var pieChartView: PieChartView!
    let players = ["AWS", "API", "JAVA", "Spring", "NodeJS"]
    let goals = [102,88,45,14,8]
    
    override func viewDidLoad() {
          super.viewDidLoad()
          
          customizeChart(dataPoints: players, values: goals.map{ Double($0) })
        
        }
        
        func customizeChart(dataPoints: [String], values: [Double]) {
          
          // 1. Set ChartDataEntry
          var dataEntries: [ChartDataEntry] = []
          for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
          }
          
          // 2. Set ChartDataSet
            let pieChartDataSet = PieChartDataSet(entries: dataEntries)
          pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
          
          // 3. Set ChartData
          let pieChartData = PieChartData(dataSet: pieChartDataSet)
          let format = NumberFormatter()
          format.numberStyle = .none
          let formatter = DefaultValueFormatter(formatter: format)
          pieChartData.setValueFormatter(formatter)
          // 하단 라벨 지우기
            pieChartView.legend.enabled = false
          
          // 4. Assign it to the chart's data
          pieChartView.data = pieChartData
        }
        
        private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
          var colors: [UIColor] = []
          for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
          }
          return colors
        }
    
    
    

    }

