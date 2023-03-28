FROM 198101904822.dkr.ecr.us-east-1.amazonaws.com/cruddur-python:3.10-slim-buster

WORKDIR /backend-flask

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

ENV FLASK_DEBUG=1

EXPOSE ${PORT}
#python3 -m flask run --host=0.0.0.0 --port=4567
#docker run --rm -p 4567:4567 -it -e FRONTEND_URL='*' -e BACKEND_URL='*' backend-flask
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567"]