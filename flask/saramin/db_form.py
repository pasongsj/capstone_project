import psycopg2

import datetime

def get_data_value(obj):#insert into 에 사용할 value 생성
	cName = obj['company']
	rTitle = obj['title']
	rCareer = obj['career']
	rSchool = obj['education']
	rCondition = obj['employment_type']
	rLocation = obj['workc_place']
	dDate = obj['deadline']
	if(dDate == '채용시'):
		dType = 1
		dDate = None
	elif(dDate == '상시채용'):
		dType = 2
		dDate = None
	else:
		dType = 0
		if(dDate =='내일마감'):
			d = datetime.date.today()+ datetime.timedelta(days=1)
			t = datetime.time(14,59,59)
			dDate = datetime.datetime.combine(d, t)
		elif(dDate == '오늘마감'):
			d = datetime.date.today()
			t = datetime.time(14,59,59)
			dDate = datetime.datetime.combine(d, t)


	rCode = int(obj['idx'])
	cAt = datetime.datetime.utcnow()
	uAt = datetime.datetime.utcnow()
	data = (cName, rTitle,rCareer,rSchool,rCondition,rLocation,dDate,dType,rCode,cAt,uAt)
	return data




def recruit_db(recruit_data): # save db
	conn = psycopg2.connect("host = localhost dbname=recruit user=brown password=brown port=5432")
	cur = conn.cursor()
	recruit_query = """ INSERT INTO recruit (companyName, recruitTitle,recruitCareer,recruitSchool,recruitCondition,recruitLocation,dueDate,dueType,recruitCode,createdAt,updatedAt) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""

	techstack_query = """ INSERT INTO recruit_techstack (recruitid, techstackid) VALUES(%s,%s)"""
	task_query = """ INSERT INTO recruit_task (recruitid, taskid) VALUES(%s,%s)"""

	for info in recruit_data:
		data = get_data_value(info)
		cur.execute(recruit_query, data)
		cur.execute("SELECT max(id) from recruit")
		(row,) = cur.fetchone()

		if(len(info["stack"])>0):
			for estack in info["stack"]:
				tmp_data = (int(row),int(estack))
				cur.execute(techstack_query, tmp_data)

		if(len(info["task"])>0):
			for etask in info["task"]:
				tmp_data = (int(row),int(etask))
				cur.execute(task_query,tmp_data)
		
		
	conn.commit()
	conn.close()

	return {'commit': 'success'} 
