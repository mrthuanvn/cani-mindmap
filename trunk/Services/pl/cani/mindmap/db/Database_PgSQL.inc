<?php

class CDatabase 
{
	/* public: result array and current row number */
	var $record   = array();
	var $row;

  	/* private: link and query handles */
  	var $linkId  = 0;
  	var $queryId = 0;
  	
  	var $port;

  	/* public: constructor */
  	function CDatabase($database, $host, $user, $password)
  	{
    		$this->connect($database, $host, $user, $password);
  	}

  	/* public: some trivial reporting */
  	function linkId() 
  	{
    		return $this->linkId;
  	}

  	function queryId() 
  	{
    		return $this->queryId;
  	}	

  	function connect($database, $host, $user, $password) 
  	{  		
	  	if ( 0 == $this->linkId ) 
	  	{
		
			if ( isset($this->port) )
				$cstr = sprintf('dbname=%s host=%s port=%d user=%s password=%s',
							$database, $host, $this->port, $user, $password);
			else
				$cstr = sprintf('dbname=%s host=%s user=%s password=%s',
							$database, $host, $user, $password);
		  
		  	$this->linkId = pg_pconnect($cstr);
		  	if (!$this->linkId)
			  	new CException("linkId == false, pconnect failed");
	  	}

    		return $this->linkId;
  	}

  	function query($query) 
  	{
  		if ( is_object($query) )
  			$queryString = $query->getSQL();
  		else
  			$queryString = $query;
  		
    		$this->queryId = @pg_Exec($this->linkId, $queryString);
    		if (!$this->queryId)
    			new CException(pg_ErrorMessage($this->linkId)."<br>".$queryString, __FILE__, __LINE__);

    		$this->row   = 0;

    		return $this->queryId;
  	}
  
  	function nextRecord() 
  	{
    		$this->record = @pg_fetch_array($this->queryId, $this->row++);
    
    		$stat = is_array($this->record);
    
    		if ( !$stat ) 
    		{
      			pg_freeresult($this->queryId);
      			$this->queryId = 0;
    		}
    		
    		return $stat;
  	}

  	function seek($pos) 
  	{
    		$this->row = $pos;
  	}

  	function lock($table, $mode = "write") 
  	{
    		if ($mode == "write") 
      			$result = pg_Exec($this->linkId, "lock table $table");
    		else 
      			$result = 1;
    		
    		return $result;
  	}
  
  	function unlock() 
  	{
    		return pg_Exec($this->linkId, "commit");
	}

  	function affectedRows() 
  	{
    		return pg_cmdtuples($this->queryId);
  	}

  	function numRows() 
  	{
    		return pg_numrows($this->queryId);
  	}

  	function numFields() 
  	{
    		return pg_numfields($this->queryId);
  	}

  	function nr() 
  	{
    		return pg_numrows($this->queryId);
  	}

  	function nf() 
  	{
    		return pg_numfields($this->queryId);
  	}

  	function f($Name) 
  	{
    		return $this->Record[$Name];
  	}

	function lastInsertId($table, $field="id")
	{
		$oid = pg_getlastoid($this->queryId);

		$sql = sprintf("SELECT %s FROM %s WHERE oid=%s", $field, $table, $oid);
		$this->query($sql);
		$this->nextRecord();

		return $this->record[$field];
	}
}

?>
