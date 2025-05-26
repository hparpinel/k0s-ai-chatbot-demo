FROM python:3.10-slim

WORKDIR /app

COPY app/backend/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend and frontend into /app
COPY app/backend/ ./backend/
COPY app/frontend/ ./frontend/

WORKDIR /app/backend
CMD ["python3", "chatbot.py"]
