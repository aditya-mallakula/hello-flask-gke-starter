import os, time, logging, random
from flask import Flask, jsonify, Response
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

logging.basicConfig(level=os.getenv("LOG_LEVEL","INFO"),
                    format='%(asctime)s %(levelname)s %(message)s')

REQS = Counter('http_requests_total', 'Total HTTP Requests', ['path','code','method'])
LAT  = Histogram('http_request_duration_seconds', 'Req latency', ['path','method'])

app = Flask(__name__)

@app.get("/healthz")
def health(): 
    return "ok", 200

@app.get("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

@app.get("/api/v1/hello")
def hello():
    who = os.getenv("WHO", "world")
    start = time.time()
    time.sleep(random.random()/20)
    LAT.labels("/api/v1/hello","GET").observe(time.time()-start)
    REQS.labels("/api/v1/hello","200","GET").inc()
    return jsonify(msg=f"hello {who}")
