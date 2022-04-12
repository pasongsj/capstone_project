from flask import Flask, request, jsonify, g
#from flask_sqlalchemy import SQLAlchemy

from saramin_c import get_recruit #크롤링 파일 가져오기
from data_cleaning import recruit_count
from data_cleaning import get_job_to_stack
from data_cleaning import get_stack_to_stack

import datetime
import json
from datetime import timedelta
import psycopg2

def get_data_value(num,obj):#insert into 에 사용할 value 생성
	companyName = obj['company']
	recruitTitle = obj['title']
	recruitCareer = obj['career']
	recruitSchool = obj['education']
	recruitCondition = obj['employment_type']
	recruitLocation = obj['workc_place']
	dueDate = obj['deadline']
	if(dueDate == '채용시' or dueDate == '상시채용'):
		dueType = 0
		dueDate = None
	elif(dueDate =='내일마감'):
		dueType = 1
		d = datetime.date.today()+ timedelta(days=1)
		t = datetime.time(14,59,59)
		dueDate = datetime.datetime.combine(d, t)
	elif(dueDate == '오늘마감'):
		duteType = 1
		d = datetime.date.today()
		t = datetime.time(14,59,59)
		dueDate = datetime.datetime.combine(d, t)

	else:
		dueType = 1
	recruitCode = int(obj['idx'])
	createdAt = datetime.datetime.utcnow()
	updatedAt = datetime.datetime.utcnow()
	data = (num, companyName, recruitTitle,recruitCareer,recruitSchool,recruitCondition,recruitLocation,dueDate,dueType,recruitCode,createdAt,updatedAt)
	return data

def db(recruit_data): # save db
	conn = psycopg2.connect("host = localhost dbname=recruit user=brown password=brown port=5432")
	cur = conn.cursor()
	postgres_insert_query = """ INSERT IGNORE INTO test2 (id, companyName, recruitTitle,recruitCareer,recruitSchool,recruitCondition,recruitLocation,dueDate,dueType,recruitCode,createdAt,updatedAt) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""


	for index, info in enumerate(recruit_data):
		data = get_data_value(index,info)
		cur.execute(postgres_insert_query, data)
	cur.execute("SELECT * FROM test")
	rows = cur.fetchall()
	conn.commit()
	conn.close()

	return {'commit': 'success'} 


app = Flask(__name__)


#데이터 조회
@app.route('/recruit/new', methods = ['GET','POST'])
def recruit_new():
	a_recruit = get_recruit() #saramin crawling
	db(a_recruit)
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
