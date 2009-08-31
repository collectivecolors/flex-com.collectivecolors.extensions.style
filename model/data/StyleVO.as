package com.collectivecolors.extensions.flex3.style.model.data
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.data.URLSet;
  import com.collectivecolors.extensions.as3.data.StatusVO;
  
  import flash.system.ApplicationDomain;
  import flash.system.SecurityDomain;
  
  //----------------------------------------------------------------------------
  
  public class StyleVO extends StatusVO
  {
    //--------------------------------------------------------------------------
    // Properties
    
    public var applicationDomain : ApplicationDomain;
    public var securityDomain : SecurityDomain;
    
    public var location : URLSet;
    
    public var initialized : Boolean = false;
    
    private var _processed : int = 0;    
        
    //--------------------------------------------------------------------------
    // Constructor
    
    public function StyleVO( extensionName : String = null )
    {
      super( extensionName );
      
      location = new URLSet( );  
    }
    
    //--------------------------------------------------------------------------
    // Accessors / modifiers
    
    //-----------------------
    // property : processed
    
    public function get processed( ) : int
    {
      return _processed;
    }
    
    public function set processed( value : int ) : void
    {
      _processed = ( value != null && value >= 0 ? value : 0 );
    }   
  }
}