package net.wg.gui.components.controls
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IScrollBar;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.DisplayObject;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.components.controls.events.ScrollPaneEvent;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.gui.interfaces.IContentSize;
   import flash.utils.getDefinitionByName;
   import flash.display.Graphics;
   import flash.display.DisplayObjectContainer;
   
   public class ScrollPane extends UIComponent
   {
      
      public function ScrollPane()
      {
         super();
      }
      
      public static const SCROLL_UPDATE_INV:String = "scrollUpdInv";
      
      public static const SCROLL_POSITION_INV:String = "scrollPosInv";
      
      public static const TARGET_INVALID:String = "targetInv";
      
      private var _scrollBarMargin:Number = 0;
      
      public var thumbOffset:Object;
      
      public var _scrollBar:IScrollBar;
      
      protected var _scrollBarValue:Object;
      
      protected var _scrollPosition:uint = 0;
      
      protected var _scrollStepFactor:Number = 1.0;
      
      public var maskObject:MovieClip;
      
      public var background:Sprite;
      
      protected var _target:DisplayObject;
      
      protected var _autoScrollBar:Boolean = false;
      
      private var showThumb:Boolean;
      
      private var _isScrollBarHaveToBeShown:Boolean;
      
      private const THUMB_INV:String = "thumbInv";
      
      public function get isScrollBarHaveToBeShown() : Boolean
      {
         return this._isScrollBarHaveToBeShown;
      }
      
      public function set isScrollBarHaveToBeShown(param1:Boolean) : void
      {
         this._isScrollBarHaveToBeShown = param1;
         invalidate(this.THUMB_INV);
      }
      
      public function set scrollBarMargin(param1:Number) : void
      {
         this._scrollBarMargin = param1;
      }
      
      public function get scrollBarMargin() : Number
      {
         return this._scrollBarMargin;
      }
      
      public function get availableHeight() : Number
      {
         return Math.round(_height);
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function set target(param1:DisplayObject) : void
      {
         this._target = param1;
         if(_invalidHash)
         {
            invalidate(TARGET_INVALID);
         }
      }
      
      public function get scrollPageSize() : Number
      {
         return Math.round(_height / this._scrollStepFactor);
      }
      
      public function get scrollBar() : Object
      {
         return this._scrollBar;
      }
      
      public function set scrollBar(param1:Object) : void
      {
         this._scrollBarValue = param1;
         invalidate(InvalidationType.SCROLL_BAR);
      }
      
      public function get scrollStepFactor() : Number
      {
         return this._scrollStepFactor;
      }
      
      public function set scrollStepFactor(param1:Number) : void
      {
         this._scrollStepFactor = param1;
         invalidate(SCROLL_UPDATE_INV);
      }
      
      public function get scrollPosition() : Number
      {
         return this._scrollPosition;
      }
      
      public function set scrollPosition(param1:Number) : void
      {
         var param1:Number = Math.max(0,Math.min(this.maxScroll,Math.round(param1)));
         if(this._scrollPosition == param1)
         {
            return;
         }
         this._scrollPosition = param1;
         dispatchEvent(new ScrollPaneEvent(ScrollPaneEvent.POSITION_CHANGED));
         invalidate(SCROLL_UPDATE_INV);
      }
      
      public function get maxScroll() : Number
      {
         return Math.ceil((this.getContentHeight() - _height) / this._scrollStepFactor);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!this.maskObject)
         {
            this.maskObject = new MovieClip();
            addChild(this.maskObject);
         }
         if(!this.background)
         {
            this.background = new Sprite();
            addChildAt(this.background,0);
            this.background.addEventListener(MouseEvent.MOUSE_WHEEL,this.targetMouseWheelHandler,false,0,true);
         }
         mask = this.maskObject;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(TARGET_INVALID))
         {
            this.applyTargetChanges();
         }
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            this.createScrollBar();
            invalidate(SCROLL_POSITION_INV);
         }
         if(isInvalid(InvalidationType.SIZE,SCROLL_POSITION_INV))
         {
            this.drawScrollBar();
            this.drawMask();
            this.drawBackground();
            invalidate(SCROLL_UPDATE_INV);
         }
         if(isInvalid(SCROLL_UPDATE_INV))
         {
            this.applyScrollBarUpdating();
         }
         if((isInvalid(this.THUMB_INV)) && (this.scrollBar))
         {
            if(!this._isScrollBarHaveToBeShown)
            {
               this.scrollBar.visible = this.showThumb;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DisplayObject = null;
         super.onDispose();
         this.thumbOffset = null;
         if(this._scrollBar)
         {
            _loc1_ = this._scrollBar as DisplayObject;
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            this._scrollBar.removeEventListener(Event.SCROLL,this.handleScroll);
            this._scrollBar.removeEventListener(Event.CHANGE,this.handleScroll);
            this._scrollBar = null;
         }
         this._scrollBarValue = null;
         this.maskObject = null;
         if(this.background)
         {
            this.background.removeEventListener(MouseEvent.MOUSE_WHEEL,this.targetMouseWheelHandler);
            this.background = null;
         }
         this.removeSource();
         if(this._target is IDisposable)
         {
            IDisposable(this._target).dispose();
         }
         this._target = null;
      }
      
      protected function getContentHeight() : Number
      {
         var _loc1_:IContentSize = null;
         if(this._target)
         {
            _loc1_ = this._target as IContentSize;
            if(_loc1_)
            {
               return _loc1_.contentHeight;
            }
            return this._target.height;
         }
         return 0;
      }
      
      protected function createScrollBar() : void
      {
         var _loc1_:IScrollBar = null;
         var _loc2_:Class = null;
         var _loc3_:Object = null;
         if(this._scrollBar)
         {
            this._scrollBar.removeEventListener(Event.SCROLL,this.handleScroll,false);
            this._scrollBar.removeEventListener(Event.CHANGE,this.handleScroll,false);
            this._scrollBar.focusTarget = null;
            if(this.contains(this._scrollBar as DisplayObject))
            {
               this.removeChild(this._scrollBar as DisplayObject);
            }
            this._scrollBar = null;
         }
         if(!this._scrollBarValue || this._scrollBarValue == "")
         {
            return;
         }
         this._autoScrollBar = false;
         if(this._scrollBarValue is String)
         {
            if(parent != null)
            {
               _loc1_ = parent.getChildByName(this._scrollBarValue.toString()) as IScrollBar;
            }
            if(_loc1_ == null)
            {
               _loc2_ = getDefinitionByName(this._scrollBarValue.toString()) as Class;
               if(_loc2_)
               {
                  _loc1_ = new _loc2_() as IScrollBar;
               }
               if(_loc1_)
               {
                  this._autoScrollBar = true;
                  _loc3_ = _loc1_ as Object;
                  if((_loc3_) && (this.thumbOffset))
                  {
                     _loc3_.offsetTop = this.thumbOffset.top;
                     _loc3_.offsetBottom = this.thumbOffset.bottom;
                  }
                  this.addChild(_loc1_ as DisplayObject);
               }
            }
         }
         else if(this._scrollBarValue is Class)
         {
            _loc1_ = new (this._scrollBarValue as Class)() as IScrollBar;
            if(_loc1_ != null)
            {
               this._autoScrollBar = true;
               (_loc1_ as Object).offsetTop = this.thumbOffset.top;
               (_loc1_ as Object).offsetBottom = this.thumbOffset.bottom;
               this.addChild(_loc1_ as DisplayObject);
            }
         }
         else
         {
            _loc1_ = this._scrollBarValue as IScrollBar;
         }
         
         this._scrollBar = _loc1_;
         invalidateSize();
         if(this._scrollBar == null)
         {
            return;
         }
         this._scrollBar.addEventListener(Event.SCROLL,this.handleScroll,false,0,true);
         this._scrollBar.addEventListener(Event.CHANGE,this.handleScroll,false,0,true);
         this._scrollBar.focusTarget = this;
         this._scrollBar.tabEnabled = false;
      }
      
      protected function handleScroll(param1:Event) : void
      {
         this.scrollPosition = this._scrollBar.position;
      }
      
      protected function applyTargetChanges() : void
      {
         this.removeSource();
         if(this._target)
         {
            addChild(this._target);
            this._target.addEventListener(MouseEvent.MOUSE_WHEEL,this.targetMouseWheelHandler,false,0,true);
         }
      }
      
      protected function drawBackground() : void
      {
         var _loc1_:Graphics = this.background.graphics;
         _loc1_.clear();
         _loc1_.beginFill(0,0);
         _loc1_.drawRect(0,0,_width,this.availableHeight);
         _loc1_.endFill();
      }
      
      protected function drawMask() : void
      {
         var _loc1_:Graphics = this.maskObject.graphics;
         _loc1_.clear();
         _loc1_.beginFill(16777215,1);
         _loc1_.drawRect(0,0,_width,this.availableHeight);
         _loc1_.endFill();
      }
      
      protected function applyScrollBarUpdating() : void
      {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc1_:Number = this.scrollPageSize;
         var _loc2_:* = 0;
         var _loc3_:int = this.maxScroll;
         this.scrollBar.setScrollProperties(_loc1_,_loc2_,_loc3_);
         var _loc4_:Number = (this.scrollBar.position - _loc2_) / (_loc3_ - _loc2_);
         this.showThumb = !((isNaN(_loc4_)) || (isNaN(_loc1_)) || _loc3_ <= 0 || _loc3_ == Infinity);
         if(!this.showThumb)
         {
            this._scrollPosition = 0;
            dispatchEvent(new ScrollPaneEvent(ScrollPaneEvent.POSITION_CHANGED));
         }
         if(this._target)
         {
            _loc5_ = this.getContentHeight() - _height > 0?this.getContentHeight() - _height:0;
            _loc6_ = this._scrollStepFactor * this._scrollPosition;
            _loc7_ = Math.round(_loc5_ >= _loc6_?_loc6_:_loc5_);
            this._target.y = -_loc7_;
         }
         invalidate(this.THUMB_INV);
         this.scrollBar.position = this._scrollPosition;
         this.scrollBar.trackScrollPageSize = _loc1_;
      }
      
      protected function drawScrollBar() : void
      {
         if(!this._autoScrollBar)
         {
            return;
         }
         this._scrollBar.x = _width - this._scrollBar.width - this.scrollBarMargin;
         this._scrollBar.y = this.scrollBarMargin;
         this._scrollBar.height = this.availableHeight - this.scrollBarMargin * 2;
         this._scrollBar.validateNow();
      }
      
      private function targetMouseWheelHandler(param1:MouseEvent) : void
      {
         this.scrollPosition = this.scrollPosition - (param1.delta > 0?1:-1);
      }
      
      private function removeSource() : DisplayObject
      {
         var _loc1_:DisplayObjectContainer = null;
         if(this._target)
         {
            _loc1_ = this._target.parent;
            if(_loc1_)
            {
               _loc1_.removeChild(this._target);
            }
            this._target.removeEventListener(MouseEvent.MOUSE_WHEEL,this.targetMouseWheelHandler);
         }
         return this._target;
      }
   }
}
