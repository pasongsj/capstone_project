from flask import Flask, request, jsonify, g

#from wanted_c import get_wanted_info #크롤링 파일 가져오기
from data_cleaning import recruit_count
from data_cleaning import get_job_to_stack
from data_cleaning import get_stack_to_stack

#import datetime
#from datetime import timedelta
#import psycopg2
import json

app = Flask(__name__)



@app.route('/wanted/count', methods = ['POST'])
def get_count():
	f = open('wanted_data.json', 'r')
	rdr = json.load(f)	
	count_data = recruit_count(rdr)
	f.close()
	with open('count0405.json','w') as f:
		json.dump(count_data ,f,default=str,ensure_ascii=False)
	return count_data


@app.route('/wanted/JobToStack', methods = ['POST'])
def JobToStack():
	f = open('wanted_data.json', 'r')
	rdr = json.load(f)
	result = get_job_to_stack(rdr)
	f.close()
	with open('JobToStack0405.json','w') as f:
		json.dump(result ,f,default=str,ensure_ascii=False)
	return result 


@app.route('/wanted/StackToStack', methods = ['POST'])
def StackToStack():
	f = open('wanted_data.json', 'r')
	rdr = json.load(f)
	result = get_stack_to_stack(rdr)
	f.close()
	with open('StackToStack0405.json','w') as f:
		json.dump(result ,f,default=str,ensure_ascii=False)
	return result

if __name__ == "__main__":
	app.debug = True
	app.run()

