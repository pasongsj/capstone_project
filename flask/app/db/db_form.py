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


def find_id(table, condit, compare, subid):
	
	conn = psycopg2.connect("host = localhost dbname=recruit user=brown password=brown port=5432")
	cur = conn.cursor()
	if subid == None:
		query = f"SELECT id FROM {table} WHERE {condit} = {compare}"
	else :
		query = f"SELECT COALESCE({subid}, id) FROM {table} WHERE {condit} = {compare}"
	cur.execute(query)
	(getid,) = cur.fetchone()
	conn.close()	
	return getid




def recruit_db(recruit_data): # save db
	conn = psycopg2.connect("host = localhost dbname=recruit user=brown password=brown port=5432")
	conn.autocommit = True
	cur = conn.cursor()
	recruit_query = """ INSERT INTO recruit (companyName, recruitTitle,recruitCareer,recruitSchool,recruitCondition,recruitLocation,dueDate,dueType,recruitCode,createdAt,updatedAt) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""

	techstack_query = """ INSERT INTO recruit_techstack (recruitid, techstackid) VALUES(%s,%s)"""
	task_query = """ INSERT INTO recruit_task (recruitid, taskid) VALUES(%s,%s)"""

	for info in recruit_data:
		data = get_data_value(info)
		cur.execute(recruit_query, data)
		tmp = int(info['idx'])
		row = find_id("Recruit", "recruitCode", tmp,None)

		if(len(info["stack"])>0):
			for estack in info["stack"]:
				stack_id = find_id("Techstack", "stackCode",estack,None)	
				cur.execute(techstack_query, (row,stack_id))

		if(len(info["task"])>0):
			for etask in info["task"]:
				task_id = find_id("Task", "taskCode",etask,"duplicateid")	
				cur.execute(task_query,(row,task_id))

	if conn:
		conn.close()
	return {'commit': 'success'}

def task_db(data): # save db

	conn = psycopg2.connect("host = localhost dbname=recruit user=brown password=brown port=5432")
	conn.autocommit = True
	cur = conn.cursor()
	task_query = """INSERT INTO tasktostack (id2, stack, num, createdAt) VALUES (%s, %s, %s, %s) """

	task_list = list(data.keys())
	for index,info in enumerate(data.values()):
		if(len(info)>0):
			for estack in info.keys():
				tmp = task_list[index]
				id2 = find_id("Task","taskCode",tmp,None)	
				stack = str(estack)
				num = int(info[stack])
				createdAt = datetime.datetime.utcnow()
				tmp_data = (id2, stack,num, createdAt)	
				cur.execute(task_query, tmp_data)

	conn.close()

	return {'commit': 'success'}

def stack_db(data):
	conn = psycopg2.connect("host = localhost dbname=recruit user=brown password=brown port=5432")
	conn.autocommit = True
	cur = conn.cursor()
	stack_query = """INSERT INTO stacktostack (id2,stack, innerstack, createdAt) VALUES (%s, %s, %s, %s) """

	for info in data.keys():
		id2 = find_id("Task","taskCode",info,None)	
		for main_stack in data[info]:
			for sub_stack in data[info][main_stack]:
				now = datetime.datetime.utcnow()
				tmp_data = (id2, main_stack, sub_stack,now)
				cur.execute(stack_query, tmp_data)

	conn.close()

	return {'commit': 'success'}


