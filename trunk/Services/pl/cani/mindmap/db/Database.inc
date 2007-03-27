<?php

global $g_config;
require_once( WebOrbServicesPath . "pl/cani/mindmap/config.php" );
require_once( WebOrbServicesPath . "pl/cani/mindmap/db/Database_" . $g_config[ "dbType" ] . ".inc" );

class CDB extends CDatabase
{
	function CDB()
	{
		global $g_config;
		
		$this->CDatabase($g_config["dbName"], $g_config["dbHost"], $g_config["dbUser"], $g_config["dbPassword"]);
		
		if( strcasecmp($g_config["dbType"], "PgSQL")==0 )
			$this->query("SET DATESTYLE TO 'ISO'");
	}

	function deleteID($table, $id, $field="id")
	{
		$sql = sprintf("DELETE FROM %s WHERE %s=%s", $table, $field, $id);
		$this->query($sql);
	}

	function deleteAllKeys($table, &$arr, $field="id")
	{
		if ( !is_array($arr) )
			return;
			
		reset ($arr);
		if (list ($key, $val) = each ($arr)) 
		{
			$id = $key;

			$sql = sprintf("DELETE FROM %s WHERE %s IN (", $table, $field);

			while (list ($key, $val) = each ($arr)) 
				$sql .= $key . ", ";

			$sql .= $id . ")";

			$this->query($sql);
		}
	}
	
	function selectAllKeys($table, &$arr, $field="id")
	{
		if ( !is_array($arr) )
			return;
			
		reset ($arr);
		if (list ($key, $val) = each ($arr)) 
		{
			$id = $key;

			$sql = sprintf("SELECT * FROM %s WHERE %s IN (", $table, $field);

			while (list ($key, $val) = each ($arr)) 
				$sql .= $key . ", ";

			$sql .= $id . ")";

			$this->query($sql);
		}
	}

	function executeForAllKeys($table, &$arr, $field="id", $callback=false)
	{
		if ( !is_array($arr) )
			return;
			
		reset ($arr);
		if (list ($key, $val) = each ($arr)) 
		{
			$id = $key;

			$sql = sprintf("SELECT * FROM %s WHERE %s IN (", $table, $field);

			while (list ($key, $val) = each ($arr)) 
				$sql .= $key . ", ";

			$sql .= $id . ")";

			$this->query($sql);
		}
		
		if ( $callback )
			while ( $this->nextRecord() )
				$callback($this->record);			
	}

	function loadList($sql, $keyName, $valueName, &$selected)
	{
		$this->query($sql);
		$lista = array();
		if ( $this->nextRecord() )
		{
			$selected = $this->record[$keyName];
			$lista[$this->record[$keyName]] = $this->record[$valueName];
			
			while ( $this->nextRecord() )
				$lista[$this->record[$keyName]] = $this->record[$valueName];
		}
		else
			$selected = "";
		
		return $lista;
	}

	function loadListSel($sql, $keyName, $valueName, &$selected, $column_sel)
	{
		$this->query($sql);
		$lista = array();
		$selected = "";

		while ( $this->nextRecord() )
		{
			$lista[$this->record[$keyName]] = $this->record[$valueName];

			if ( $this->record[$column_sel]!=0 )
				$selected = $this->record[$keyName];
		}
		
		return $lista;
	}
}

?>