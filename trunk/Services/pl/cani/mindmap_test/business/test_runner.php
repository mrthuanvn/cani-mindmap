<?php
/*
 * Created on 2007-04-08
 *
 * @author Jan Klosinski (Can I) vanjan@gmail.com
 */
 
require_once( "simpletest/reporter.php" );

require_once( "LoginServiceTest.php" );
require_once( "MindmapServiceTest.php" );
require_once( "UserServiceTest.php" );

$tests = new GroupTest( "business tests" );
$tests->addTestCase( new LoginServiceTest() );
$tests->addTestCase( new MindmapServiceTest() );
$tests->addTestCase( new UserServiceTest() );
$tests->run( new HtmlReporter() ); 

?>
