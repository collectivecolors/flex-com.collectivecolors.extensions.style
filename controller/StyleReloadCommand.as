package com.collectivecolors.extensions.flex3.style.controller
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.extensions.flex3.style.StyleFacade;
  
  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.command.SimpleCommand;

  //----------------------------------------------------------------------------

  public class StyleReloadCommand extends SimpleCommand
  {
    //--------------------------------------------------------------------------
    // Overrides
    
    override public function execute( note : INotification ) : void
    {
      if ( StyleFacade.styleProxy.initialized )
      {
        // Reload the stylesheets.
        StyleFacade.styleProxy.load( );
      }  
    }    
  }
}