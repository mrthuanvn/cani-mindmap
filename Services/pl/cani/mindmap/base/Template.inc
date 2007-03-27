<?php

/**
	xtemplate class 0.2.4-1
	html generation with templates - fast & easy
	@author copyright (c) 2000 barnabßs debreceni [cranx@scene.hu]
	latest version always available at http://phpclasses.upperdesign.com/browse.html/package/62

	tested with php 3.0.11

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public License
	version 2.1 as published by the Free Software Foundation.

	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU Lesser General Public License for more details at 
	http://www.gnu.org/copyleft/lgpl.html
  
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/

class CTemplate {

var $filecontents;			# <i>String</i> raw contents of template file
var $blocks;				# <i>Array</i> unparsed blocks
var $parsed_blocks;			# <i>Array</i> parsed blocks
var $block_parse_order;		# <i>Array</i> block parsing order for recursive parsing (sometimes reverse:)
var $sub_blocks;			# <i>Array</i> store sub-block names for fast resetting
var $VARS;					# <i>Array</i> variables array

var $file_delim;			# <i>String</i> regexp for file includes
var $block_start_delim;		# <i>String</i> block start delimiter
var $block_end_delim;		# <i>String</i> block end delimiter
var $block_start_word;		# <i>String</i> block start word
var $block_end_word;		# <i>String</i> block end word - this makes the delimiters look like: &lt;!-- BEGIN: block_name --&gt; if you use my syntax.

var $NULL_STRING;			# <i>Array</i> null string for unassigned vars "VARNAME"=>"STRING"
var $NULL_BLOCK;			# <i>Array</i> null string for unassigned blocks "BLOCKNAME"=>"STRING"
var $mainblock;				# <i>String</i>
var $ERROR;					# <i>String</i>
var $AUTORESET;				# <i>int</i> auto-reset sub blocks
var $EXCLUDE_AUTORESET;

/**
	constructor
	@param $file <i>String</i> path and filename
	@param $mainblock <i>String</i> mainblock name
				(default: "main")
*/

function CTemplate ($file,$mainblock="main") {
	$this->parsed_blocks	=array();
	$this->block_parse_order=array();
	$this->sub_blocks		=array();
	$this->VARS			=array();
	
	global $g_sys;
	$this->assign("SYS", $g_sys);

	$this->file_delim=			"/\{FILE\s*\"(.*?)\"\s*\}/m";
	$this->block_start_delim=	"<!-- ";			
	$this->block_end_delim=		"-->";				
	$this->block_start_word=	"BEGIN:";			
	$this->block_end_word=		"END:";				

	$this->NULL_STRING=	array(""=>"");				
	$this->NULL_BLOCK=	array(""=>"");				
	$this->ERROR=		"";							
	$this->AUTORESET=	1;			
	$this->EXCLUDE_AUTORESET = array();				

	
	
	$this->mainblock	=	$mainblock;
	$this->filecontents	=	$this->r_getfile($file);	/* read in template file */
	$this->blocks		=	$this->maketree($this->filecontents,$mainblock);	/* preprocess some stuff */
	//$this->scan_globals();
}

/**
	assign a variable
	@param $name <i>String</i> variable name
	@param $val <i>Array</i> variable value, mixed or Array
				(default: "")
*/

function assign ($name,$val="") { # public
	if (gettype($name)=="array") {
		while (list($k,$v)=each($name)) {
			$this->prepareNoHtml($v);
			$this->VARS[$k]=$v;
		}
	} else {
		$this->prepareNoHtml($val);
		$this->VARS[$name]=$val;
	}
}

function prepareNoHtml(&$var)
{
	if (gettype($var)=="array")
	{
		while (list($k,$v)=each($var))
			$var[$k] = htmlspecialchars($v);
	} 
	else
		$var = htmlspecialchars($var);
}

function assignHtml($name,$val="") { # public
	if (gettype($name)=="array") {
		while (list($k,$v)=each($name)) {
			$this->VARS[$k]=$v;
		}
	} else {
		$this->VARS[$name]=$val;
	}
}

