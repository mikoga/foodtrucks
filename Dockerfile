FROM node:14-alpine3.11 AS builder
WORKDIR /app
COPY flask-app /app/
RUN npm install -g npm@6 && \
    npm install --save-dev webpack-cli &&\
    npm run build

FROM python:2.7-alpine3.11 AS final-stage
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY --from=builder /app /app
RUN apk add --no-cache python2 py2-pip &&\
    pip install -r requirements.txt

ENTRYPOINT ["python2", "app.py"]
