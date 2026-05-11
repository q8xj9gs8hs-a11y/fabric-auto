# fabric-auto

Leverage IP address assigned to each container with Apple's containerization framework to eliminate port forwarding and reduce attack surface. Also utilizes a localhost domain optional to access a host service from container. 

**NOT** for production use, this project is for experimentation and educational purposes.

## Plan

* Check for host.container.internal
* Check for ${HOME}/.fabric-config [or other]
* Eliminate port 8000 forwarding
* Fabric server on host at --address 127.0.0.1:8080
* Run fabric-mcp container
* Use DNS domain for convenience
* Use nginx proxy manager for a reverse proxy to implement security with authentication and further convenience
