package com.collectivecolors.extensions.flex3.style.controller
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.extensions.flex3.style.model.StyleProxy;
  
  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.command.SimpleCommand;

  //----------------------------------------------------------------------------

  public class StyleStartupCommand extends SimpleCommand
  {
    //--------------------------------------------------------------------------
    // Overrides
    
    override public function execute( note : INotification ) : void
    {
      // Load stylesheets 	
      facade.registerProxy( new StyleProxy( note.getBody( ) ) );  
    }    
  }
}