function prepareString($string)
{
	$string = htmlSpecialChars($string);

	$string = str_replace("//n", "<br>", $string);
	$string = eregi_replace('\(r\)', "&reg;", $string);
	$string = eregi_replace('\(tm\)', "&trade;", $string);
	$string = eregi_replace('\(thorn\)', "&thorn;", $string);
	$string = eregi_replace('\(c\)', "&copy;", $string);
	$string = ereg_replace("[*]([^*]*)[*]", "<b>\\1</b>", $string);
	$string = ereg_replace("[@]([^@]*)[@]", "<u>\\1</u>", $string);
	$string = ereg_replace("_([^_]*)_", "<i>\\1</i>", $string);
	$string = ereg_replace("[#]([^#]*)[#]([^#]*)[#]", "<a href='\\1'>\\2</a>", $string);
	$string = ereg_replace("[!]([^!]*)[!]([^!]*)[!]", "<a href='\\1' target='_blank'>\\2</a>", $string);
	$string = nl2br($string);
	
	return $string;
}

function prepareVariable(&$var)
{
	if (gettype($var)=="array")
	{
		while (list($k,$v)=each($var))
			$var[$k]=$this->prepareString($v);
	} 
	else
		$var=$this->prepareString($var);
}

function assignPrepared($name,$val="")
{
	if (gettype($name)=="array") {
		while (list($k,$v)=each($name)) {
			$this->prepareVariable($v);
			$this->VARS[$k]=$v;
		}
	} else {
		$this->prepareVariable($val);
		$this->VARS[$name]=$val;
	}
}

/**
	assign urls
	@param $name <i>String</i> variable name
	@param $val <i>Array</i> variable value, mixed or Array
				(default: "")
*/

function assignURLs($aliasesURLs) 
{
	global $pager;
	
	$urls = array();
	while (list($key, $val)=each($aliasesURLs))
	{
		$urls[$key] = $pager->getURL($val);
	}
	
	$this->VARS["URL"] = $urls;
}

/**
	parse a block
	@param $bname <i>String</i> block name
*/

function parse ($bname) { # public
	if( empty($this->parsed_blocks[$bname]) )
		$this->parsed_blocks[$bname] = '';

	$copy=$this->blocks[$bname];
	if (empty($this->blocks[$bname]))
		new CException(sprintf("parse: blok o nazwie [%s] nie istnieje", $bname), __FILE__, __LINE__);
//	preg_match_all("/\{([A-Za-z0-9\._\*\/\+-]+?)}/",$this->blocks[$bname],$var_array);
	preg_match_all("/\{([A-Za-z0-9\._]+?)}/",$this->blocks[$bname],$var_array);
	$var_array=$var_array[1];
	while (list($k,$v)=each($var_array)) {
		$sub=explode(".",$v);
		if ($sub[0]=="_BLOCK_") {
			unset($sub[0]);
			$bname2=implode(".",$sub);
			if (isset($this->parsed_blocks[$bname2]))
				$var=$this->parsed_blocks[$bname2];
			else
				$var='';
			$nul=(empty($this->NULL_BLOCK[$bname2])) ? $this->NULL_BLOCK[""] : $this->NULL_BLOCK[$bname2];
			$var=(empty($var) && !is_int($var))?$nul:$var;
			$copy=ereg_replace("\{".$v."\}","$var",$copy);
		} else if ($sub[0]=="_SECTION_") {
			unset($sub[0]);
			$bname2=implode(".",$sub);
			$db = new CDB;
			$sec = new Section($bname2, $db);
			$sec->build($db);
			$var = $sec->text();
			$nul=(empty($this->NULL_BLOCK[$bname2])) ? $this->NULL_BLOCK[""] : $this->NULL_BLOCK[$bname2];
			$var=(empty($var) && !is_int($var))?$nul:$var;
			$copy=ereg_replace("\{".$v."\}","$var",$copy);
		} else {
			$var=$this->VARS;
			while(list($k1,$v1)=each($sub))
				$var=$var[$v1];
			$nul=(empty($this->NULL_STRING[$v])) ? ($this->NULL_STRING[""]) : ($this->NULL_STRING[$v]);
			$var=(empty($var) && !is_int($var) && !is_double($var) && !is_string($var))?$nul:$var;
			$copy=ereg_replace("\{".$v."\}","$var",$copy);
		}
	} 	
	$this->parsed_blocks[$bname].=$copy;
	// reset sub-blocks 
	if ($this->AUTORESET) {
		if (!empty($this->sub_blocks[$bname])) {
			reset($this->sub_blocks[$bname]);
			while (list($k,$v)=each($this->sub_blocks[$bname]))
				$this->reset($v);
		}
	}
}

