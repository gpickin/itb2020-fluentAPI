#!/bin/bash

###########################################################################
# This file is called by Dockerfile to setup the image
###########################################################################
echo "Starting up container in test mode"
# We send up our "testing" flag to prevent the default CommandBox image run script from begining to tail output, thus stalling our build
export IMAGE_TESTING_IN_PROGRESS=true
# Run our normal build script, which will warm up our server and add it to the image
${BUILD_DIR}/run.sh
sleep 15

# Stop our server
cd ${APP_DIR} && box server stop
# Remove our testing flag, so that our container will start normally when its run
unset IMAGE_TESTING_IN_PROGRESS
echo "Container successfully warmed up"

echo "Environment setup complete"
