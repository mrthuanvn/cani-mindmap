package pl.cani.mindmap.validators {
	
	import mx.validators.StringValidator;
	import mx.validators.ValidationResult;
	import mx.resources.ResourceBundle;
	import mx.utils.StringUtil;

	public class ActivationKeyValidator extends StringValidator	{

		[Inspectable]
		public var email : String;
		
		[ResourceBundle( name = "ActivationKeyValidator" )]
		private var rb : ResourceBundle;
		
		private var keys : Array = new Array(); // [ email : String, key : String ]
		
		override protected function doValidation( value : Object ) : Array {
			var results : Array = super.doValidation( value );
			
			if ( results.length > 0 ) {
				return results;
			}
			
			var valueKey : String = value as String;
			if ( keys[ email ] != undefined && valueKey != keys[ email ] ) {
				var result : ValidationResult = new ValidationResult( true, "", "",
					StringUtil.substitute( rb.getString( "message" ), email ) );
				results.push( result );
				return results;
			}			
			
			return results;
		}
		
		public function addActivationKey( email : String, activationKey : String ) : void {
			keys[ email ] = activationKey;
		}
		
	}
	
}