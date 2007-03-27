// Author: Mike Nimer mnimer@gmail.com
// Copyright 2006 Mike Nimer

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY. 


/**
 * A special debug object that knows how to parse ResultEvent Objects.
 */
package com.mikenimer.components.debug
{
	import mx.rpc.events.ResultEvent;
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	import mx.controls.Alert;
	import com.mikenimer.components.debug.ColdFusion.UserDefinedDebugObject;
	import com.mikenimer.components.debug.ColdFusion.TraceDebugObject;
	import com.mikenimer.components.debug.ColdFusion.TemplateDebugObject;
	import com.mikenimer.components.debug.ColdFusion.StoredProcedureDebugObject;
	import com.mikenimer.components.debug.ColdFusion.SqlQueryDebugObject;
	import com.mikenimer.components.debug.ColdFusion.ObjectQueryDebugObject;
	import com.mikenimer.components.debug.ColdFusion.HttpDebugObject;
	import com.mikenimer.components.debug.ColdFusion.ExecutionTimeDebugObject;
	import com.mikenimer.components.debug.ColdFusion.ExceptionDebugObject;
	import com.mikenimer.components.debug.ColdFusion.CFTimerDebugObject;
	import mx.messaging.messages.RemotingMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	
	public class ResultEventDebugObject extends TreeParent
	{
		
		public function ResultEventDebugObject(object:ResultEvent, name:String="ResultEvent"):void
		{
			var n:String = "[Result Event]";
			if( object.token.message is RemotingMessage )
			{
				n = RemotingMessage(object.token.message).destination +"::" +RemotingMessage(object.token.message).operation +"()" +"  ( " +RemotingMessage(object.token.message).source +" )";				
			}
			else if( object.token.message is AsyncMessage )
			{			
				n = AsyncMessage(object.token.message).destination;
			}
			
			super(n, object as ResultEvent);
			
			this.children = new ArrayCollection();
			this.children.addItem( parseResult(this.value as ResultEvent) );	
			
			var debug:TreeParent = parseDebug(this.value as ResultEvent);
			if( debug != null )
			{
				this.children.addItem( debug );
			}
		}
		
		
		
		private function parseResult(o:ResultEvent):TreeParent
		{
			var result:TreeParent = new TreeParent("result", o.result);
			if( o.result is ArrayCollection )
			{
				result.children = o.result as ArrayCollection;
			}
			if( o.result is Object )
			{
				result.children = new ArrayCollection();
				for each(var key:Object in o.result)
				{
					result.children.addItem(key);
				}
			}
			return result;
		}
				
		private function parseDebug(o:ResultEvent):TreeParent
		{
			if( o.message.headers.debug != null )
			{
				var debug:TreeParent = new TreeParent("debug", o.message.headers.debug);
				debug.children = new ArrayCollection();
		
		
				if( o.message.headers.debug.ExecutionTime != null && o.message.headers.debug.ExecutionTime is Array && (o.message.headers.debug.ExecutionTime as Array).length > 0 )
				{
					var ExecutionTime:ExecutionTimeDebugObject = new ExecutionTimeDebugObject("ExecutionTime", o.message.headers.debug.ExecutionTime);
					debug.children.addItem(ExecutionTime);
				}

				if( o.message.headers.debug.Template != null && o.message.headers.debug.Template is Array && (o.message.headers.debug.Template as Array).length > 0 )
				{
					var Template:TemplateDebugObject = new TemplateDebugObject("Template", o.message.headers.debug.Template);
					debug.children.addItem(Template);
				}
		
				if( o.message.headers.debug.ObjectQuery != null && o.message.headers.debug.ObjectQuery is Array && (o.message.headers.debug.ObjectQuery as Array).length > 0 )
				{
					var ObjectQuery:ObjectQueryDebugObject = new ObjectQueryDebugObject("ObjectQuery", o.message.headers.debug.ObjectQuery);
					debug.children.addItem(ObjectQuery);
				}
		
				if( o.message.headers.debug.SqlQuery != null && o.message.headers.debug.SqlQuery is Array && (o.message.headers.debug.SqlQuery as Array).length > 0 )
				{
					var SqlQuery:SqlQueryDebugObject = new SqlQueryDebugObject("SqlQuery", o.message.headers.debug.SqlQuery);
					debug.children.addItem(SqlQuery);
				}

				if( o.message.headers.debug.StoredProcedure != null && o.message.headers.debug.StoredProcedure is Array && (o.message.headers.debug.StoredProcedure as Array).length > 0 )
				{
					var StoredProcedure:StoredProcedureDebugObject = new StoredProcedureDebugObject("StoredProcedure", o.message.headers.debug.StoredProcedure);
					debug.children.addItem(StoredProcedure);
				}

				if( o.message.headers.debug.Exception != null && o.message.headers.debug.Exception is Array && (o.message.headers.debug.Exception as Array).length > 0 )
				{
					var Exception:ExceptionDebugObject = new ExceptionDebugObject("Exception", o.message.headers.debug.Exception);
					debug.children.addItem(Exception);
				}

				if( o.message.headers.debug.CFTimer != null && o.message.headers.debug.CFTimer is Array && (o.message.headers.debug.CFTimer as Array).length > 0 )
				{
					var CFTimer:CFTimerDebugObject = new CFTimerDebugObject("CFTimer", o.message.headers.debug.CFTimer);
					debug.children.addItem(CFTimer);
				}
		
				if( o.message.headers.debug.Trace != null && o.message.headers.debug.Trace is Array && (o.message.headers.debug.Trace as Array).length > 0 )
				{
					var Trace:TraceDebugObject = new TraceDebugObject("Trace", o.message.headers.debug.Trace);
					debug.children.addItem(Trace);
				}
		
				if( o.message.headers.debug.Http != null && o.message.headers.debug.Http is Array && (o.message.headers.debug.Http as Array).length > 0 )
				{
					var Http:HttpDebugObject = new HttpDebugObject("Http", o.message.headers.debug.Http);
					debug.children.addItem(Http);
				}

/*		
				// CGIVar, ClientVar, CookieVar, FormVar, RequestVar, ServerVar, URLVar
				if( o.message.headers.debug.SCOPES != null && o.message.headers.debug.SCOPES is Object )
				{
					var scopes:ScopeDebugObject = new ScopeDebugObject("Scopes", o.message.headers.debug.SCOPES);
					debug.children.addItem(scopes);
				}
*/
				if( o.message.headers.debug.UserDefined != null && o.message.headers.debug.UserDefined is Array && (o.message.headers.debug.UserDefined as Array).length > 0 )
				{
					var UserDefined:UserDefinedDebugObject = new UserDefinedDebugObject("UserDefined", o.message.headers.debug.UserDefined);
					debug.children.addItem(UserDefined);
				}
				
				return debug;
			}
			return null;
		}
		
	}
}