/**
	returns the parsed text for a block, including all sub-blocks.
	@param $bname <i>String</i> block name
*/

function rparse($bname) { # public
		if (!empty($this->sub_blocks[$bname])) {
			reset($this->sub_blocks[$bname]);
			while (list($k,$v)=each($this->sub_blocks[$bname])) {
				if (!empty($v)) 
					$this->rparse($v,$indent."\t");
			}
		}
		$this->parse($bname);
}

/**
	inserts a loop ( call assign & parse )
	@param $bname <i>String</i> block name
	@param $var <i>String</i> variable name
	@param $value <i>Array</i> variable value, mixed or Array
				(default: "")
*/

function insertLoop($bname,$var,$value="") { # public
	$this->assign($var,$value);		
	$this->parse($bname);
}

/**
	returns the parsed text for a block
	@param $bname <i>String</i> block name
	@return <i>String</i> parsed block
*/

function text($bname) { # public
	if (empty($bname))
		$bname=$this->mainblock;
	return $this->parsed_blocks[$bname];
}

/**
	prints the parsed text
	@param $bname <i>String</i> block name
*/

function out ($bname) { # public
	echo $this->text($bname);
}

/**
	resets the parsed text
	@param $bname <i>String</i> block name
*/

function reset ($bname) { # public
	if ( !in_array($bname, $this->EXCLUDE_AUTORESET) ) {
		$this->parsed_blocks[$bname]="";
	}
}

/**
	returns true if block was parsed, false if not
	@param $bname <i>String</i> block name
	@return <i>boolean</i>
*/

function parsed ($bname) { # public
	return (!empty($this->parsed_blocks[$bname]));
}

/**
	sets the string to replace in case the var was not assigned
	@param $str <i>String</i> replace string
	@param $bname <i>String</i> variable name
*/

function SetNullString($str,$varname="") { # public
	$this->NULL_STRING[$varname]=$str;
}

/**
	sets the string to replace in case the block was not parsed
	@param $str <i>String</i> replace string
	@param $bname <i>String</i> block name
*/

function SetNullBlock($str,$bname="") { # public
	$this->NULL_BLOCK[$bname]=$str;
}

/**
	sets AUTORESET to 1. (default is 1)
	if set to 1, parse() automatically resets the parsed blocks' sub blocks
	(for multiple level blocks)
*/

function set_autoreset() { # public
	$this->AUTORESET=1;
}

/**
	sets AUTORESET to 0. (default is 1)
	if set to 1, parse() automatically resets the parsed blocks' sub blocks
	(for multiple level blocks)
*/

function clear_autoreset() { # public
	$this->AUTORESET=0;
}

/**
	scans global variables
*/

function scan_globals() { # public
	reset($GLOBALS);
	while (list($k,$v)=each($GLOBALS))
		$GLOB[$k]=$v;
	$this->assign("PHP",$GLOB);	/* access global variables as {PHP.HTTP_HOST} in your template! */
}


/**
	generates the array containing to-be-parsed stuff:
  $blocks["main"],$blocks["main.table"],$blocks["main.table.row"], etc.
	also builds the reverse parse order.
	@param $con <i>String</i>
	@param $block <i>String</i>
	@return <i>Array</i>
*/

