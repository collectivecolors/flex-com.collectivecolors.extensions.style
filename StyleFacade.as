package com.collectivecolors.extensions.flex3.style
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.emvc.patterns.extension.Extension;
  import com.collectivecolors.extensions.as3.data.StatusVO;
  import com.collectivecolors.extensions.flex3.config.ConfigFacade;
  import com.collectivecolors.extensions.flex3.startup.StartupFacade;
  import com.collectivecolors.extensions.flex3.style.controller.StyleConfigParseCommand;
  import com.collectivecolors.extensions.flex3.style.controller.StyleReloadCommand;
  import com.collectivecolors.extensions.flex3.style.controller.StyleStartupCommand;
  import com.collectivecolors.extensions.flex3.style.model.StyleProxy;
    
  //----------------------------------------------------------------------------

  public class StyleFacade extends Extension
  {
    //--------------------------------------------------------------------------
    // Constants
    
    public static const NAME : String = "styleFacade";
    
    // Notifications
    
    public static const UPDATED : String = "styleFacadeUpdated";
    public static const LOAD : String    = "styleFacadeLoad"; 
    
    public static const LOADING : String = "styleFacadeLoading";
		public static const LOADED : String  = "styleFacadeLoaded";
		public static const FAILED : String  = "styleFacadeFailed";
		
		//---------------------    
    // Configuration tags
    
    public static const CONFIG_URL : String = "styleUrl";
    
		// Status types ( for status information )
		
		public static const STATUS_SUCCESS : String = StatusVO.SUCCESS;
		public static const STATUS_NOTICE : String  = StatusVO.NOTICE;
		public static const STATUS_ERROR : String   = StatusVO.ERROR;
    
    //--------------------------------------------------------------------------
    // Constructor
    
    public function StyleFacade( )
    {
      super( NAME );
    }
    
    //--------------------------------------------------------------------------
    // Overrides
    
    override public function onRegister( ) : void
    {
      if ( ! core.hasExtension( ConfigFacade.NAME ) )
      {
        core.registerExtension( new ConfigFacade( ) );
      }  
    }
    
    //--------------------------------------------------------------------------
    // Accessors
    
    public static function get styleProxy( ) : StyleProxy
    {
      return core.retrieveProxy( StyleProxy.NAME ) as StyleProxy;
    }
    
    //--------------------------------------------------------------------------
    // eMVC hooks
    
    public function initializeController( ) : void
    {
      core.registerCommand( StartupFacade.REGISTER_RESOURCES, StyleStartupCommand );
      core.registerCommand( ConfigFacade.PARSE, StyleConfigParseCommand );
      core.registerCommand( LOAD, StyleReloadCommand ); 
    }    
  }
}