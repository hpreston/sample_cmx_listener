from flask import Flask, make_response, request, jsonify, Response
import sys

app = Flask(__name__)

@app.route("/", methods=["POST"])
def listener():
	sent_data = request.get_data()
	sys.stderr.write(str(sent_data) + "\n\n")
	return "Received\n"

if __name__=='__main__':
	app.run(debug=True, host='0.0.0.0', port=8000)

	