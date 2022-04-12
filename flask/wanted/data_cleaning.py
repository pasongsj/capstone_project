#!/usr/bin/env python
# coding: utf-8

# In[2]:


import json
#import spacy
import re
import pandas as pd
from gensim.models import Word2Vec


# In[13]:


fields = ['872','873','669','10110','677','678','655','674','895','665','1634','1024','1025','877',
           '676','1026','671','893','876','939','1027','658','10111','661','672','898','894','1022',
          '961','962','878','960','958','897'] # 세부 분야
    





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
            if efield in e_data['task']:
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
            


# In[17]:


def similar_stack(main_stack,datas):

    model = Word2Vec(sentences=datas, vector_size=100, window=4, min_count=1, workers=4, sg=0)
    model_result = model.wv.most_similar(main_stack,topn=3)

    
    return model_result


# In[21]:


def get_stack_to_stack(data):
    
	perc = get_job_to_stack(data)
	data_sample = [] #전체 통계용 데이터
	for line in data[1:]:
		line_stack = line['stacks']
		if(len(line_stack) > 0):
			data_sample.append(line_stack)
            
	top_stacks = []
	stat_stack = {}
	for stacks in perc.values():
		for e_stack in stacks:
			if(e_stack not in top_stacks):
				model = Word2Vec(sentences=data_sample, vector_size=100, window=4, min_count=1, workers=4, sg=0)
				sim = model.wv.most_similar(e_stack,topn=3)
				stat_stack[e_stack] = [sim[0][0],sim[1][0],sim[2][0]]
				top_stacks.append(e_stack)
	return stat_stack
    



