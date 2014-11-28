<?php


function getip() {
  $addr = ($_SERVER["REMOTE_ADDR"])?$_SERVER["REMOTE_ADDR"]:'';
  $forward = ($_SERVER["HTTP_X_FORWARDED_FOR"])?$_SERVER["HTTP_X_FORWARDED_FOR"]:'';
  $via = ($_SERVER["HTTP_VIA"])?$_SERVER["HTTP_VIA"]:'';
  if($forward) return $addr." [proxy : ".$forward.(($via)?" (".$via.")":"")."]";
  else return $addr;
}

?>