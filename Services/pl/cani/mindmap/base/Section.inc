<?php

class Section
{
	function Section($path_or_id, &$db)
	{
		if ( $path_or_id != 0 )
		{
			$section_id = $path_or_id;
		}
		else
		{
			$section_id = $this->findSectionId($path_or_id	, $db);
		}
		return $this->load($section_id, $db);
	}
	
	function findSectionId($path, &$db)
	{
		$section_id = 0;
		$target_section_id = 0;

		$names = explode(".", $path);
		for ( $i=0; $i<count($names); ++$i )
		{
			$sql = sprintf("SELECT section_id, target_section_id FROM section WHERE parent_section_id=%d AND name='%s'", 
											$section_id, $names[$i]);
			$db->query($sql);
			if ( !$db->nextRecord() )
			{
				die("section not found: " . $path);
			}
			
			$section_id = $db->record['section_id'];
			$target_section_id = $db->record['target_section_id'];
		}

		while ( $target_section_id != 0 )
		{
			$section_id = $target_section_id;

			$sql = sprintf("SELECT target_section_id FROM section WHERE section_id=%d", $target_section_id);
			$db->query($sql);
			if ( !$db->nextRecord() )
			{
				die("link section not found: " . $path);
			}

			$target_section_id = $db->record['target_section_id'];
		}
		
		return $section_id;
	}
	
	function load($section_id, &$db)
	{
		$this->section_id = $section_id;
		
		$sql = sprintf("SELECT header, body, footer FROM section WHERE section_id=%d", $this->section_id);
		$db->query($sql);
		if ( !$db->nextRecord() )
		{
			return false;
		}
		
		$this->header = $db->record['header'];
		$this->footer = $db->record['footer'];
		$this->body = $db->record['body'];
		
		$this->parse($db);
	}
	
	function parse(&$db)
	{
		$this->headerData = $this->parseString($this->header, $db);
		$this->footerData = $this->parseString($this->footer, $db);
		$this->bodyData = $this->parseString($this->body, $db);
	}
	
	var $TEXT_TYPE = 0;
	var $VAR_TYPE = 1;
	var $SECTION_TYPE = 2;
	
	function parseString(&$text, &$db)
	{
		$chunks = explode("{", $text);
		$result = array(0=>array(), 1=>array());
		
		if ( strlen($chunks[0]) > 0 )
		{
			$result[0][] = $this->TEXT_TYPE;
			$result[1][] = $chunks[0];
		}
		
		$count = count($chunks);
		for ( $i=1; $i<$count; ++$i )
		{
			$pos = strpos($chunks[$i], "}");
			if ( $pos === false )
			{
				$result[0][] = $this->TEXT_TYPE;
				$result[1][] = "{".$chunks[i];
			}
			else
			{
				$var = substr($chunks[$i], 0, $pos);
				$colon = strpos($var, ":");
				if ( $colon === false )
				{
					$result[0][] = $this->VAR_TYPE;
					$result[1][] = substr($chunks[$i], 0, $pos);
				}
				else
				{
					$result[0][] = $this->SECTION_TYPE;
					
					$section_type = substr($chunks[$i], 0, $colon);
					$section_name = substr($chunks[$i], $colon + 1, $pos - $colon - 1);
					$result[1][] = $this->createSection($section_type, $section_name, $db);
				}
				
				if ( $pos < strlen($chunks[$i])-1 )
				{
					$result[0][] = $this->TEXT_TYPE;
					$result[1][] = substr($chunks[$i], $pos+1);
				}
			}
		}
		
		return $result;
	}
	
	function createSection($type, $name, &$db)
	{
		if ( $type == "section" )
		{
			return new Section($name, $db);
		}
		else if ( $type == "children" )
		{
			return new SectionChildren($name, $db);
		}
		else
		{
			echo "<b>UNKNOWN SECTION TYPE: " . $type . "</b>";
			return NULL;
		}
	}
	
//========================================================================================================================================
	function registerVars()
	{
		$this->vars = array();

		$this->registerImages();
	}
	
	function registerImages()
	{
		global $g_config;

		$path = 'sections/' . $this->section_id;
		$handle = dir($path);
		$top = $g_config['site_root'] . "/sections/" . $this->section_id . "/";
		
		if ( $handle )
		{
			while (false !== ($entry = $handle->read())) 
			{
				if ( $entry!='.' && $entry!='..' )
				{
			  	if ( ereg("([0-9]{8})[.](.*)", $entry, $regs)) 
			  	{
						$this->vars['zdj' . $regs[1]] =  $top . rawurlencode($entry);
					}
			  }
			}
		}
		
		$handle->close();	
	}
	
	function build(&$db)
	{
		$this->registerVars();
		$this->text = $this->buildString($this->headerData, $db) .
									$this->buildString($this->bodyData, $db) .
									$this->buildString($this->footerData, $db);
	}
	
	function &buildString(&$data, &$db)
	{
		$count = count($data[0]);
		$result = "";
		
		for ( $i=0; $i<$count; ++$i )
		{
			$type = $data[0][$i];
			if ( $type == $this->TEXT_TYPE )
			{
				$result .= $data[1][$i];		
			}
			else if ( $type == $this->VAR_TYPE )
			{
				$result .= $this->vars[$data[1][$i]];
			}
			else if ( $type == $this->SECTION_TYPE )
			{
				$data[1][$i]->build($db);
				$result .= $data[1][$i]->text();
			}
		}
		
		return $result;
	}
	
	function text()
	{
		return $this->text;
	}
}

//========================================================================================================================================

class SectionChildren extends Section
{
	function SectionChildren($path, &$db)
	{
		$this->children = array();

		$parent_section_id = parent::findSectionId($path, $db);
		$ids = array();		
		$sql = sprintf("SELECT section_id FROM section WHERE parent_section_id=%d ORDER BY item_no ASC", $parent_section_id);
		$db->query($sql);
		while ( $db->nextRecord() )
		{
			$ids[] = $db->record['section_id'];
		}

		foreach( $ids as $id )
		{
			$this->children[] = new Section($id, $db);
		}
	}
	
	function build(&$db)
	{
		$this->text = "";
		
		$count = count($this->children);
		for( $i=0; $i<$count; ++$i )
		{
			$this->children[$i]->build($db);
			$this->text .= $this->children[$i]->text;
		}
	}
}

?>