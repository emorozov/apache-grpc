FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1
ENV DEBUG=1

RUN apt-get update && apt-get install -y --no-install-recommends apache2 libapache2-mod-wsgi-py3 && \
    apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/ && rm -rf /var/log/apt

RUN pip install poetry==1.2.2

WORKDIR /app/src

ADD pyproject.toml poetry.lock /app/src/

RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

ADD ./ /app/src

ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf

#ENTRYPOINT ["/usr/local/bin/python", "manage.py", "runserver"]
#CMD ["0.0.0.0:8000"]
