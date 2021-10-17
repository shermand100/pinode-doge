<?php 
  exec("sudo systemctl start dogecoind-start.service");
  exec("sudo systemctl enable dogecoind-start.service");
  echo "Start Command Sent";
 ?>