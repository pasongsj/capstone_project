from selenium import webdriver
from selenium.webdriver.common.by import By


from webdriver_manager.chrome import ChromeDriverManager #pip install webdriver-manager

#데이터 처리
import datetime


import json
#import pandas as pd
#import openpyxl

# 시간 확인용
#import time
#start = time.time()

#명시적대기 headless 오류제거
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

options = webdriver.ChromeOptions()
options.add_argument('headless')
#각user의 user-agent값
options.add_argument('user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36')#현재 user-agent 확인필수


# In[2]:


def get_info(pages):
    
    #global LIMIT
    browser = webdriver.Chrome(ChromeDriverManager().install(),chrome_options=options)
    #browser = webdriver.Chrome("chromedriver.exe",chrome_options = options)	#chromedriver 위치
    
    url = 'https://www.saramin.co.kr/zf_user/jobs/list/job-category?cat_mcls=2&panel_type=&search_optional_item=n&search_done=y&panel_count=y&sort=RD&tab_type=all&searchParamCount=1&recruit_kind=recruit&quick_apply=y&page='+str(pages)


    browser.get(url);	# 페이지 열기
    browser.implicitly_wait(5)
    #browser.execute_script("window.scrollTo(0,30)")
    
    wait = WebDriverWait(browser,20)
    element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR,'#content > div.recruit_list_renew > div.common_recruilt_list')))
    
    list_ = browser.find_element(By.CSS_SELECTOR,'#content > div.recruit_list_renew > div.common_recruilt_list')
    #content > div.recruit_list_renew > div.common_recruilt_list
    items = list_.find_elements(By.CSS_SELECTOR,'.list_item')

    ann_list = []
    for item in items:

        #id
        idx = str(item.get_attribute('id')[4:])

        #stack = [] #빈 스택 생성

        # 회사
        company = item.find_element(By.CSS_SELECTOR,".company_nm").find_element(By.TAG_NAME, 'a').text
    
        # 제목
        title = item.find_element(By.CSS_SELECTOR,".notification_info").find_element(By.TAG_NAME, 'a').text
    
        # 경력
        career = item.find_element(By.CSS_SELECTOR,".career").text
    
        # 학력
        education = item.find_element(By.CSS_SELECTOR,".education").text
    
        # 근무형태
        employment_type = item.find_element(By.CSS_SELECTOR,".employment_type").text
    
        # 근무 위치
        try:
            work_place = item.find_element(By.CSS_SELECTOR,".work_place").text
        except Exception as e:# 위치 등록을 하지 않은 경우
            place = None
        
        #마감일,등록일
        time = item.find_element(By.CSS_SELECTOR,".deadlines").text.split('\n')
        
        #마감
        deadline = time[0]
        #등록
        reg_date = time[1]
        
        pos = deadline.find('~')# datetype 으로 deadline
        if(pos != -1):
            deadline = datetime.datetime.strptime('2022/' + deadline[pos+2:pos+7]+'/14:59:59','%Y/%m/%d/%H:%M:%S')
    
        
        
        #오늘 공고만
        
        info = {'title':title, 'company':company, 'career':career, 'education':education,
                'employment_type' :employment_type,  'workc_place':work_place,
                'idx':idx,'deadline': deadline, 'reg':reg_date}
        ann_list.append(info)
        if(reg_date == '(1일 전 등록)'):
            #LIMIT = 0
            browser.quit()
            return ann_list
        
    
    
    browser.quit()
    return ann_list


# In[3]:


def get_stack(info):
    
	errorPage = 'https://www.saramin.co.kr/zf_user/recruit/inspection-view'
	d_browser = webdriver.Chrome(ChromeDriverManager().install(),chrome_options=options)


	d_browser.implicitly_wait(5)
    
	for e_info in info:
		d_url = 'https://www.saramin.co.kr/zf_user/jobs/relay/view?rec_idx='+e_info['idx']
        #페이지 접속
		
		d_browser.get(d_url)
        #오류제거
		stack = []
		if(d_browser.current_url == errorPage):
			pass
		else:
        #try: #페이가 준비중인 경우
			wait = WebDriverWait(d_browser,50)
			element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR,'.tags')))
        #except TimeoutExceoption:
         #   e_info["stack"] = stack
          #  pass
            #tag접근
			tag_sec = d_browser.find_element(By.CSS_SELECTOR,'.tags')
			stacks = tag_sec.find_element(By.CSS_SELECTOR,'.scroll')
			tmps = stacks.find_elements(By.TAG_NAME, 'a')
            #모든 태크 모으기
			for tmp in tmps:
				url = tmp.get_attribute('href')
				index = url.find('kewd')
				if(index != -1):
					stack.append(url[index+5:])
            
		e_info["stack"] = stack

	d_browser.quit()
	return info


# In[4]:


def sep_stack(infos):
    
    tasksList = [80,81,82,83,84,85,86,87,88,89,90,91,92,95,97,98,99,100,101,181,104,153,128,
                 184,102,2229,108,200,109,307]
    nstacksList = [185,186,187,2234,319,188,189,320,191,2232,192,194,195,196,197,199,201,202,203,204,205,
                   206,207,209,210,211,213,214,215,216,217,218,220,221,222,223,224,226,227,229,230,231,
                   232,233,234,235,236,237,238,239,240,241,242,243,244,246,250,251,252,253,254,255,256,
                   257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,275,276,277,278,
                   279,280,281,282,283,284,285,286,287,289,291,292,293,294,297,298,300,301,302,303,304,
                   305,306,308,310,311,312,313,314,315,316,317,318]
    for info in infos:
        task = []
        stack = []
        rem = []
        
        for e_stack in info['stack']:
            n_stack = int(e_stack)
            if n_stack in tasksList:
                task.append(e_stack)
            elif n_stack in nstacksList:
                stack.append(e_stack)
            else:
                rem.append(e_stack)

        info["stack"] = stack
        info["task"] = task
        #info["rem"] = rem # 남은 스택num
    return infos
        


# In[5]:


def get_recruit():
	#global LIMIT
	info = []
	pages = 1 
	while True:
		info.extend(get_info(pages))
		pages = pages + 1
		if(info[len(info)-1]['reg'] == '(1일 전 등록)'):
			info.pop()
			break
		break
		
		
		
	result = get_stack(info) 
	fin = sep_stack(result)
    

	#with open('saramin_220410.json','w',encoding='utf-8') as f:
	#	json.dump(fin ,f,default=str,ensure_ascii=False)
	return fin
    

