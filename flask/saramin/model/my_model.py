from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

URL = 'postgresql://brown:brown@localhost:5432/rescruit'
engine = creat_engine(URL, echo = False)

#
SessionLocal = sessionmaker(autocmmit=False, autoflush=True, bind=engine)


#model.py
f
