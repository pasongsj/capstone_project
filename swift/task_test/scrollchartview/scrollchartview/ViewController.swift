//
//  ViewController.swift
//  scrollchartview
//
//  Created by Sujeong Lee on 2022/05/10.
//

import UIKit
import Charts
let REUSE_IDENTIFIER = "YourCustomID"
//@MainActor protocol UIScrollViewDelegate

class ViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var barChartView: HorizontalBarChartView!
    
    @IBOutlet weak var tableView: UITableView!
    let cellName:String = "customCell"

    

    
    var task: [String]!
    var task_count: [Double]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        task = ["게임개발","기술지원","데이터분석가","데이터엔지니어","백엔드/서버개발","보안컨설팅","앱개발","웹개발","웹마스터","유지보수","정보보안","퍼블리셔","프론트엔드","DBA","GM(게임운영)","IT컨설팅","QA/테스터","SE(시스템엔지니어)","SI개발","AI(인공지능)","네트워크","H/W","임베디드",".NET"]
        task_count = [80,81,82,83,84,
                      85,86,87,88,89,
                      90,91,92,95,97,
                      98,99,100,101,101,
                      104,153,178,184]
        
       // setBarChart(dataPoints: task, values: task_count.map{ $0.x == xValue })
        //self.setup(barLineChartView: barChartView)
        barChartView.delegate = self
        //tableView.delegate = self
        //tableView.dataSource = self
        
  
        //nodata
        barChartView.noDataText = "오류"
        
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray
        
        setBarChart(dataPoints: task, values: task_count)
        //self.barChartView.delegate = self

        
    }

    
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Bar selected")
    }
    
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
    print("chartValueNothingSelected")
    }
    


    //MARK: Set chart
    func setBarChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        //for i in 0..<dataPoints.count {
        for  i in (0..<dataPoints.count).reversed(){
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries)//, label: "직무")
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        
        // 차트 컬러
        //chartDataSet.colors = [.systemBlue]
        chartDataSet.colors = [UIColor(displayP3Red: 102/255, green: 103/255, blue: 171/255, alpha: 1)]
        
        // 선택 안되게
        //chartDataSet.highlightEnabled = false
        
        //바차트 width
       // chartData.barWidth = 0.6
        
        barChartView.data = chartData
        
        //view 배경
        barChartView.backgroundColor = UIColor(displayP3Red: 102/255, green: 103/255, blue: 171/255, alpha: 0.3)
        //view radius
        barChartView.layer.cornerRadius = 15
        barChartView.layer.masksToBounds = true
        
        // 줌 안되게
        barChartView.doubleTapToZoomEnabled = false
        
        //task명 왼쪽 정렬
        barChartView.xAxis.labelPosition = .bottomInside
        
        //이름 task지정
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: task.reversed())
        // task명 폰트 크기
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 20)
        // task명 글자 색상
        barChartView.xAxis.labelTextColor = .white
        
        //애니메이션
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        //격자, 선 제거
        //윗줄
        barChartView.leftAxis.enabled = false
        //아랫줄 제거
        barChartView.rightAxis.enabled = false
        //가로 줄 제거
        barChartView.xAxis.drawGridLinesEnabled = false
        //세로 줄 제거
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        //시작위치 조절
        barChartView.extraTopOffset = 30

//        // X축 레이블 갯수 최대로 설정
        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        // 하단 라벨 지우기
        barChartView.legend.enabled = false

        }


    
}

/*
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return task_count.count
    }
   
}*/
