<?php 
  exec("sudo systemctl stop dogecoind-start.service");
  exec("sudo systemctl disable dogecoind-start.service");
  echo "Stop Command Sent for Private Node";
  exec (". /home/pinodedoge/remove-autostart.sh");
 ?>