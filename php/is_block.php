<?php

function is_blocked($site){
  $block = array(
    'stephack.com',
    'google.com',
    'google.co.th',
    'pantip.com'
  );
  if(in_array($site, $block)) return true;
}
?>