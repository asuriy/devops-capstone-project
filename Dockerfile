FROM python:3.9-slim

# establish working directory and run requirements file
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r  requirements.txt
COPY service/ ./service/

# add non-root user
RUN useradd --uid 1000 theia && chown -R theia /app

# expose port
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]

