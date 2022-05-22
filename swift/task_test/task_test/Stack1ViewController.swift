//
//  Stack1ViewController.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/19.
//

import UIKit
import Charts

class Stack1ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskNametitle: UILabel!

    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var detailTableView: UITableView!
    

    
    var numOfpage: Int?//데이터 전달 체크용
    var taskName:String? //체크용
    
    let detailStacks = ["AWS", "API", "JAVA", "Spring", "NodeJS"]
    let detailStacksCount = [102,88,45,14,8]
    let detailS = [["msa","kuberntes","docker"],["resful","framework","nodejs"],["jpa","orm","mysql"],["java","jpa","tmp"],["werver","backend","design"]]
    let customColors: [UIColor] = [.systemRed,.systemYellow,.systemGreen,.systemBlue,.black
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeChart(dataPoints: detailStacks, values: detailStacksCount.map{ Double($0) })
        updateUI()//데이터 받는지 체크용
        detailTableView.delegate = self
        detailTableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailStacks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailcell = detailTableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath) as! DetailStackTableViewCell
        detailcell.detailMainTask.text = detailStacks[indexPath.row]
        detailcell.circle.tintColor=customColors[indexPath.row]
        detailcell.detailS1.text = detailS[indexPath.row][0]
        detailcell.detailS2.text = detailS[indexPath.row][1]
        detailcell.detailS3.text = detailS[indexPath.row][2]
        return detailcell
    }
    
    func updateUI() {
        /*if let numOfpage = numOfpage {
                tmplabel.text =  "\(numOfpage + 1) page"
            }*/
        if let taskName = taskName{
            taskNametitle.text = taskName
        }
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
        pieChartView.extraTopOffset = 0
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        /*
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }*/
      return customColors
    }


    

}
