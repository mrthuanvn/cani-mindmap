// Author: Mike Nimer mnimer@gmail.com
// Copyright 2006 Mike Nimer

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY. 

  
 /**
 * A generic Tree Node with NO Children
 */
package com.mikenimer.components.debug
{
	import mx.collections.ArrayCollection;
	
	public class TreeObject
	{		
		[Bindable]
	    public var id:String;
	    [Bindable]
	    public var value:Object;

	
	    public function TreeObject(id:String, value:Object)
	    {
	        this.id = id;
	        this.value = value;
	    }
	    
	    public function toString():String
	    {
	    	return this.id;
	    }	
	}
}