FROM python:3.11-slim
WORKDIR /app
COPY app/ /app/
RUN pip install -r /app/requirements.txt --no-cache-dir || true
ENV PORT=8080
EXPOSE 8080
CMD ["python", "server.py"]
