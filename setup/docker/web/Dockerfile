# pull official base image
FROM python:3.8-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
#ENV PYTHONDONTWRITEBYTECODE 1
#ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt /usr/src/app/requirements.txt
RUN pip install -r requirements.txt

# copy project
COPY *.py /usr/src/app/
COPY *.html /usr/src/app/
#COPY entrypoint.sh /usr/src/app/

#RUN chmod +x entrypoint.sh

EXPOSE 8000/tcp
CMD uvicorn main:app --reload --host 0.0.0.0 --port 8000