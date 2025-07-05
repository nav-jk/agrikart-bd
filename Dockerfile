# Use the official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create and set working directory
WORKDIR /code

# Install system dependencies
RUN apt-get update && apt-get install -y gcc libpq-dev && apt-get clean

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# ✅ Create /data folder (just in case volume doesn't)
RUN mkdir -p /data

# ✅ Show DB path for sanity
RUN echo " DB_PATH: $DB_PATH"

# ✅ Optional: Copy local db for first-time run (comment after first deploy)
# COPY db.sqlite3 /data/db.sqlite3

# Run collectstatic (you may skip this if not using Django admin CSS/js in production)
RUN python manage.py collectstatic --noinput

# Expose port (Django default)
EXPOSE 8000

# Launch server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
