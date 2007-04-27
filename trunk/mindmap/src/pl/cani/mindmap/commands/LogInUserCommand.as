package pl.cani.mindmap.commands {
	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.view.ViewLocator;
	import com.asual.swfaddress.SWFAddress;
	import com.mikenimer.components.Debug;
	
	import flash.net.SharedObject;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import pl.cani.mindmap.business.LoginServiceDelegate;
	import pl.cani.mindmap.business.SessionAndPersitentData;
	import pl.cani.mindmap.business.exceptions.UserDoesntExistException;
	import pl.cani.mindmap.business.exceptions.UserNotActivatedException;
	import pl.cani.mindmap.business.exceptions.WrongPasswordException;
	import pl.cani.mindmap.events.LoggingEvent;
	import pl.cani.mindmap.model.AppModelLocator;
	import pl.cani.mindmap.utils.SWFAddressHandler;
	import pl.cani.mindmap.view.helpers.LoginFormHelper;
	import pl.cani.mindmap.view.helpers.MainViewHelper;
	import pl.cani.mindmap.view.helpers.ViewNames;
	import pl.cani.mindmap.vo.UserVO;


	public class LogInUserCommand implements ICommand, IResponder {
		
		public function execute( event : CairngormEvent ) : void {
			var loggingEvent : LoggingEvent = event as LoggingEvent;
			var delegate : LoginServiceDelegate 
				= new LoginServiceDelegate( this );
			delegate.loginUser( loggingEvent.email, loggingEvent.password );
		}
		
		public function result( data : Object ) : void {
			var resultEvent : ResultEvent = data as ResultEvent;
			var result : Object = resultEvent.result;
			
			var helper : LoginFormHelper = ViewLocator.getInstance()
				.getViewHelper( ViewNames.LOGIN_FORM ) as LoginFormHelper;

			if ( result is UserDoesntExistException ) {
				
				var exception : UserDoesntExistException 
					= result as UserDoesntExistException;
					
				helper.showUserDoesntExistError( exception.email );
				
			} else if ( result is UserNotActivatedException ) {

				var userNotActivatedException : UserNotActivatedException
					= result as UserNotActivatedException;
				
				var email : String = userNotActivatedException.email;
				var activationKey : String = userNotActivatedException.activationKey;
				
				helper.showUserNotActivatedError( email, activationKey );

			} else if ( result is WrongPasswordException ) {
				var wrongPasswordException : WrongPasswordException
					= result as WrongPasswordException;
					
				var wrongPassword : String = wrongPasswordException.password;
				helper.showWrongPasswordError( wrongPassword );

			} else if ( result is UserVO ) {
				var user : UserVO = result as UserVO;
                var rememberUser : Boolean = helper.isRememberMeSet();
                SessionAndPersitentData.getInstance()
                .setLoggedInUser( user, rememberUser );

					
				var loginFormHelper : LoginFormHelper = ViewLocator.getInstance()
					.getViewHelper( ViewNames.LOGIN_FORM ) as LoginFormHelper;
					
				loginFormHelper.resetForm();

				

				if ( SWFAddress.getValue() != null && SWFAddress.getValue() != "" ) {
					SWFAddressHandler.handle();
				} else {
	 				var mainViewHelper : MainViewHelper = ViewLocator.getInstance()
						.getViewHelper( ViewNames.MAIN ) as MainViewHelper;
	
					mainViewHelper.setState( MainViewHelper.LOGGED_IN_STATE );
				}
			} else {
				Alert.show( "coś nie pykło" );
			}
		}
		
		public function fault( info : Object ) : void {
			Debug.show( info );
		}
		
	}
}