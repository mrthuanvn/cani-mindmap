<?php

if (defined('Class_Exception')) return;
define('Class_Exception', 1);

class CException 
{
	function CException($message, $file='', $line='')
	{			
		printf("<b>B��d: %s, plik %s, linia %d.</b>", $message, $file, $line);
		exit;
	}
}

?>