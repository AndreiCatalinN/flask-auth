
from python:latest

env PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app


run adduser \ 
    --disabled-password \ 
    --gecos "" \ 
    --home "/nonexistent" \ 
    --no-create-home \ 
    --uid 10001
    appuser

RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

user appuser
COPY . .
expose 8080

CMD ["python3", "-m", "uvicorn", "app:app", "--host=0.0.0.0", "--port=8080"]