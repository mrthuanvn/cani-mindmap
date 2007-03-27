package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;
	
	import pl.cani.mindmap.events.RegistrationEvent;
	import pl.cani.mindmap.view.RegistrationForm;
	import pl.cani.mindmap.vo.UserVO;

	public class RegistrationFormHelper extends ViewHelper {
		
		public var formIsValid : Boolean = false;
	
		private var focussedFormControl : DisplayObject;
		
		public function RegistrationFormHelper( view : RegistrationForm ) {
			this.view = view;
		}
		
		public function addRegisteredEmailAndValidateForm( email : String ) : void {
			view.registeredEmailValidator.addRegisteredEmail( email );
			focussedFormControl = view.emailTxt;
			validate( view.registeredEmailValidator );
			view.focusManager.setFocus( view.emailTxt );
			view.emailTxt.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
		}
		
		public function register() : void {
        	var user : UserVO = new UserVO();
        	user.forname = view.fornameTxt.text;
        	user.surname = view.surnameTxt.text;
        	user.email = view.emailTxt.text;
        	user.password = view.password1Txt.text;
        	
        	var event : RegistrationEvent = new RegistrationEvent( user );
        	CairngormEventDispatcher.getInstance().dispatchEvent( event );
        }
		
		public function validateForm( event : Event ) : void {                    
            focussedFormControl = event.target as DisplayObject;    

            formIsValid = true;            

			validate( view.fornameValidator );
			validate( view.surnameValidator );
            validate( view.registeredEmailValidator );
            validate( view.password1Validator );                
            validate( view.password2Validator );       
            
            view.formIsValid = formIsValid;      
        }
 
        private function validate( validator : Validator ) : Boolean {
         	var validatorSource : DisplayObject = validator.source as DisplayObject;
            
			var suppressEvents : Boolean 
				= ( validatorSource != focussedFormControl );
            
            var event : ValidationResultEvent 
            	= validator.validate( null, suppressEvents ); 
                            
            var currentControlIsValid : Boolean 
            	= ( event.type == ValidationResultEvent.VALID );
             
            formIsValid = formIsValid && currentControlIsValid;
             
            return currentControlIsValid;
        }
		
	}
	
}