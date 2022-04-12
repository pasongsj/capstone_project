from flask import Flask, request, jsonify, render_template
import json
from saramin_c import get_recruit
app = Flask(__name__)
'''
#초기 페이지
@app.route('/')
def index():
	return resder_template('index.html')
'''
#데이터 조회
@app.route('/recruit/', methods = ['GET'])
def recruit():
	
	return jsonify(get_recruit())
 
if __name__ == "__main__":
    app.run()
