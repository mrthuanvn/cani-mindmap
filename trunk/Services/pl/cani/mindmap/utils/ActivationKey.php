<?php

require_once( WebOrbServicesPath . "pl/cani/mindmap/vo/UserVO.php" );

class ActivationKey {

	public static function generate( $user ) {
		return md5( $user->forname . $user->surname . $user->email );
	}

}

?>
