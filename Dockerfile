FROM python:3.9-alpine3.13
LABEL maintainer="vietleuit@gmail.com"

# Ensures that the Python output is sent straight to terminal (stdout and stderr) and not buffered,
# which is useful when debugging Python applications, as it allows we to see logs in real-time.
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app

WORKDIR /app

EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

# Best practice is to use a non-root user to run the application
USER django-user