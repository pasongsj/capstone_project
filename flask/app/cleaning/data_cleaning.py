import re
import pandas as pd
from gensim.models import Word2Vec
#fields = ['872','873','669','10110','677','678','655','674','895','665','1634','1024','1025','877','676','1026','671','893','876','939','1027','658','10111','661','672','898','894','1022','961','962','878','960','958','897'] # 세부 분야
fields = [80,81,82,83,84,85,86,87,88,89,90,91,92,95,97,98,99,100,101,181,104,153,128,184]    





def statistics(infos):# 정제 데이터 
    perc = {}
    for index, key in enumerate(infos.values()) :
        word_list = pd.Series(key)
        li = word_list.value_counts().head(5).to_dict()
        perc[fields[index]] = li
        for key in infos.values():
            word_list = pd.Series(key)
            li = word_list.value_counts().head(5)
    return perc


# In[10]:


def get_job_to_stack(data):
	result = {}
	for efield in fields: # 카테고리별 판별
		tmp = []
		for e_data in data: # 각데이터 분석
			if (efield in e_data['task']) and ('stacks' in e_data):
				tmp.extend(e_data['stacks'])    
		result[efield] = tmp
	perc = statistics(result)
	return perc


# In[9]:


def recruit_count(data):#공고 비율
    result = {}
    for efield in fields:# 각 카테고리 별 확인
        count = 0
        for e_data in data:
            if efield in e_data['task']:
                count = count + 1
        result[efield] = count
    return result
            


def get_stack_to_stack(data):
	data_sample = [] #전체 통계용 데이터
	for line in data:
		if'stacks' in line:
			line_stack = line['stacks']
			if(len(line_stack) > 0):
				data_sample.append(line_stack)
	
	result = {}
	perc = get_job_to_stack(data)
	for stacks in perc.keys():
		for estack in perc[stacks].keys():
			model = Word2Vec(sentences=data_sample, vector_size=100, window=4, min_count=1, workers=4, sg=0)
			sim = model.wv.most_similar(estack,topn=3)
			perc[stacks][estack] = [sim[0][0],sim[1][0],sim[2][0]]
	return perc
    



