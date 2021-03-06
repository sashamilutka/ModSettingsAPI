package net.wg.utils
{
   import org.idmedia.as3commons.util.Map;
   import net.wg.data.constants.KeyProps;
   import flash.text.TextField;
   import flash.display.Sprite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.IUserProps;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.display.DisplayObject;
   
   public interface ICommons
   {
      
      function createMap(param1:Array) : Map;
      
      function createMappedArray(param1:Array) : Array;
      
      function cleanupDynamicObject(param1:Object) : Object;
      
      function cleanupDynamicObjectsCouple(param1:Object, param2:Object) : Object;
      
      function keyToString(param1:Number) : KeyProps;
      
      function cloneObject(param1:Object) : *;
      
      function addBlankLines(param1:String, param2:TextField, param3:Vector.<TextField>) : void;
      
      function setSaturation(param1:Sprite, param2:Number) : void;
      
      function releaseReferences(param1:Object, param2:Boolean = true) : void;
      
      function cutBitmapFromBitmapData(param1:BitmapData, param2:Rectangle) : Bitmap;
      
      function getUserProps(param1:String, param2:String = null, param3:String = null, param4:int = 0, param5:Array = null) : IUserProps;
      
      function formatPlayerName(param1:TextField, param2:IUserProps) : Boolean;
      
      function truncateTextFieldText(param1:TextField, param2:String, param3:String = "..") : String;
      
      function getFullPlayerName(param1:IUserProps) : String;
      
      function addMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void;
      
      function removeMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void;
      
      function isLeftButton(param1:MouseEvent) : Boolean;
      
      function isRightButton(param1:MouseEvent) : Boolean;
      
      function initTabIndex(param1:Array) : void;
      
      function moveDsiplObjToEndOfText(param1:DisplayObject, param2:TextField, param3:int = 0, param4:int = 0) : void;
      
      function rgbToArgb(param1:uint, param2:Number) : uint;
   }
}
