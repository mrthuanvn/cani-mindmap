package com.adobe.cairngorm
{
	import mx.utils.StringUtil;
	import mx.resources.ResourceBundle;
	
	public class CairngormError extends Error
	{
		[ResourceBundle("CairngormMessages")] 
	 	private static var rb : ResourceBundle;
		
		public function CairngormError( errorCode : String, ... rest )
		{
			super( formatMessage( errorCode, rest.toString() ) );
		}
		
		private function formatMessage( errorCode : String, ... rest ) : String
		{
			var message : String =
				StringUtil.substitute(
					resourceBundle.getString( errorCode ), rest );
			
			return StringUtil.substitute(
				"{0}: {1}",
				errorCode,
				message);
		}
		
		protected function get resourceBundle() : ResourceBundle
		{
			return rb;
		}
	}
}