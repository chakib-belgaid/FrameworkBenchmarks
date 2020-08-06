FROM python:3.6.6-stretch

ADD ./ /flask

WORKDIR /flask

RUN pip install -r /flask/requirements-pypy.txt

WORKDIR /flask

ENV pypy_version_info "1.0.0"

CMD gunicorn app:app -c gunicorn_conf.py
