# Easily launch ephemeral headed Chrome instances
Launch headed Chrome in a Docker container, start a VNC server, and get the remote debugging websocket endpoint back.
Designed for privacy and automation.
By using this, you agree to Google Chrome terms: https://www.google.com/chrome/terms/

## Install
```bash
git clone https://github.com/gbiz123/docker-chrome-vnc/
cd docker-chrome-vnc
docker build -t chrome-gui .
chmod +x run-chrome-gui.sh
```

## Launch
```bash
./run-chrome-gui.sh 9222 5900 # Specify port for remote debugging
>>> {"containerId":de66831e80a5c0c6645e8240276549ea40ca18a30e816a100c5c28c4e139bfe3,"wsEndpoint":ws://localhost:9222/devtools/browser/8c6ff95f-f609-49eb-b701-d46b3e0e1c89}
```

## Connect VNC
```bash
vncviewer localhost:5900
```
