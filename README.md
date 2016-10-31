# sample\_cmx\_listener

This is a sample application that creates and deploys a sample CMX Listener Application within a Docker Container onto the DevNet Mantl Sandbox.  The key files included are: 

* `python_sample_notification_listener.py` - the original code for the listener 
* `flask_listener.py` - the code for the containerized listener
* `Dockerfile` - the docker image definition 
* `setup_and_install/app_install_sandbox.sh` - a bash script to deploy the app
* `setup_and_install/app_uninstall_sandbox.sh` - a bash script to remove the app
* `setup_and_install/sample_marathon_app_def.json` - a application definition template for Marathon

## Build and Push Initial Docker Image

1. Build the base bot

    ```
    # Set a couple environment variables to make commands easier
    # Replace the <NAME> with your data
    
    # You need to have registered for an account on hub.docker.com
    export DOCKER_USER=<YOUR DOCKER HUB USERNAME>

    # This will be the name of your listener app, no spaces or punctuation
    export REPO_NAME=<REPO NAME>
        
    # Build a Docker image
    docker build -t $DOCKER_USER/$REPO_NAME:latest .
    ```
    
2. Push the image to Docker Hub
    * You will need to have logged into Docker Hub on your workstation for this step.  If you haven't done so, you can by running: 

        ```
        docker login 
        ```

    ```
    docker push $DOCKER_USER/$REPO_NAME:latest
    ```

## Deploy your Listener to DevNet Sandbox

These steps will deploy your app to the Cisco DevNet Mantl Sandbox.  This is just one option that is freely available to use, however you can deploy your bot to any infrastructure that meets these requirements:

* Able to run a Docker Container
* Provides a URL for inbound access to running containers from the Internet
    * *Spark needs to be able to reach it with WebHooks*

These instructions leverage a few shell scripts that make API calls to Marathon within the Mantl Sandbox.  

1. Deploy your App.  
    
    ```
    # From the root of your project... 
    cd setup_and_install 
    	
    # Run the install script
    ./app_install_sandbox.sh 
    ```
    
    * Answer the questions asked
    * When complete, you should see a message that looks like this

    ```
    Your app is deployed and ready to recieve notifications at:  

    http://<DOCKER USERNAME>-<REPO NAME>.app.mantldevnetsandbox.com/
        
    You can also watch the progress from the GUI at: 
    
    https://mantlsandbox.cisco.com/marathon
    ``` 

## Uninstalling your App

1. An uninstallation script is provided to uninstall your bot from the DevNet Sandbox.  

    ```
	# From the root of your project... 
	cd setup_and_install 
	
	# Run the install script
	./app_uninstall_sandbox.sh 
	```
    