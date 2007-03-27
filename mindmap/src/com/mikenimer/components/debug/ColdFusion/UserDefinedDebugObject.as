// Author: Mike Nimer mnimer@gmail.com
// Copyright 2006 Mike Nimer

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY. 
package com.mikenimer.components.debug.ColdFusion
{
	import com.mikenimer.components.debug.TreeParent;

	public class UserDefinedDebugObject extends TreeParent
	{
		public function UserDefinedDebugObject(id:String, reference:Object)
		{
			super(id, reference);
		}
		
	}
}