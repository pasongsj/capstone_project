from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy


from saramin_c import get_recruit #크롤링 파일 가져오기
from datetime import datetime


import psycopg2

app = Flask(__name__)
#api = Api(app)


#데이터 조회
@app.route('/recruit', methods = ['GET','POST'])
def recruit():
	a_recruit = get_recruit()
	db(a_recruit)
	return {'commit': 'success'} 

def db(recruit_data):
	conn = psycopg2.connect("host = localhost dbname=recruit user=brown password=brown port=5432")
	cur = conn.cursor()
	postgres_insert_query = """ INSERT INTO test (id, companyName, recruitTitle,recruitCareer,recruitSchool,recruitCondition,recruitLocation,dueDate,dueType,recruitCode,createdAt,updatedAt) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""


	for index, info in enumerate(recruit_data):
		idx = index
		companyName = info['company']
		recruitTitle = info['title']
		recruitCareer = info['career']
		recruitSchool = info['education']
		recruitCondition = info['employment_type']
		recruitLocation = info['workc_place']
		dueDate = info['deadline']
		if(dueDate == '채용시' or dueDate == '상시채용'):
			dueType = 0
			dueDate = None
		else:
			dueType = 1
		recruitCode = int(info['idx'])
		createdAt = datetime.utcnow()
		updatedAt = datetime.utcnow()
		data = (idx, companyName, recruitTitle,recruitCareer,recruitSchool,recruitCondition,recruitLocation,dueDate,dueType,recruitCode,createdAt,updatedAt)
		cur.execute(postgres_insert_query, data)
	cur.execute("SELECT * FROM test")
	rows = cur.fetchall()
	conn.commit()
	conn.close()

	return {'commit': 'success'} 



if __name__ == "__main__":
    app.run()
