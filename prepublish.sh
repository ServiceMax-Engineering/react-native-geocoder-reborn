#!/bin/bash
if [ -z "$JENKINS_URL" ]
then
  echo "npm publish should only be run in jenkins environment"
  exit 1;
else
  exit 0
fi