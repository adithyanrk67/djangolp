FROM python:3.8

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file and install Python dependencies
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy the rest of the application code to the container
COPY . /app/

# Expose port 8000
EXPOSE 8000

# Run migrations before starting the Django application
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate

# Start the Django application
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

