# Use the official slim Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Working directory
WORKDIR /code

# Install system-level dependencies (optional but safe for common packages)
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    sqlite3 \
    && apt-get clean

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project code
COPY . .

# ✅ Ensure /data exists (mount target for SQLite volume)
RUN mkdir -p /data

# ✅ Set default DB path in case not overridden by ENV
ENV DB_PATH=/data/db.sqlite3

# ✅ Optional: Show env setup (helpful for debugging)
RUN echo "Using DB at: $DB_PATH"

# ✅ Run collectstatic for admin/static use
RUN python manage.py collectstatic --noinput

# ✅ Auto-run migrations at start
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
