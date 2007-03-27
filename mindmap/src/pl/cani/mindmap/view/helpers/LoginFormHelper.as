package pl.cani.mindmap.view.helpers {
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;
	
	import pl.cani.mindmap.events.LoggingEvent;
	import pl.cani.mindmap.view.LoginForm;
	import pl.cani.mindmap.events.ActivationAndLoggingEvent;


	public class LoginFormHelper extends ViewHelper	{
	
		private var formIsValid : Boolean = false;
		
		private var focussedFormControl : DisplayObject;
	
	
		public function LoginFormHelper( view : LoginForm ) {
			this.view = view;
		}
		
		public function showUserDoesntExistError( email : String ) : void {
        	/* var point : Point = emailTxt.localToGlobal( new Point() );
        	var x : int = point.x + emailTxt.width;
        	var y : int = point.y;
        	var borderStyle : String = "errorTipRight";
        	var toolTip : ToolTip = ToolTipManager.createToolTip( 
        		"User doesn't exist", x, y, borderStyle, emailTxt );
        	toolTip.setStyle( "styleName", "errorTip" );
        	var errorColor : Object = emailTxt.getStyle( "errorColor" );
        	emailTxt.setStyle( "borderColor", errorColor );
        	emailTxt.setStyle( "themeColor", errorColor ); */
        
        	view.emailValidator.addNotRegisteredEmail( email );
        	focussedFormControl = view.emailTxt;
        	validate( view.emailValidator );
        	view.focusManager.setFocus( view.emailTxt );
        	view.emailTxt.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
        }
        
        public function showUserNotActivatedError( email : String, 
        		activationKey : String ) : void {
        	
        	var view : LoginForm = view as LoginForm;
        	
        	view.currentState = view.ACTIVATE_AND_LOG_IN_STATE;
        	view.invalidateSize();
        	view.invalidateDisplayList();
        	view.invalidateProperties();
        	
//        	view.emailValidator.addNotActivatedEmail( email );
        	view.activationKeyValidator.addActivationKey( email, activationKey );
        	
/*         	focussedFormControl = view.emailTxt;
        	validate( view.emailValidator );
        	view.emailTxt.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
 */        	
        	focussedFormControl = view.activationKeyTxt;
        	validate( view.activationKeyValidator );
        	view.activationKeyTxt.dispatchEvent( 
        		new MouseEvent( MouseEvent.MOUSE_OVER ) );

        	view.focusManager.setFocus( view.activationKeyTxt );
            view.formIsValid = false;
        }
        
        public function showWrongPasswordError( wrongPassword : String ) : void {
        	var view : LoginForm = view as LoginForm;

        	view.currentState = "";
        	
        	view.passwordValidator.addWrongPassword( wrongPassword );
        	focussedFormControl = view.passwordTxt;
        	validate( view.passwordValidator );

        	view.passwordTxt.dispatchEvent( 
        		new MouseEvent( MouseEvent.MOUSE_OVER ) );

        	view.focusManager.setFocus( view.passwordTxt );
            view.formIsValid = false;
        }
    
    	public function resetForm() : void {
    		view.loginBtn.label = "Log In";
    		view.loginBtn.enabled = true;
    	}
    
	    public function validateForm( event : Event ) : void {       
            var view : LoginForm = view as LoginForm;

            focussedFormControl = event.target as DisplayObject;    

            formIsValid = true;            

            validate( view.emailValidator );
            validate( view.passwordValidator );   

            if ( view.currentState == view.ACTIVATE_AND_LOG_IN_STATE ) {
            	validate( view.activationKeyValidator );
            }
            
            view.formIsValid = formIsValid;             
        }
        
		public function login() : void {
			var view : LoginForm = view as LoginForm;
			view.loginBtn.label = "Logging in...";
			view.loginBtn.enabled = false;
			
			if ( view.currentState != view.ACTIVATE_AND_LOG_IN_STATE ) {
			
				var loggingEvent : LoggingEvent 
					= new LoggingEvent( view.emailTxt.text, view.passwordTxt.text );
			
				CairngormEventDispatcher.getInstance().dispatchEvent( loggingEvent );
			
			} else {
				var email : String = view.emailTxt.text;
				var password : String = view.passwordTxt.text;
				var activationKey : String = view.activationKeyTxt.text;
			
				var activationAndLoggingEvent : ActivationAndLoggingEvent
					= new ActivationAndLoggingEvent( email, password, activationKey );
			
				CairngormEventDispatcher.getInstance()
				.dispatchEvent( activationAndLoggingEvent );					
			}
		}
		
		public function isRememberMeSet() : Boolean {
			var view : LoginForm = view as LoginForm;
			return view.remeberMeChb.selected;
		}
 
        private function validate( validator : Validator ) : Boolean {                
            var validatorSource : DisplayObject 
             	= validator.source as DisplayObject;
            
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