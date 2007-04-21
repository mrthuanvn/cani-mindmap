<?php
/*
 * Created on 2007-04-08
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */
 
require_once( "simpletest/reporter.php" );

require_once( "MySQLMindmapDAOTest.php" );
require_once( "MySQLUserDAOTest.php" );

$tests = new GroupTest( "mysql dao tests" );
$tests->addTestCase( new MySQLMindmapDAOTest() );
$tests->addTestCase( new MySQLUserDAOTest() );
$tests->run( new HtmlReporter() ); 

?>
