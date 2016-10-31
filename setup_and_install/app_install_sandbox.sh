#! /usr/bin/env bash

echo "This script will install your app on the Cisco DevNet Mantl Sandbox"
echo
echo "The details on the Sandbox can be found at: "
echo "    https://devnetsandbox.cisco.com/ "
echo "You can access the Sandbox at: "
echo "    https://mantlsandbox.cisco.com "
echo "    user/pass: admin/1vtG@lw@y"
echo

control_address=mantlsandbox.cisco.com
mantl_user=admin
mantl_password=1vtG@lw@y
mantl_domain=app.mantldevnetsandbox.com

echo Please provide the following details on your bot.
echo "What is your Docker Username?  "
read docker_username
echo
echo "What is the Docker Repository Name for your App?  "
read docker_repo
bot_name=$docker_repo
echo
echo
echo "Your app will be deployed based on the 'latest' tag of Docker Container at: "
echo "    https://hub.docker.com/r/$docker_username/$docker_repo/"
echo "Is this correct?  yes/no"
echo
read ANSWER

if [ $ANSWER != "yes" ]
then
    echo "Exiting without installing bot"
    exit 0
fi

cp sample_marathon_app_def.json $docker_username-$bot_name-sandbox.json
sed -i "" -e "s/DOCKERUSER/$docker_username/g" $docker_username-$bot_name-sandbox.json
sed -i "" -e "s/DOCKERREPO/$docker_repo/g" $docker_username-$bot_name-sandbox.json

sed -i "" -e "s/USERNAME/$docker_username/g" $docker_username-$bot_name-sandbox.json
sed -i "" -e "s/BOTNAME/$bot_name/g" $docker_username-$bot_name-sandbox.json
sed -i "" -e "s/APPDOMAIN/$mantl_domain/g" $docker_username-$bot_name-sandbox.json

if [ $TAG != "" ]
then
    sed -i "" -e "s/latest/$TAG/g" $docker_username-$bot_name-sandbox.json
fi


echo " "
echo "***************************************************"
echo "Installing the Bot as  $docker_username/$bot_name"
curl -k -X POST -u $mantl_user:$mantl_password https://$control_address:8080/v2/apps \
-H "Content-type: application/json" \
-d @$docker_username-$bot_name-sandbox.json \
| python -m json.tool

echo "***************************************************"
echo

echo "App Installed"
echo
echo "Your app is deployed and ready to recieve notifications at:"
echo
echo "http://$docker_username-$bot_name.$mantl_domain/"
echo
echo "You can also watch the progress from the GUI at: "
echo
echo "https://$control_address/marathon"
echo
