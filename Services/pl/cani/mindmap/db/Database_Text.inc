<?php

	class CDatabase
	{
		var $pathfile	= "";
		var $records	= array();
		var $position	= 0;
		var $record	= "";
		
		function CDatabase($pathfile)
		{
			if ( file_exists($pathfile) )
			{
				$handle = fopen($pathfile, "r");
				$data = fread($handle, filesize($pathfile));
				fclose($handle);
				
				if ( strlen(trim($data))==0 )
					$records = array();
				else
				{
					$this->records = explode("|", $data);
					for ( $i=0; $i<count($this->records); ++$i )
						$this->records[$i] = str_replace("&brk;", "|", $this->records[$i]);
				}
			}
			else
				$records = array();
				
			$this->pathfile = $pathfile;
		}
		
		function reset()
		{
			$this->position = 0;
		}
		
		function next()
		{
			if ( $this->position >= count($this->records) )
				return false;
				
			$this->record = $this->records[$this->position];
			
			++$this->position;
			
			return true;
		}
		
		function query($recNo)
		{
			$this->record = $this->records[intval($recNo)];
		}
		
		function insert($value)
		{
			$this->records[] = $value;
		}
		
		function update($recNo, $value)
		{
			$this->records[intval($recNo)] = $value;
			if ( $this->position == intval($recNo) )
				$this->record = $value;
		}
	
		function delete($recNo)
		{
			unset($this->records[intval($recNo)]);
			$this->records = array_values($this->records);
		}
		
		function deleteAll($recNos)
		{		
			reset ($recNos);
			while (list ($key, $val) = each ($recNos)) 
      				unset($this->records[intval($key)]);
			
			$this->records = array_values($this->records);
		}
		
		function save()
		{
			for ( $i=0; $i<count($this->records); ++$i )
				$this->records[$i] = str_replace("|", "&brk;", $this->records[$i]);
			$data = implode("|", $this->records);
			
			$handle = fopen($this->pathfile, "w+");
			rewind($handle);
			fwrite($handle, $data);
			fclose($handle);
		}
	}

?>