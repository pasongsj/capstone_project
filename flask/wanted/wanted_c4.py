#!/usr/bin/env python
# coding: utf-8

# In[1]:


from selenium import webdriver
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager

from selenium.common.exceptions import TimeoutException
from selenium.common.exceptions import NoSuchElementException,StaleElementReferenceException

import spacy
import re
import json
import time


#start = time.time()
NUM = 30


#명시적대기 headless 

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
options = webdriver.ChromeOptions()
options.add_argument('headless')
# '중요' 본인의 user-agent를 사용해야함
options.add_argument('user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36')


# In[2]:


nlp = spacy.load('en_core_web_sm') # python3 -m spacy download en_core_web_sm
nstack = ["js","+","end","git","github","service","service","product","architecture",
          "system","test","sns","flow","ci","cd","pc","tdd","pm","clients","fit",
          "managements","expoerience","data","platform","interview","engine","technical",
         "url","boot"]

spacy_stopwords = list(nlp.Defaults.stop_words) + nstack


# In[3]:


def getInfo(category):

	browser = webdriver.Chrome(ChromeDriverManager().install(),chrome_options=options)	#  '중요' chromedriver 위치 ex) '/usr/local/bin/chromdriver.exe'
    
	URL = 'https://www.wanted.co.kr/wdlist/'+str(category)+'?country=kr&job_sort=job.latest_order&years=-1&locations=all'   
	browser.get(URL);	# 페이지 열기
	browser.implicitly_wait(5)#로딩 대기

	prev_height = browser.execute_script("return document.body.scrollHeight")
    
	while True:#원하는 양의 공고를 얻을 때 까지 스크롤
		browser.execute_script("window.scrollTo(0, document.body.scrollHeight)")#스크롤
		time.sleep(2)
 
		infoList = browser.find_element(By.CSS_SELECTOR,'#__next > div.JobList_cn__t_THp > div > div > div.List_List_container__JnQMS > ul')
		items = infoList.find_elements(By.TAG_NAME, 'li')# 확인되는 공고 리스트 개수

		curr_height = browser.execute_script("return document.body.scrollHeight")

		if(len(items) > NUM or curr_height == prev_height):
			time.sleep(2)
			curr_height = browser.execute_script("return document.body.scrollHeight")
			if(curr_height == prev_height or len(items) > NUM ):
				break
			else:
				prev_height = browser.execute_script("return document.body.scrollHeight")

		else:
			prev_height = browser.execute_script("return document.body.scrollHeight")

    
	wait = WebDriverWait(browser,20)
	element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR,'#__next > div.JobList_cn__t_THp > div > div > div.List_List_container__JnQMS > ul')))
    #time.sleep(10)      
	infoList = browser.find_element(By.CSS_SELECTOR,'#__next > div.JobList_cn__t_THp > div > div > div.List_List_container__JnQMS > ul')
	tems = infoList.find_elements(By.TAG_NAME, 'li') # 공고 list

	jobs = [] # 공고 저장
	pid = []
	for item in items[:len(items)-4]:
        # 공고 상세
		info = item.find_element(By.CSS_SELECTOR, 'div > a')       
        #링크
		url = info.get_attribute('href') 
        #제목
		#title = info.find_element(By.CSS_SELECTOR, 'div > div.job-card-position').text
        #회사
		#company = info.find_element(By.CSS_SELECTOR, 'div > div.job-card-company-name').text
        #공고id
		idx = info.get_attribute('data-position-id')
        #빈 stack만들기
		task = []
		result = {'url' : url, 'task':task}
		jobs.append(result)
		pid.append(idx)
	browser.quit()
	return [pid, jobs]


    


# In[4]:


def getStack(category,fields):
    browser = webdriver.Chrome(ChromeDriverManager().install(),chrome_options=options)	#  '중요' chromedriver 위치
    
    result = []
    
    for field in fields:
        
        url = 'https://www.wanted.co.kr/wdlist/'+str(category)+'/'+str(field)+'?country=kr&job_sort=job.latest_order&years=-1&locations=all'
        browser.get(url);	# 페이지 열기
        browser.implicitly_wait(5)# 로딩 대기
    
        scroll = 1
        prev_height = browser.execute_script("return document.body.scrollHeight")# 현재 문서 높이를 가져와서 저장
        while True:
            # 스크롤을 화면 가장 아래로 내린다
            browser.execute_script("window.scrollTo(0,document.body.scrollHeight)")
            # 페이지 로딩 대기
            time.sleep(2)
            #wait = WebDriverWait(browser,1)
            #element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR,'#__next > div.JobList_cn__t_THp > div.JobList_contentWrapper__QiRRW > div > ul')))
        
            infoList = browser.find_element(By.CSS_SELECTOR,'#__next > div.JobList_cn__t_THp > div > div > div.List_List_container__JnQMS > ul')
            items = infoList.find_elements(By.TAG_NAME, 'li')
    

            # 현재 문서 높이를 가져와서 저장
            curr_height = browser.execute_script("return document.body.scrollHeight")

            if(curr_height == prev_height or len(items) > NUM ):
                time.sleep(2)
                curr_height = browser.execute_script("return document.body.scrollHeight")
                if(curr_height == prev_height or len(items) > NUM ):
                    break
                else:
                    prev_height = browser.execute_script("return document.body.scrollHeight")
            else:
                prev_height = browser.execute_script("return document.body.scrollHeight")
                
            
            

        
        wait = WebDriverWait(browser,20)
        element = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR,'#__next > div.JobList_cn__t_THp > div > div > div.List_List_container__JnQMS > ul')))
        #time.sleep(10)
        infoList = browser.find_element(By.CSS_SELECTOR,'#__next > div.JobList_cn__t_THp > div > div > div.List_List_container__JnQMS > ul')
        items = infoList.find_elements(By.TAG_NAME, 'li') #공고리스트 가져오기


        pid = []# field의 idx값
        for item in items[:len(items)-4]:
            #섹션
            info = item.find_element(By.CSS_SELECTOR, 'div > a')
            
            
            #공고id
            if(info):
                idx = info.get_attribute('data-position-id')# 공고의 idx값 가져오기
                pid.append(idx)

        result.append(pid) # 전체 field의 idx값
        
    browser.quit()
    return result


