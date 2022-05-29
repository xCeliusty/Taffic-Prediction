from http.server import HTTPServer, BaseHTTPRequestHandler
import json

with open(r"prediction.txt") as f:
    lines = f.readlines()

class echoHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('content-type', 'text/html')
        self.end_headers()
        for i in range(len(lines)):
            self.wfile.write(lines[i].encode())

def server():
    PORT = 8000
    server = HTTPServer(('localhost', PORT), echoHandler)
    print('Server running on port %s' % PORT)
    server.serve_forever()
    
    
server()