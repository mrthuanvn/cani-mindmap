<?php

class CDatabase 
{
	/* public: result array and current row number */
	var $record   = array();
	var $row;

  	/* private: link and query handles */
  	var $linkId  = 0;
  	var $queryId = 0;
  
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

  	/* public: connection management */
  	function connect($database, $host, $user, $password) 
  	{
	    	/* establish connection, select database */
    		if ( 0 == $this->linkId ) 
    		{
			$this->linkId = mysql_pconnect($host, $user, $password);
      			
      			if (!$this->linkId)
        			new CException(sprintf("pconnect('%s', '%s', \$password) nie uzyska³ po³±czenia", $host, $user), __FILE__, __LINE__);
      		}

      		if (!@mysql_select_db($database,$this->linkId)) 
       			new CException(sprintf("nie mogê u¿yæ bazy '%s'", $database), __FILE__, __LINE__);

    		return $this->linkId;
  	}

  	/* public: perform a query */
  	function query($query) 
  	{
  		if ( is_object($query) )
  			$queryString = $query->getSQL();
  		else
  			$queryString = $query;
  			
    		if ($this->queryId) 
    		{
      			@mysql_free_result($this->queryId);
      			$this->queryId = 0;
    		}

    		$this->queryId = @mysql_query($queryString, $this->linkId);
	    	if (!$this->queryId)
	    	{
	    		echo $query . "<br>";
	    		new CException(mysql_error(), __FILE__, __LINE__);
	    	}

    		$this->row   = 0;
    		
    		return $this->queryId;
  	}
  	
  	/* public: walk result set */
  	function nextRecord() 
  	{
    		$this->record = @mysql_fetch_array($this->queryId);
		++$this->row;

		$stat = is_array($this->record);
    		if ( !$stat )
    		{
      			@mysql_free_result($this->Query_ID);
      			$this->queryId = 0;
    		}
    		
    		return $stat;
  	}
  
  	/* public: position in result set */
  	function seek($pos = 0) 
  	{
    		$status = @mysql_data_seek($this->Query_ID, $pos);
    		if ($status)
      			$this->row = $pos;
    		else
    			new CException(sprintf("seek(%d) zawiód³: wynik ma %d wiersz(y)", $pos, $this->numRows()), __FILE__, __LINE__);

    		return;
  	}

  	/* public: table locking */
  	function lock($table, $mode="write") 
  	{
    		$res = @mysql_query("lock tables $table $mode", $this->Link_ID);
    		
    		if (!$res)
    			new CException(sprintf("lock('%s', '%s') zawiód³", $table, $mode), __FILE__, __LINE__);
    		
    		return $res;
  	}
  
  	function unlock() 
  	{
    		$res = @mysql_query("unlock tables");
    		if (!$res)
  			new CException("unlock('%s', '%s') zawiód³", __FILE__, __LINE__);
    		
    		return $res;
  	}

  	/* public: evaluate the result (size, width) */
  	function affectedRows() 
  	{
    		return @mysql_affected_rows($this->linkId);
  	}

  	function numRows() 
  	{
    		return @mysql_num_rows($this->queryId);
  	}

  	function numFields() 
  	{
    		return @mysql_num_fields($this->queryId);
  	}

  	/* public: shorthand notation */
  	function nf() 
  	{
    		return @mysql_num_fields($this->queryId);
  	}

  	function nr() 
  	{
    		return @mysql_num_rows($this->queryId);
  	}

  	function f($Name) 
  	{
    		return $this->record[$Name];
  	}
  	
  	function lastInsertId()
  	{
  		return mysql_insert_id($this->linkId);
  	}
  	
  	function nextSequence($table, $field)
  	{
  		$sql = sprintf("UPDATE %s SET %s=LAST_INSERT_ID(%s+1)", $table, $field, $field);
			$this->query($sql);
			return $this->lastInsertId();
  	}

	function formatDateHelper($year, $month, $day)
	{
		global $g_month_values, $g_day_values;
		
		$dow = date("w", mktime(0, 0, 0, $month, $day, $year));
		if ( $dow==0 )
			$dow = 7;

		return sprintf("%s, %d %s %s", $g_day_values[$dow], intval($day), $g_month_values[intval($month)], $year);
	}
	
	function formatDate($date)
	{
		preg_replace( "/([0-9]{4})[-]([0-9]{2})[-]([0-9]{2})/e", 
			'$formatted = CDatabase::formatDateHelper("\\1", "\\2", "\\3");', $date );
			
		return $formatted;
	}
	
	function renderDate(&$tpl, $day_row, $month_row, $year_row, $date)
	{
		CSelect::renderDays($tpl, $day_row, substr($date, 8, 2));
		CSelect::renderMonths($tpl, $month_row, substr($date, 5, 2));
		CSelect::renderYears($tpl, $year_row, substr($date, 0, 4));
	}

	function analyseDate($date, &$day, &$month, &$year)
	{
		$day = substr($date, 8, 2);
		$month = substr($date, 5, 2);
		$year = substr($date, 0, 4);
	}
	
	function quote($text)
	{
		return addSlashes($text);
	}
}

?>