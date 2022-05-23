//
//  LanguageChartCell.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/24.
//
import Charts
import UIKit

class LanguageChartCell: UITableViewCell {
    var lang:[String] = []
    var langCount:[Int] = []

    @IBOutlet weak var languagePieCharts: PieChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        pieLineCharts(dataPoints: lang, values: langCount)

        // Configure the view for the selected state
    }
    
    func pieLineCharts(dataPoints: [String], values: [Int]){
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: Double(values[i]), label: dataPoints[i], data:  dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries,label: "")
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor:dataPoints.count)
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
            
        // 4. Assign it to the chart's data
        languagePieCharts.data = pieChartData
        languagePieCharts.extraTopOffset = 0
        languagePieCharts.drawEntryLabelsEnabled = false
        }
        //파이차트 색상 만들기
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
