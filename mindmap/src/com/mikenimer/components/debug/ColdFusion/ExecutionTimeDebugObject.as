// Author: Mike Nimer mnimer@gmail.com
// Copyright 2006 Mike Nimer

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY. 
package com.mikenimer.components.debug.ColdFusion
{
	import com.mikenimer.components.debug.TreeObject;

	public class ExecutionTimeDebugObject extends TreeObject
	{
		public function ExecutionTimeDebugObject(id:String, value:Object)
		{
			super(id, (value[0].endtime - value[0].starttime) +"ms");
		}
		
		
	    override public function toString():String
	    {
	    	return this.id +": " +this.value;
	    }	
	}
}


