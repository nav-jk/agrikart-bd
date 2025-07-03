# Use the official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /code

# Install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the entire project into the container
COPY . .

# Sanity check: ensure wsgi.py exists (for debugging path issues)
RUN ls -l /code/agrikart/wsgi.py

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose port 8000 (Django/Gunicorn default)
EXPOSE 8000

# Run Gunicorn server
CMD ["gunicorn", "agrikart.wsgi:application", "--bind", "0.0.0.0:8000"]
