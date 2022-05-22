//
//  nextViewController.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/20.
//

import UIKit
import Charts
class nextViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var barChartView2: HorizontalBarChartView!
    
    @IBOutlet weak var buttonTableView1: UITableView!
    
    var task: [String] = ["1","2",
                          "3","4",
                          "백엔드/서버개발","보안컨설팅",
                          "앱개발","웹개발",
                          "웹마스터","유지보수",
                          "정보보안","퍼블리셔"]
    var task_count: [Double] = [184,178,
                                153,104,
                                101,100,
                                99,98,
                                97,95,
                                92,88]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarChart(dataPoints: task, values: task_count.reversed())
        buttonTableView1.delegate = self
        buttonTableView1.dataSource = self

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowDetail2" {
                let vc = segue.destination as? Stack1ViewController
                if let first_index = sender as? Int {
                    //vc?.numOfpage = first_index
                    vc?.taskName = task[first_index]
                    //print(first_index, task[first_index])
                }
            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = buttonTableView1.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        //cell2.textLabel?.text = ">"//String(indexPath.row + 1)
        return cell2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "ShowDetail2", sender: indexPath.row)
        }
    
    
    func setBarChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        //for i in 0..<dataPoints.count {
        for  i in (0..<dataPoints.count){//}.reversed(){
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
        
        barChartView2.data = chartData
        //view 배경
        barChartView2.backgroundColor = UIColor(displayP3Red: 102/255, green: 103/255, blue: 171/255, alpha: 0.3)
        //view radius
        barChartView2.layer.cornerRadius = 15
        barChartView2.layer.masksToBounds = true
        
        // 줌 안되게
        barChartView2.doubleTapToZoomEnabled = false
        
        //task명 왼쪽 정렬
        barChartView2.xAxis.labelPosition = .bottomInside
        
        //이름 task지정
        barChartView2.xAxis.valueFormatter = IndexAxisValueFormatter(values: task.reversed())
        // task명 폰트 크기
        barChartView2.xAxis.labelFont = UIFont.systemFont(ofSize: 20)
        // task명 글자 색상
        barChartView2.xAxis.labelTextColor = .white
        
        //애니메이션
        barChartView2.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        //격자, 선 제거
        //윗줄
        barChartView2.leftAxis.enabled = false
        //아랫줄 제거
        barChartView2.rightAxis.enabled = false
        //가로 줄 제거
        barChartView2.xAxis.drawGridLinesEnabled = false
        //세로 줄 제거
        barChartView2.rightAxis.drawGridLinesEnabled = false
        barChartView2.leftAxis.drawAxisLineEnabled = false
        //시작위치 조절
        //barChartView.extraTopOffset = 30

//        // X축 레이블 갯수 최대로 설정
        barChartView2.xAxis.setLabelCount(dataPoints.count, force: false)
        // 하단 라벨 지우기
        barChartView2.legend.enabled = false

        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