# In[5]:


def getDetail(jobs):
    
    browser = webdriver.Chrome(ChromeDriverManager().install(),chrome_options=options)	#  '중요' chromedriver 위치  
    
    for job in jobs:# 공고 리스트
        url = job['url'] # 공고 url
        browser.get(url);	# 페이지 열기
        browser.implicitly_wait(5)#로딩 대기
        
        mainTask = [] #주요업무, 자격요건이 존재하지만 우대사항이 없는경우가 존재함
        qualification = []
        prefer = []

        try:
            mainTask = browser.find_element(By.CSS_SELECTOR,'#__next > div.JobDetail_cn__WezJh > div.JobDetail_contentWrapper__DQDB6 > div.JobDetail_relativeWrapper__F9DT5 > div > div.JobContent_descriptionWrapper__SM4UD > section > p:nth-child(3)').text
            qualification = browser.find_element(By.CSS_SELECTOR,'#__next > div.JobDetail_cn__WezJh > div.JobDetail_contentWrapper__DQDB6 > div.JobDetail_relativeWrapper__F9DT5 > div > div.JobContent_descriptionWrapper__SM4UD > section > p:nth-child(5)').text
            prefer = browser.find_element(By.CSS_SELECTOR,'#__next > div.JobDetail_cn__WezJh > div.JobDetail_contentWrapper__DQDB6 > div.JobDetail_relativeWrapper__F9DT5 > div > div.JobContent_descriptionWrapper__SM4UD > section > p:nth-child(7)').text
            
            stacks = mainTask + qualification + prefer
            
            filtered_stack = filtering(stacks)
            print(filtered_stack)
            job['stacks'] = filtered_stack
            
            #job['mainTask'] = filtering(mainTask)
            #job['qualification'] = filtering(qualification)
            #job['prefer'] = filtering(prefer)

        except:
            #print(" [예외 발생] 표 없음 ")
            continue
            
    browser.quit()
    return jobs

        
    


# In[6]:


def filtering(sentence):

    tmp = re.sub('[^a-zA-Z+]'," ",sentence).lower() # maintask cleaning
    #tmp_q = re.sub('[^a-zA-Z+]'," ",sentence['qualification']).lower() # qualification
    #tmp_p = re.sub('[^a-zA-Z+]'," ",sentence['prefer']).lower() # prefer
    #tmp = tmp_m + tmp_q + tmp_p # 공고 내 모든 정보
    res = [] # 결과
    react = 0 # react native react js구분
            #print(tmp)
            
    #text_without_stopword = []
    for word in tmp.split():
        if word not in spacy_stopwords:
            # js처리
            if word == 'react':
                react = 1
            elif word == 'git':
                res.append('github')
            
            elif word == 'rest':
                res.append('restful')
            
            elif word == 'vue':
                res.append('vuejs')
            
            elif word == 'node':
                res.append('nodejs')
                
            elif word == 'rx':
                res.append('rxjs')
            
            elif react == 1: # react native react js구분
                react = 0
                if word == 'native':
                    res.append('react native')
                
                else:
                    res.append('reactjs')
                    res.append(word)
                            
            elif word == 'net': # .NET처리
                res.append('.net')
                
               # frontend, backend 처리
            elif word == 'front':
                res.append('frontend')
                        
            elif word == 'back':
                res.append('backend')
                    
            elif word == 'unreal':
                res.append('unreal engine')
            
            else:
                    res.append(word)
    return res


# In[7]:


def get_wanted_info():
    
    cate = ['518','959']# 개발, 게임제작
    fields = [['872','873','669','10110','677','678','655','674','895','665','1634','1024','1025','877',
              '676','1026','671','893','876','939','1027','658','10111','661','672','898','894','1022'],
             ['961','962','878','960','958','897']] # 세부 분야
    
    result = []
    for index in range(len(cate)):# 518, 959
        infos = getInfo(cate[index]) # 공고 링크, 제목, 회사, idx값
        idx = infos[0] # idx와 인덱스 값
        jobs = infos[1] # 공고 정보
        
        fieldsIDX = getStack(cate[index],fields[index])# fields의 idx값 갖져오기

        i = 0                  
        for fIDX in fieldsIDX:# fIDX : 각 분야에어 가져온 idx값들
            for eIDX in fIDX: # eIDX : each IDX
                if eIDX in idx:  
                    eIDX_P = idx.index(eIDX) # eIDX_P :해당 eIDX가 존재하는 전체공고의 위치    
                    tasks = jobs[eIDX_P].pop('task') # stack 값 추가하기
                    tasks.append(fields[index][i]) 
                    jobs[eIDX_P]['task'] = tasks

            i = i + 1
        result.extend(jobs)
    fin = getDetail(result)
    
    with open('wanted_220403.json','w',encoding='utf-8') as f:
        json.dump(fin ,f,default=str,ensure_ascii=False)

    return fin

get_wanted_info()
