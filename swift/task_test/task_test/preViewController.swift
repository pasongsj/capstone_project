//
//  preViewController.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/18.
//

import UIKit
import Charts

class preViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {//, ChartViewDelegate{
    @IBOutlet weak var buttonTableView1: UITableView!
    
    @IBOutlet var barChartView1: HorizontalBarChartView!
    let cellName:String = "customCell"
    
    var task: [String] = ["게임개발","기술지원",
                          "데이터분석가","데이터엔지니어",
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
       // barChartView.delegate = self
        setBarChart(dataPoints: task, values: task_count.reversed())
        buttonTableView1.delegate = self
        buttonTableView1.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowDetail" {
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
        let cell = buttonTableView1.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = ">"//String(indexPath.row + 1)
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "ShowDetail", sender: indexPath.row)
        }
    
    
    func setBarChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        //for i in 0..<dataPoints.count {
        for  i in (0..<dataPoints.count){
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
        
        barChartView1.data = chartData
        //view 배경
        barChartView1.backgroundColor = UIColor(displayP3Red: 102/255, green: 103/255, blue: 171/255, alpha: 0.3)
        //view radius
        barChartView1.layer.cornerRadius = 15
        barChartView1.layer.masksToBounds = true
        
        // 줌 안되게
        barChartView1.doubleTapToZoomEnabled = false
        
        //task명 왼쪽 정렬
        barChartView1.xAxis.labelPosition = .bottomInside
        
        //이름 task지정
        barChartView1.xAxis.valueFormatter = IndexAxisValueFormatter(values: task.reversed())
        // task명 폰트 크기
        barChartView1.xAxis.labelFont = UIFont.systemFont(ofSize: 20)
        // task명 글자 색상
        barChartView1.xAxis.labelTextColor = .white
        
        //애니메이션
        barChartView1.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        //격자, 선 제거
        //윗줄
        barChartView1.leftAxis.enabled = false
        //아랫줄 제거
        barChartView1.rightAxis.enabled = false
        //가로 줄 제거
        barChartView1.xAxis.drawGridLinesEnabled = false
        //세로 줄 제거
        barChartView1.rightAxis.drawGridLinesEnabled = false
        barChartView1.leftAxis.drawAxisLineEnabled = false
        //시작위치 조절
        //barChartView.extraTopOffset = 30

//        // X축 레이블 갯수 최대로 설정
        barChartView1.xAxis.setLabelCount(dataPoints.count, force: false)
        // 하단 라벨 지우기
        barChartView1.legend.enabled = false

        
        
    }
/*    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Bar selected")
    }
    */
/*
}
extension preViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = buttonTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! stackTableViewCell
        // cell.stackbutton.tag = indexPath.row
         // cell.stackbutton.addTarget(self, action: #selector(addtoButton), for: .touchUpInside)
        return cell
        
    }
    
    @objc func addtoButton(sender:UIButton){
        let indexpath1 = IndexPath(row:sender.tag,section: 0)
        tmp2 = task[indexpath1.row]
        let home = self.storyboard?.instantiateViewController(withIdentifier: "StackViewController") as! StackViewController
        self.navigationController?.pushViewController(home, animated: true)
        
    }
    
    */
}

