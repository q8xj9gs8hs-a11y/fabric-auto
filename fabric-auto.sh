#!/bin/sh

# Create container-to-host DNS
sudo container system dns create host.container.internal --localhost 203.0.113.113

# Check for existing configuration
# if ${HOME}/.fabric-config or ${HOME}/.config/fabric exists:
# 	move on
# else:
# 	mkdir -p ${HOME}/.fabric-config && mv ${HOME}/.config/fabric ${HOME}/.fabric-config

echo 'Starting fabric rest api...'

fabric-ai --serve --address 127.0.0.1:8080

# execute ^Z to suspend in the background

echo 'Pulling fabric-mcp image...'

container image pull honeylavender7435/fabric-mcp:v1

echo 'Starting fabric-mcp container in the background...'

container run --rm -d -v "${HOME}/.fabric-config:/home/appuser/.config/fabric" --name fabric -e FABRIC_BASE_URL="http://host.container.internal:8080" honeylavender7435/fabric-mcp:v1 --transport http --host 0.0.0.0 --port 8000

# Optional list container details
# echo 'Container details (verify IP address)...'
# container i ls | grep fabric

# Obtain container IP address and store as variable
fabric_ip=$(container ls | grep fabric | awk '{print $6}') # Strip the end of the subnet?

echo "Container IP address: $fabric_ip"

# Print what user should add to mcp.json
echo 'Add this to your `mcp.json`:'
echo '''
{
  "mcpServers": {
    "fabric": {
      "url": "http://$fabric_ip:8000/message"
  }
}
'''
echo 'MCP server now running as an http server without port forwarding, accessed via its own IP address.'
