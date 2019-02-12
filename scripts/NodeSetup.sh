#!/bin/bash
set -o errexit
set -o xtrace

# Install jq
dpkg -s jq || sudo apt-get install -y jq

# Install Confluent platform (includes Kafka schema registry)
wget -qO - http://packages.confluent.io/deb/4.1/archive.key | sudo apt-key add -
sudo add-apt-repository "deb http://packages.confluent.io/deb/4.1 stable main"
sudo apt-get update
dpkg -s confluent-platform-oss-2.11 || sudo apt-get install -y confluent-platform-oss-2.11

echo "Installation successful."