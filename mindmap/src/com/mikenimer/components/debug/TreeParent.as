// Author: Mike Nimer mnimer@gmail.com
// Copyright 2006 Mike Nimer

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY. 


/**
 * A generic Tree Node with Children
 */
package com.mikenimer.components.debug
{
	import mx.collections.ArrayCollection;
	
	public class TreeParent extends TreeObject
	{
	    [Bindable]
	    public var children:ArrayCollection;

		public function TreeParent(id:String, value:Object)
		{
			super(id, value);
	        // if the reference item is an array add the items as children
	        this.children = parseArrayChildren(value);			
		}
		
		protected function parseArrayChildren(obj:Object):ArrayCollection
	    {
			if( obj is Array && (obj as Array).length > 0 )
			{
				var items:Array = obj as Array;
				this.children = new ArrayCollection();					
				for( var i:int=0; i < items.length; i++)
				{
					var debugObject:TreeParent = new TreeParent("[" +i +"]", items[i]);
					this.children.addItem(debugObject);	
				}					
				return this.children;
			}
			return null;
	    }
	    	
	    public function isToggled(item:Object):Boolean
	    {
	    	return true;
	    }	
		
	}
}