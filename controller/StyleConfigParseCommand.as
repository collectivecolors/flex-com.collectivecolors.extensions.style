package com.collectivecolors.extensions.flex3.style.controller
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.extensions.flex3.style.StyleFacade;
  import com.collectivecolors.extensions.flex3.style.model.data.StyleVO;
  import com.collectivecolors.utils.XMLParser;
  
  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.command.SimpleCommand;

  //----------------------------------------------------------------------------

  public class StyleConfigParseCommand extends SimpleCommand
  {
    //--------------------------------------------------------------------------
    // Overrides
    
    override public function execute( note : INotification ) : void
    {
      var config : XML = note.getBody( ) as XML;
      
      // Set stylesheet urls ( multiple tags optional )
      
			StyleFacade.styleProxy.urls = XMLParser.parseMultiTagOptional( 
			  config[ StyleFacade.NAME ], 
			  StyleFacade.CONFIG_URL,
			  "Style urls are incorrectly specified"			
			);			  
    }    
  }
}