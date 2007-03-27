<?php

//define( "WebOrbServicesPath", "C:\\Program Files\\xampp\\htdocs\\Services\\" );

require_once( WebOrbServicesPath . 'pl/cani/mindmap/base/Exception.inc' );
require_once( WebOrbServicesPath . 'pl/cani/mindmap/base/Template.inc' );
require_once( WebOrbServicesPath . 'pl/cani/mindmap/base/Functions.inc' );
require_once( WebOrbServicesPath . 'pl/cani/mindmap/base/Section.inc' );

require_once( WebOrbServicesPath . 'pl/cani/mindmap/vo/UserVO.php' );


class EmailService {

	public static function sendActivationEmail( $user, $locale = "en_US" ) {
		$tpl = new CTemplate( "../locale/$locale/EmailService.tpl" );
		$tpl->parse( "activationEmailSubject" );
		$tpl->assign( "url", "http://localhost/Weborb/mindmap/mindmap.html/#activation,$user->activationKey" );
		$tpl->assign( "activationKey", $user->activationKey );
		$tpl->parse( "activationEmailBody" );
		
		$from = "postmaster@localhost";
		$to = $user->email;
		$subject = $tpl->text( "activationEmailSubject" );
		$body = $tpl->text( "activationEmailBody" );
		$headers = "From: $from\r\n" .
			"MIME-Version: 1.0\r\n" .
			"Content-Type: text/plain; charset=\"utf-8\"\r\n" .
			"Content-Transfer-Encoding: 8bit\r\n\r\n";

//		TODO: włączyć wysyłanie maili na serwerze		
//		mail( $to, $subject, $body, $headers );
	}

}

//$service = new EmailService();
//$user = new UserVO();
//$user->email = "vanjan@gmail.com";
//$service->sendActivationEmail( $user, "pl_PL" );

?>
