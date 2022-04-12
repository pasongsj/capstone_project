from flask import Flask, request, jsonify, g

import data.crawling_data
import cleaning.data_cleaning
import db.db_form
import json



app = Flask(__name__)


#데이터 조회
@app.route('/recruit/new', methods = ['POST'])
def recruit_new():
	a_recruit = data.crawling_data.get_recruit() #saramin crawling
	db.db_form.recruit_db(a_recruit)
	
	return {'commit': 'success'} 

#wanted 데이터 통계



@app.route('/Stacks/update', methods = ['POST'])
def Stack():
	f = open('raw_data.json', 'r')
	rdr = json.load(f)
	task_result = cleaning.data_cleaning.get_job_to_stack(rdr)
	db.db_form.task_db(task_result)	
	stack_result = cleaning.data_cleaning.get_stack_to_stack(rdr)
	db.db_form.stack_db(stack_result)
	f.close()

	return {'commit': 'success'} 


if __name__ == "__main__":
	app.debug = True
	app.run()