function maketree($con,$block) { # private
	$con2=explode($this->block_start_delim,$con);
	$level=0;
	$block_names=array();
	$blocks=array();
	reset($con2);
	while(list($k,$v)=each($con2)) {
		$patt="($this->block_start_word|$this->block_end_word)[[:blank:]]*([0-9a-zA-Z\_]+)[[:blank:]]*$this->block_end_delim(.*)";
		if (eregi($patt,$v,$res)) {
			// $res[1] = BEGIN or END
			// $res[2] = block name
			// $res[3] = kinda content
			if ($res[1]==$this->block_start_word) {
				$parent_name=implode(".",$block_names);
				$block_names[++$level]=$res[2];							/* add one level - array("main","table","row")*/
				$cur_block_name=implode(".",$block_names);	/* make block name (main.table.row) */
				$this->block_parse_order[]=$cur_block_name;	/* build block parsing order (reverse) */
		    	if( empty($blocks[$cur_block_name]) )
					$blocks[$cur_block_name] = '';
				$blocks[$cur_block_name].=$res[3];					/* add contents */
				$blocks[$parent_name].="{_BLOCK_.$cur_block_name}";	/* add {_BLOCK_.blockname} string to parent block */
				$this->sub_blocks[$parent_name][]=$cur_block_name;		/* store sub block names for autoresetting and recursive parsing */
				$this->sub_blocks[$cur_block_name]=array();		/* store sub block names for autoresetting */
			} else if ($res[1]==$this->block_end_word) {
				unset($block_names[$level--]);
				$parent_name=implode(".",$block_names);
				$blocks[$parent_name].=$res[3];	/* add rest of block to parent block */
  		}
		} else { /* no block delimiters found */
    	$cur_block_name=implode(".",$block_names);
    	if( empty($blocks[$cur_block_name]) )
			$blocks[$cur_block_name] = '';
		$blocks[$cur_block_name].=$this->block_start_delim.$v;
		}
	}
return $blocks;	
}



/**
	gets error
*/

function get_error()	{ # private
	return ($this->ERROR=="")?0:$this->ERROR;
}

/**
	sets error
	@param $str <i>String</i>
*/
function set_error($str)	{ # private
	$this->ERROR=$str;
}

/**
	returns the contents of a file
	@param $file <i>String</i> filename
*/

function getfile($file) { # private
	if (empty($file))
		new CException("pusta nazwa pliku", __FILE__, __LINE__);

	if (is_file($file)) {
		if (!($fh=fopen($file,"r")))
			new CException(sprintf("nie mogê otworzyæ pliku '%s'", $file), __FILE__, __LINE__);

		$file_text=fread($fh,filesize($file));
		fclose($fh);
	} else
		new CException(sprintf("plik '%s' nie istnieje", $file), __FILE__, __LINE__);
		
	return $file_text;
}

/**
	recursively gets the content of a file with {FILE "filename.tpl"} directives
	@param $file <i>String</i> filename
*/

function r_getfile($file) { # private
			
	$file = str_replace("{LANG}", getLanguage(), $file);

	$text=$this->getfile($file);
	while (preg_match($this->file_delim,$text,$res)) {
		$text2=$this->getfile($res[1]);
		$text=ereg_replace($res[0],$text2,$text);
	}
	return $text;
}

/**
	returns an array containing sub-blocks names.
	Added by Damian Gajda - e-point S.A. 2000
	@param $bname <i>String</i> block name
	@return <i>Array</i> sub-blocks names "main.block.subblock"
*/

function getSubBlockNames ($bname) { # public
	if (!empty($this->sub_blocks[$bname]))
		return $this->sub_blocks[$bname];
	else
		return array();
}

}

/*
	TODO
	-syntax checker function
	-better error handling
	-browser-dependent if-else stuff

	-ereg-ek preg-re
	-{ } -> [ ] (fully customizable)
	-hierarchikus lofaszok (ilja hehenkamp)
	-base dir (craig mcdaniel)
	-template from dbase (marc burgauer)
	-empty->!isset (shaun martinec)

*/


?>
