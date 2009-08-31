package com.collectivecolors.extensions.flex3.style.model
{
	//----------------------------------------------------------------------------
	// Imports
	
	import com.collectivecolors.extensions.as3.data.StatusVO;
	import com.collectivecolors.extensions.flex3.config.ConfigFacade;
	import com.collectivecolors.extensions.flex3.startup.model.StartupProxy;
	import com.collectivecolors.extensions.flex3.style.StyleFacade;
	import com.collectivecolors.extensions.flex3.style.model.data.StyleVO;
	
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	
	import mx.events.StyleEvent;
	import mx.styles.StyleManager;
	
	//----------------------------------------------------------------------------
	
	public class StyleProxy extends StartupProxy
	{
		//--------------------------------------------------------------------------
		// Constants
		
		public static const NAME : String = "styleFacade_styleProxy";
		
		//--------------------------------------------------------------------------
		// Constructor
		
		public function StyleProxy( flashVars : Object = null )
		{
			super( NAME );
			
			// Loading of the application styles depends upon the configuration being 
			// loaded.
			addRequiredProxy( ConfigFacade.configProxy );
			
			setData( new StyleVO( StyleFacade.NAME ) );
			
			data.applicationDomain = null;
			data.securityDomain    = SecurityDomain.currentDomain;
			
			data.location.allowedFileExtensions = [ 'swf' ];
		}
		
		//--------------------------------------------------------------------------
		// Accessors / Modifiers
		
		/**
		 * Get style data object
		 */
		protected function get data( ) : StyleVO
		{
		  return getData( ) as StyleVO;
		}
		
		/**
		 * Get the status of the last style load
		 */
		public function get status( ) : String
		{
		  return data.status;
		}
		
		/**
		 * Get the status message set when loading styles on application startup
		 */
		public function get message( ) : String
		{
			return data.message;
		}
		
		/**
		 * Get the style application domain for this style extension
		 */
		public function get applicationDomain( ) : ApplicationDomain
		{
		  return data.applicationDomain;
		}
		
		/**
		 * Set the style application domain for this style extension
		 */
		public function set applicationDomain( value : ApplicationDomain ) : void
		{
		  data.applicationDomain = value;
		  sendNotification( StyleFacade.UPDATED );
		}
		
		/**
		 * Get the style security domain for this style extension
		 */
		public function get securityDomain( ) : SecurityDomain
		{
		  return data.securityDomain;
		}
		
		/**
		 * Set the style security domain for this style extension
		 */
		public function set securityDomain( value : SecurityDomain ) : void
		{
		  data.securityDomain = value;
		  sendNotification( StyleFacade.UPDATED );
		}
		
		/**
		 * Get the url locations of the stylesheets to import
		 */
		public function get urls( ) : Array
		{
		  return data.location.urls;
		}
		
		/**
		 * Set the url locations of the stylesheets to import
		 */
		public function set urls( values : Array ) : void
		{
		  data.location.urls = values;
		  sendNotification( StyleFacade.UPDATED );
		}
		
		/**
		 * Add a url to the list of stylesheets to import
		 */
		public function addUrl( url : String ) : void
		{
		  data.location.addUrl( url );
		  sendNotification( StyleFacade.UPDATED );
		}
		
		/**
		 * Remove a url from the list of stylesheets to import
		 */
		public function removeUrl( url : String ) : void
		{
		  data.location.removeUrl( url );
		  sendNotification( StyleFacade.UPDATED );
		}
		
		/**
		 * Get whether or not this proxy has been loaded by the startup manager
		 */
		public function get initialized( ) : Boolean
		{
		  return data.initialized;
		}
		
		//--------------------------------------------------------------------------
		// Overrides
		
		/**
		 * Set the value of the failed startup notification name to our constant
		 * so it is easier to listen for in our mediators.
		 * 
		 * @see StartupProxy
		 */
		override protected function get failedNoteName( ) : String
		{
			return StyleFacade.FAILED;
		}
		
		/**
		 * Set the value of the loaded startup notification name to our constant
		 * so it is easier to listen for in our mediators.
		 * 
		 * @see StartupProxy
		 */
		override protected function get loadedNoteName( ) : String
		{
			return StyleFacade.LOADED;
		}
		
		/**
		 * Request style SWF files from server and load them into application.
		 * 
		 * This method is automatically called by the StartupProxy's loadResources()
		 * method.
		 * 
		 * @see StartupProxy
		 */
		override public function load( ) : void
		{
			data.processed = 0;
			data.status    = StatusVO.NOTICE;
			data.message   = '';
			
			sendNotification( StyleFacade.LOADING );
			
			for each ( var url : String in data.location.urls )
			{
				var manager : IEventDispatcher 
					= StyleManager.loadStyleDeclarations( 
					    url, true, false, 
					    data.applicationDomain,
					    data.securityDomain 
				);
					
				manager.addEventListener( StyleEvent.ERROR, faultHandler );
				manager.addEventListener( StyleEvent.COMPLETE, resultHandler );	
			}					
		}
		
		//--------------------------------------------------------------------------
		// Event handlers
		
		/**
		 * This is called if the stylesheet loading process encounters an error.
		 */
		private function faultHandler( event : StyleEvent ) : void
		{
			data.status      = StatusVO.ERROR;
			data.message     = event.errorText;
			data.initialized = true;	
			
			sendFailedNotification( );	
		}
		
		/**
		 * This is called if the stylesheet loading is successful.
		 */
		private function resultHandler( event : StyleEvent ) : void
		{
			data.processed++;
			
			if ( data.processed == data.location.urls.length )
			{			
				data.status      = StatusVO.SUCCESS;
				data.message     = "Application stylesheets imported successfully";
				data.initialized = true;	
				
				sendLoadedNotification( );
			}	
		}
	}
}