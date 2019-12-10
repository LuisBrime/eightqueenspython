FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y

RUN apt-get install -y python3.6 
RUN apt-get install python3-pip 
RUN apt-get install python3-venv 
RUN apt-get install python-psycopg2 
RUN apt-get install postgresql 
RUN apt-get install postgresql-client 
RUN apt-get install postgresql-contrib 
RUN apt-get install postgresql-plpython

FROM library/postgres
ENV POSTGRES_USER brime
ENV POSTGRES_PASSWORD panda
ENV POSTGRES_DB queensdb

RUN mkdir /eightqueens
WORKDIR /eightqueens
COPY . /eightqueens

ADD eightqueens.py /
ADD test_basic.py /
ADD main.py /

RUN python -m venv env
RUN source env/bin/activate

RUN pip install -r requirements.txt

CMD [ "python3", "./main.py" ]
