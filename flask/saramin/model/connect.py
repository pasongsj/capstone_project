import psycopg2
conn = psycopg2.connect(host='localhost', dbname = 'testdb', user='brown',password = 'brown', port = '5432')
cur = conn.cursor()


title = "[경력] 프론트개발자 경력 채용합니다(정규직)"
company = "(주)풀스택"
career = "경력 3년↑"
education = "학력무관"
employment_type = "정규직"
workc_place = "서울 중구"
idx = "42653376"
deadline = "상시채용"
reg = "(12시간 전 등록)"
stack =  ["277", "278", "229", "209", "236"]
#"task": []
na = "soo"

data = (0,'soo',25)

cur.execute(star,data)
#cur.execute('INSERT INTO recuit(id, recompanyName,recruitTitle, recruitCareer, recruitSchool, recruitCondition, recruitLocation, dueDate, dueType, recruitCode, createdAt, updatedAt) VALUES(idx, company,title, career, education, employment_typ, workc_place, 0, deadline, stack, reg)')
cur.close()
conn.close()

