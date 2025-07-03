# Use the official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /code

# Install dependencies
COPY requirements.txt /code/
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project
COPY . /code/

# Collect static files (optional for prod)
RUN python manage.py collectstatic --noinput

# Expose port (default Django runs on 8000)
EXPOSE 8000

# Run Gunicorn server
CMD ["gunicorn", "agrikart.wsgi:application", "--bind", "0.0.0.0:8000"]
