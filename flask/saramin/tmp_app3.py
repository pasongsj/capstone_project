from flask import Flask, request, jsonify
from saramin_c import get_recruit
from datetime import datetime

#db 
import psycopg2
#from credentials import DATABASE as DB


app = Flask(__name__)
#api = Api(app)


class Databases():
    def __init__(self):
        self.db = psycopg2.connect("host = localhost dbname=recruit user=brown password=brown port=5432")
        self.cursor = self.db.cursor()

    def __del__(self):
        self.db.close()
        self.cursor.close()

    def execute(self,query,args={}):
        self.cursor.execute(query,args)
        row = self.cursor.fetchall()
        return row

    def commit(self):
        self.cursor.commit()


############


#from . import Databases

class CRUD(Databases):
    def insertDB(self,schema,table,colum,data):
        sql = " INSERT INTO {schema}.{table}({colum}) VALUES ('{data}') ;".format(schema=schema,table=table,colum=colum,data=data)
        try:
            self.cursor.execute(sql)
            self.db.commit()
        except Exception as e :
            print(" insert DB err ",e) 
    
    def readDB(self,schema,table,colum):
        sql = " SELECT {colum} from {schema}.{table}".format(colum=colum,schema=schema,table=table)
        try:
            self.cursor.execute(sql)
            result = self.cursor.fetchall()
        except Exception as e :
            result = (" read DB err",e)
        
        return result

    def updateDB(self,schema,table,colum,value,condition):
        sql = " UPDATE {schema}.{table} SET {colum}='{value}' WHERE {colum}='{condition}' ".format(schema=schema
        , table=table , colum=colum ,value=value,condition=condition )
        try :
            self.cursor.execute(sql)
            self.db.commit()
        except Exception as e :
            print(" update DB err",e)

    def deleteDB(self,schema,table,condition):
        sql = " delete from {schema}.{table} where {condition} ; ".format(schema=schema,table=table,
        condition=condition)
        try :
            self.cursor.execute(sql)
            self.db.commit()
        except Exception as e:
            print( "delete DB err", e)


###########

#데이터 조회
@app.route('/recruit', methods = ['GET','POST'])
def recruit():
	conn = CRUD()
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
		
		conn.insertDB(schema='recruit', table = 'test',data = data)
	return {'hello': 'world'} 
 
if __name__ == "__main__":
    app.run()
