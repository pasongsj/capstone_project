//
//  CommitChartCell.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/23.
//

import UIKit
import Charts

class CommitChartCell: UITableViewCell {

    @IBOutlet weak var commitLineCharts: LineChartView!
    
    @IBOutlet weak var currCommitView: UIView!
    
    @IBOutlet weak var currCommitLabel: UILabel!
    
    @IBOutlet weak var changedCommitView: UIView!
    
    @IBOutlet weak var chagnedCommitLabel: UILabel!
    
    var monthlyCommitCount: [Int] = []

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewCustom()
        setLineCharts(numbers:monthlyCommitCount)
        customLineCharts()

        // Configure the view for the selected state
    }
    func viewCustom(){
        currCommitView.layer.borderColor = UIColor.systemGray3.cgColor
        currCommitView.layer.borderWidth = 1
        currCommitView.layer.cornerRadius = 10
        currCommitView.layer.masksToBounds = true
        
        changedCommitView.layer.borderColor = UIColor.systemGray3.cgColor
        changedCommitView.layer.borderWidth = 1
        changedCommitView.layer.cornerRadius = 10
        changedCommitView.layer.masksToBounds = true
        
    }
    
       //라인차트 function
    func setLineCharts(numbers: [Int]){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<numbers.count{
            let value = ChartDataEntry(x:Double(i),y:Double(numbers[i]))
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(entries:lineChartEntry)
        let LchartDataSet = LineChartData(dataSet:line1)
        
        commitLineCharts.data = LchartDataSet
    }
       //라인차트 격자 지우기 function
    func customLineCharts(){
        commitLineCharts.doubleTapToZoomEnabled = false
           //commitLineCharts.leftAxis.enabled = false
        commitLineCharts.rightAxis.enabled = false
        commitLineCharts.xAxis.drawGridLinesEnabled = false
        commitLineCharts.leftAxis.drawGridLinesEnabled = false
        commitLineCharts.leftAxis.drawLabelsEnabled = false
        commitLineCharts.rightAxis.drawGridLinesEnabled = false
           //commitLineCharts.xAxis.drawAxisLineEnabled = false
        commitLineCharts.xAxis.labelPosition = XAxis.LabelPosition.bottom
     
        commitLineCharts.xAxis.drawLabelsEnabled = false
        commitLineCharts.legend.enabled = false
        //commitLineCharts.chartDescription?.text = " "
           
    }


}
