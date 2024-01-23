# Easily launch ephemeral headed Chrome instances
Launch headed Chrome in a Docker container, start a VNC server, and get the remote debugging websocket endpoint back.
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
>>> ws://localhost:9222/devtools/browser/39700af5-80cb-41ae-8929-f39f9ca1ccd9
```

## Connect VNC
```bash
vncviewer localhost:5900
```
