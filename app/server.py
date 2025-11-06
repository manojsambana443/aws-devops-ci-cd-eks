from http.server import BaseHTTPRequestHandler, HTTPServer
import os

PORT = int(os.environ.get("PORT", "8080"))
MESSAGE = os.environ.get("MESSAGE", "Hello from DevOps CI/CD on EKS!")

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(MESSAGE.encode("utf-8"))

if __name__ == "__main__":
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
