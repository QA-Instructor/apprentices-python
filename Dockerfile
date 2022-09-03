# Alpine is a minmal linux variant - useful for tiny docker images
# The image is aliased as 'builder' to enable a multi-stage build process
FROM python:3.10-alpine AS builder
LABEL maintainer="Apprentice Workshop"

# Set this ENV so that we can see the logs
ENV PYTHONUNBUFFERED=1

# Copy everything from the . current directory to an /app directory within the image
COPY . /app

# It is more secure to create and run an application as a non-root user
# Use pip3 to install pipenv
# Add a user called flaskapp
# Change ownership of the /app directory (recursively) to flaskapp user
RUN pip3 install pipenv \
    && adduser -D flaskapp && chown -R flaskapp: /app

# Change user to flaskapp
USER flaskapp

# Set the working directory to /app
WORKDIR /app

# Create a virtual env with pipenv
RUN pipenv install

# Run our tests
RUN /bin/sh run_unit_tests.sh

# 2nd image to build with an alias of production
FROM python:3.10-alpine AS production

# Finally, copy artifacts from the 'builder' image
# Can exclude things like tests etc that we wouldn't want in our final image
COPY --from=builder /home/flaskapp /home/flaskapp
COPY --from=builder /app/templates /app/templates
COPY --from=builder /app/app.py /app/app.py
COPY --from=builder /app/run.sh /app/run.sh
COPY --from=builder /app/Pipfile /app/Pipfile
COPY --from=builder /app/Pipfile.lock /app/Pipfile.lock

# Set default address to listen on at runtime
# 0.0.0.0 tells flask to bind to any local IP address
ENV HOST_ADDRESS=0.0.0.0

# Use pip3 to install pipenv
# Add a user called flaskapp
# Change ownership of the /app directory (recursively) to flaskapp user
RUN pip3 install pipenv \
    && adduser -D flaskapp && chown -R flaskapp: /app

# Change user to flaskapp
USER flaskapp
# Set the working directory to /app
WORKDIR /app

# Document that yo would like to expose port 5000 within the container
EXPOSE 5000
# Set the process to run within the container
ENTRYPOINT [ "/bin/sh", "run.sh" ]
