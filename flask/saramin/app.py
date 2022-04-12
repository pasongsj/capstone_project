from flask import Flask, request, jsonify, g
#from flask_sqlalchemy import SQLAlchemy

from saramin_c import get_recruit #크롤링 파일 가져오기
from data_cleaning import recruit_count
from data_cleaning import get_job_to_stack
from data_cleaning import get_stack_to_stack
from db_form import recruit_db

import json



app = Flask(__name__)


#데이터 조회
@app.route('/recruit/new', methods = ['GET','POST'])
def recruit_new():
	a_recruit = get_recruit() #saramin crawling
	recruit_db(a_recruit)
	
	return {'commit': 'success'} 

#wanted 데이터 통계
@app.route('/wanted/count', methods = ['POST'])
def get_count():
	f = open('wanted_data.json', 'r')
	rdr = json.load(f)	
	count_data = recruit_count(rdr)
	f.close()
	#with open('count0405.json','w') as f:
	#	json.dump(count_data ,f,default=str,ensure_ascii=False)
	return count_data


@app.route('/wanted/JobToStack', methods = ['POST'])
def JobToStack():
	f = open('wanted_data.json', 'r')
	rdr = json.load(f)
	result = get_job_to_stack(rdr)
	f.close()
	#with open('JobToStack0405.json','w') as f:
	#	json.dump(result ,f,default=str,ensure_ascii=False)
	return result 


@app.route('/wanted/StackToStack', methods = ['POST'])
def StackToStack():
	f = open('wanted_data.json', 'r')
	rdr = json.load(f)
	result = get_stack_to_stack(rdr)
	f.close()
	#with open('StackToStack0405.json','w') as f:
	#	json.dump(result ,f,default=str,ensure_ascii=False)
	return result


if __name__ == "__main__":
	app.debug = True
	app.run()
