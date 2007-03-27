<?php

	function putContent(&$tpl, $header, $content, $name="content")
	{
		$tpl->assignHtml("content", $content);
		$tpl->assignPrepared("header", $header);
		$tpl->parse("main.".$name);
	}

	function getFile($fname)
	{
		$fp = @fopen($fname, 'r');
		if ( $fp )
		{
			$content = @fread($fp , filesize($fname));
			@fclose($fp);
		}
		else
			$content = "";

		return $content;
	}

	function putFile($fname, $data)
	{
		$fp = @fopen($fname, 'w');
		if ( $fp )
		{
			@fwrite($fp , $data);
			@fclose($fp);
		}
	}

	function sendFile($file, $filename, $cheat=false)
	{
		global $HTTP_USER_AGENT;

		$filesize = strlen($file);
		if ($cheat && preg_match("'MSIE'i", $HTTP_USER_AGENT)) 
		{
			$filename = ereg_replace ("(.*)/", "", $filename);
			$filename = ereg_replace ("\.(.*)", "", $filename);

		}
		header('Content-Type: application/download');
		header("Content-Disposition: inline; filename=${filename}"); 
		header("Content-Description: ".$filename);
		header("Pragma: no-cache"); 
		header("Expires: 0"); 
		header("Content-Length: $filesize");  

		echo $file;
	}
	
	function sendNoCache()
	{
		$actualTime = time();
		$actualTimeStr = gmdate("D, d M Y H:i:s", $actualTime);
		
		header("Expires: " . $actualTimeStr . " GMT");
		header("Last-Modified: " . $actualTimeStr . " GMT");
		header("Cache-Control: no-cache");
		header("Cache-Control: no-store");
		header("Cache-Control: max-age=0");
	}
	
	function getLanguage()
	{
		return 'pl';
	}		

	function generatePassword ($length = 8)
	{
	
	  // start with a blank password
	  $password = "";
	
	  // define possible characters
	  $possible = "0123456789bcdfghjkmnpqrstvwxyz"; 
	    
	  // set up a counter
	  $i = 0; 
	    
	  // add random characters to $password until $length is reached
	  while ($i < $length) { 
	
	    // pick a random character from the possible ones
	    $char = substr($possible, mt_rand(0, strlen($possible)-1), 1);
	        
	    // we don't want this character if it's already in the password
	    if (!strstr($password, $char)) { 
	      $password .= $char;
	      $i++;
	    }
	
	  }
	
	  // done!
	  return $password;
	}
	
	function postDataKey($key, &$val)
	{
		if ( gettype($val)=="array" )
		{
			foreach( $val as $inkey => $inval )
			{
				postDataKey($key . "[" . $inkey . "]", $inval);
			}
		}
		else
		{
			printf('<input type="hidden" name="%s" value="%s" />', $key, $val);
		}
	}
	
	function postData($script, $data, $bgcolor=0)
	{
		if ( $bgcolor === 0 )
		{
			global $g_config;
			$bgcolor = $g_config['postBgColor'];
		}
		echo "<html>";
		printf('<body BGCOLOR="%s" onload="document.forms[0].submit();">', $bgcolor);
		printf('<form method="post" action="%s">', $script);
		reset($data);
		while (list($key, $val) = each($data)) 
		{
			postDataKey($key, $val);
		}
		echo "</form>";
		echo "</body>";
		echo "</html>";
	}
	
	function removeDir($dir)
	{
		if ( is_dir($dir) )
		{
			$handle = dir($dir);
			if ( $handle ) 
			{
				while (false !== ($entry = $handle->read())) 
				{
					if ( $entry!='.' && $entry!='..' )
					{
				  		removeDir($dir . '/' . $entry);
				  	}
				}
				
				$handle->close();
			}
			
			rmdir($dir);
		}
		else if ( is_file($dir) )
		{
			unlink($dir);
		}
	}
	
	function clearDir($dir) 
	{
		if ( is_dir($dir) )
		{
			$handle = dir($dir);
			if ( $handle ) 
			{
				while (false !== ($entry = $handle->read())) 
				{
					if ( $entry!='.' && $entry!='..' )
					{
				  		removeDir($dir . '/' . $entry);
				  	}
				}
				
				$handle->close();
			}
		}
	}
	
	function moveFiles($from, $to)
	{
		if ( is_dir($from) )
		{
			$handle = dir($from);
			if ( $handle ) 
			{
				while (false !== ($entry = $handle->read())) 
				{
					if ( $entry!='.' && $entry!='..' )
					{
				  	rename($from . '/' . $entry, $to . '/' . $entry);
				  }
				}
				
				$handle->close();
			}
		}
	}
?>