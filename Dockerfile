# Source from standard python container 
FROM python:2.7-onbuild
# FROM python:3.5-onbuild

# Application runs on port 8000 
EXPOSE 8000

# Create an application directory within the container 
RUN mkdir /app
WORKDIR /app

# Copy the python application into the container 
COPY ./python_sample_notification_listener.py /app
COPY ./flask_listener.py /app

# Start the python application
CMD [ "python", "./flask_listener.py" ]