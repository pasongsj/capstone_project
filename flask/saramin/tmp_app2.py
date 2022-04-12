from flask import Flask, request, jsonify
from saramin_c import get_recruit
from datetime import datetime

#db
import psycopg2
#from credentials import DATABASE as DB


app = Flask(__name__)
#api = Api(app)

#db = 


#데이터 조회
@app.route('/recruit', methods = ['GET','POST'])
def recruit():
	conn = psycopg2.connect("host = localhost dbname=recruit user=brown password=brown port=5432")
	cur = conn.cursor()
	a_recruit = get_recruit()

	for index, info in enumerate(a_recruit):
		idx = index
		companyName = info['company']
		recruitTitle = info['title']
		recruitCareer = info['career']
		recruitSchool = info['education']
		recruitCondition = info['employment_type']
		recruitLocation = info['workc_place']
		dueDate = info['deadline']
		if(dueDate == '채용시' or dueDate == '상시채'):
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
	return {'hello': 'world'} 
 
if __name__ == "__main__":
    app.run()
