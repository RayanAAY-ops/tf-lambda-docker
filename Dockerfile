FROM --platform=linux/arm64 public.ecr.aws/lambda/python:3.12

COPY app/requirements.txt ${LAMBDA_TASK_ROOT}

RUN pip3 install -r requirements.txt

COPY app/*.py  ${LAMBDA_TASK_ROOT}

CMD [ "app.handler" ]