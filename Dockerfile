FROM python:3.8-alpine 

COPY . .

CMD ["python3", "app.py"]