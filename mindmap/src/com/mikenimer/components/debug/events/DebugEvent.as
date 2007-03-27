// Author: Mike Nimer mnimer@gmail.com
// Copyright 2006 Mike Nimer

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY. 
package com.mikenimer.components.debug.events
{
	import flash.events.Event;
	import mx.core.UIComponent;

	public class DebugEvent extends Event
	{
		public static var NEW_TAB:String = "NEW_TAB";
		[Bindable]
		public var tab:UIComponent = null;
		
		public function DebugEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}