package net.wg.gui.components.tooltips.helpers
{
   import net.wg.data.constants.IconsTypes;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.controls.IconText;
   import flash.text.TextFormat;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
   import flash.filters.DropShadowFilter;
   import net.wg.gui.components.tooltips.Separator;
   import flash.display.MovieClip;
   
   public class Utils extends Object
   {
      
      public function Utils()
      {
         super();
         if(__allowInstantiation)
         {
         }
      }
      
      private static var __instance:Utils;
      
      private static var __allowInstantiation:Boolean = false;
      
      public static function get instance() : Utils
      {
         if(!__instance)
         {
            __allowInstantiation = true;
            __instance = new Utils();
            __allowInstantiation = false;
         }
         return __instance;
      }
      
      public const COLOR_HEADER:String = "#fdf4ce";
      
      public const COLOR_BLOCK_HEADER:String = "#4c4b41";
      
      public const COLOR_NUMBER:String = "#d3d3ca";
      
      public const COLOR_ALERT:String = "#ff0000";
      
      public const COLOR_NORMAL:String = "#8c8c7e";
      
      public const COLOR_NORMAL_DARK:String = "#595950";
      
      public const COLOR_SUB_NORMAL:String = "#4a4a3f";
      
      public const COLOR_ADD_INFO:String = "#ccad77";
      
      public const COLOR_NOTE:String = "#497212";
      
      public const COLOR_LABEL:String = "#E9E2BF";
      
      public const COLOR_WARNING:String = "#EE6F00";
      
      public const STATUS_ADDITIONAL:String = "additional";
      
      public const STATUS_RENTED:String = "rented";
      
      public const STATUS_CRITICAL:String = "critical";
      
      public const STATUS_WARNING:String = "warning";
      
      public const STATUS_INFO:String = "info";
      
      public const allowStatuses:Array = [this.STATUS_ADDITIONAL,this.STATUS_RENTED,this.STATUS_CRITICAL,this.STATUS_WARNING,this.STATUS_INFO];
      
      public const MARGIN_AFTER_BLOCK:Number = 15;
      
      public const MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS:Number = 3;
      
      public const MARGIN_AFTER_SEPARATE:Number = 11;
      
      public const MARGIN_AFTER_SUBHEADER:Number = 12;
      
      private const LEFT_TEXTFIELD_MIN_WIDTH:Number = 54;
      
      public const MARGIN_AFTER_LASTITEM:Number = 14;
      
      public function getIcon(param1:String, param2:String = "", param3:Boolean = false, param4:Boolean = false) : String
      {
         var _loc5_:String = IconsTypes.EMPTY;
         switch(param1)
         {
            case "xp":
               _loc5_ = param4?IconsTypes.ELITE_XP:IconsTypes.XP;
               break;
            case "doubleXPFactor":
               _loc5_ = IconsTypes.DOUBLE_XP_FACTOR;
               break;
            case "actionXPFactor":
               _loc5_ = IconsTypes.ACTION_XP_FACTOR;
               break;
            case "unlock_price":
               _loc5_ = IconsTypes.XP_PRICE;
               break;
            case "buy_price_action":
               _loc5_ = param3?IconsTypes.CREDITS:IconsTypes.GOLD;
               break;
            case "buy_price":
            case "sell_price":
               if(param3)
               {
                  _loc5_ = IconsTypes.GOLD;
               }
               else
               {
                  _loc5_ = IconsTypes.CREDITS;
               }
               break;
            case "rentals":
               _loc5_ = IconsTypes.RENTALS;
               break;
            case "sheets":
            case "collectedSheets":
               _loc5_ = IconsTypes.REWARD_SHEET;
               break;
            default:
               _loc5_ = IconsTypes.EMPTY;
         }
         return _loc5_;
      }
      
      public function htmlWrapper(param1:String, param2:String = "#ffffff", param3:Number = 12, param4:String = "$TextFont", param5:Boolean = false, param6:String = "") : String
      {
         var _loc7_:* = "";
         _loc7_ = _loc7_ + (param4 == ""?"":" face=\"" + param4 + "\"");
         _loc7_ = _loc7_ + (param2 == ""?"":" color=\"" + param2 + "\"");
         _loc7_ = _loc7_ + (!param3?"":" size=\"" + param3 + "\"");
         var param1:* = "<font" + _loc7_ + ">" + param1 + "</font>";
         if(param5)
         {
            param1 = "<b>" + param1 + "</b>";
         }
         return param1 + param6;
      }
      
      public function convertStringColorToNumber(param1:String) : Number
      {
         return Number("0x" + param1.slice(1));
      }
      
      public function addEmptyBlock(param1:ToolTipBlockVO) : void
      {
         param1.leftText = param1.leftText + (Utils.instance.htmlWrapper(" ",this.COLOR_NUMBER,12,"$TextFont",false) + "<br/>");
         param1.rightTextList.push(new ToolTipBlockRightListItemVO("<h1> </h1>",IconsTypes.EMPTY,0));
      }
      
      public function createBlock(param1:ToolTipBlockVO, param2:Number) : ToolTipBlockResultVO
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function addHeader(param1:String, param2:Number, param3:Number, param4:String) : TextField
      {
         var _loc5_:TextField = new TextField();
         var _loc6_:TextFormat = new TextFormat();
         _loc6_.leading = -3;
         _loc6_.align = TextFormatAlign.LEFT;
         _loc5_.name = param1;
         _loc5_.x = param2;
         _loc5_.y = param3;
         _loc5_.width = 800;
         _loc5_.height = 10;
         _loc5_.autoSize = TextFormatAlign.LEFT;
         _loc5_.multiline = true;
         _loc5_.htmlText = this.htmlWrapper(param4,this.COLOR_BLOCK_HEADER,14,"$TitleFont",false);
         _loc5_.setTextFormat(_loc6_);
         return _loc5_;
      }
      
      public function getStatusColor(param1:String) : ToolTipStatusColorsVO
      {
         var _loc2_:ToolTipStatusColorsVO = new ToolTipStatusColorsVO();
         var _loc3_:uint = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         switch(param1)
         {
            case this.STATUS_RENTED:
               _loc2_.textColor = 16754521;
               _loc2_.headerFontSize = 13;
               _loc2_.headerFontFace = "$FieldFont";
               _loc3_ = 16723968;
               _loc4_ = 2.6;
               _loc5_ = 0.6;
               _loc6_ = 12;
               break;
            case this.STATUS_ADDITIONAL:
               _loc2_.textColor = 16761699;
               _loc2_.filters = [];
               return _loc2_;
            case this.STATUS_CRITICAL:
               _loc2_.textColor = 16721687;
               _loc3_ = 16711680;
               _loc4_ = 0.5;
               _loc5_ = 0.27;
               _loc6_ = 11;
               break;
            case this.STATUS_WARNING:
               _loc2_.textColor = 16117989;
               _loc3_ = 15521204;
               _loc4_ = 0.3;
               _loc5_ = 0.11;
               _loc6_ = 11;
               break;
            case this.STATUS_INFO:
            default:
               _loc2_.textColor = 8041216;
               _loc3_ = 3997440;
               _loc4_ = 0.5;
               _loc5_ = 0.24;
               _loc6_ = 11;
         }
         _loc2_.filters = [];
         var _loc7_:DropShadowFilter = new DropShadowFilter();
         _loc7_.distance = 0;
         _loc7_.angle = 0;
         _loc7_.color = _loc3_;
         _loc7_.alpha = _loc5_;
         _loc7_.blurX = _loc6_;
         _loc7_.blurY = _loc6_;
         _loc7_.strength = _loc4_;
         _loc7_.quality = 3;
         _loc7_.inner = false;
         _loc7_.knockout = false;
         _loc7_.hideObject = false;
         _loc2_.filters.push(_loc7_);
         return _loc2_;
      }
      
      public function createSeparate(param1:MovieClip) : Separator
      {
         var _loc2_:Separator = App.utils.classFactory.getComponent("SeparatorUI",Separator);
         param1.addChild(_loc2_);
         return _loc2_;
      }
   }
}
