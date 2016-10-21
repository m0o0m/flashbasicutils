package com.ql.gameKit.uiComponent
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;

    public class DatePicker extends Sprite
    {
        private var _dayNames:Array;
        private var _disabledDays:Array;
        private var _firstDayOfWeek:uint = 1;
        private var _monthNames:Array;
        private var _showToday:Boolean;
        private var _selectableRangeStart:Date;
        private var _selectableRangeEnd:Date;
        private var _selectedDate:Date;
        private var _todayDate:Date;
        private var daysMonthArray:Array;
        private var mCount:Number;
        private var yCount:Number;
        private var _disallowPrev:Boolean;
        private var _disallowNext:Boolean;
        private var _inited:Boolean;
        private var board:Sprite;
        private var nextBtn:Sprite;
        private var dayRow:Sprite;
        private var prevBtn:Sprite;
        private var calendar:Sprite;
        private var monthTf:TextField;
        private var gridCont:Sprite;
        private var closeBtn:Sprite;
        protected var _tfmDayNameRow:TextFormat;
        protected var _tfmMonth:TextFormat;
        protected var _tfmSelectedDay:TextFormat;
        protected var _tfmGrid:TextFormat;
        protected var _tfmDisabledDay:TextFormat;
        protected var _tfmToday:TextFormat;
        public var bgColorDayNameRow:uint = 0;
        public var bgColorSelectedDay:uint = 6623762;
        public var bgColorGrid:uint = 0;
        public var bgColorDisabled:uint = 0;
        public var bgColorToday:uint = 0;
        public var arrowColor:uint = 13421772;
        public var pickTarget:Object;

        public function DatePicker(autoInit:Boolean = true)
        {
            _dayNames = ["日", "一", "二", "三", "四", "五", "六"];
            _disabledDays = [];
            _monthNames = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"];
            _selectableRangeStart = new Date(1900, 0, 1);
            _selectableRangeEnd = new Date(2999, 11, 31);
            _selectedDate = new Date();
            _todayDate = new Date();
            daysMonthArray = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
            _tfmDayNameRow = defaultTxtFormat("dayNameRow");
            _tfmMonth = defaultTxtFormat("month");
            _tfmSelectedDay = defaultTxtFormat("selectedDay");
            _tfmGrid = defaultTxtFormat("dateGrid");
            _tfmDisabledDay = defaultTxtFormat("tfmDisabledDay");
            _tfmToday = defaultTxtFormat("tfmToday");
            if (autoInit)
            {
                addEventListener("addedToStage", onAdd2StageInit);
            }
            return;
        }// end function

        private function defaultTxtFormat(str:String) : TextFormat
        {
            var _loc_2:* = new TextFormat("Arial", 14, 16777215);
            if (str == "dateGrid")
            {
                _loc_2.align = "right";
                _loc_2.italic = true;
            }
            if (str == "dayNameRow")
            {
                _loc_2.align = "right";
            }
            if (str == "selectedDay")
            {
                _loc_2.align = "right";
                _loc_2.bold = true;
            }
            if (str == "tfmDisabledDay")
            {
                _loc_2.align = "right";
                _loc_2.italic = true;
                _loc_2.color = 10066329;
            }
            if (str == "tfmToday")
            {
                _loc_2.align = "right";
                _loc_2.underline = true;
                _loc_2.color = 16777215;
            }
            return _loc_2;
        }// end function

        private function onAdd2StageInit(event:Event) : void
        {
            init();
            removeEventListener("addedToStage", onAdd2StageInit);
            return;
        }// end function

        public function init() : void
        {
            if (_inited)
            {
                return;
            }
            board = this.addChild(drawRadialBackground(240, 175)) as Sprite;
            nextBtn = this.addChild(drawArrow(this.width - 25 - 50, 12, 0)) as Sprite;
            nextBtn.buttonMode = true;
            nextBtn.addEventListener("click", onNextClick);
            nextBtn.addEventListener("mouseOver", onOver);
            nextBtn.addEventListener("mouseOut", onOut);
            prevBtn = this.addChild(drawArrow(25, 12, 180)) as Sprite;
            prevBtn.buttonMode = true;
            prevBtn.addEventListener("click", onPrevClick);
            prevBtn.addEventListener("mouseOver", onOver);
            prevBtn.addEventListener("mouseOut", onOut);
            dayRow = this.addChild(drawDayNameRow(5, 25)) as Sprite;
            closeBtn = new Sprite();
            closeBtn.buttonMode = true;
            closeBtn.x = this.width - 50;
            closeBtn.y = 5;
            closeBtn.mouseChildren = false;
            var _loc_2:* = drawRoundRect(40, 18, bgColorGrid, 0.6);
            closeBtn.addChild(_loc_2);
            var _loc_1:* = new TextField();
            _loc_1.width = 40;
            _loc_1.height = 20;
            _loc_1.text = "关闭";
            _loc_1.selectable = false;
            _loc_1.setTextFormat(new TextFormat("Arial", 12, 16777215, null, null, null, null, null, "center"));
            _loc_1.x = closeBtn.width - _loc_1.width >> 1;
            _loc_1.y = closeBtn.height - _loc_1.height >> 1;
            closeBtn.addChild(_loc_1);
            closeBtn.addEventListener("click", onCloseClick);
            closeBtn.addEventListener("mouseOver", onOver);
            closeBtn.addEventListener("mouseOut", onOut);
            this.addChild(closeBtn);
            calendar = new Sprite();
            calendar.x = 5;
            this.addChild(calendar);
            monthTf = new TextField();
            monthTf.autoSize = "center";
            monthTf.y = 2;
            monthTf.x = this.width / 2 - monthTf.width / 2 - 25;
            monthTf.setTextFormat(_tfmMonth);
            calendar.addChild(monthTf);
            gridCont = new Sprite();
            calendar.addChild(gridCont);
            drawDateGrid(_selectedDate.getMonth(), _selectedDate.getFullYear());
            _inited = true;
            return;
        }// end function

        private function onNextClick(event:MouseEvent) : void
        {
            if (_disallowNext)
            {
                return;
            }
            clearDateGrid();
            if (mCount == 11)
            {
                mCount = 0;
                (yCount + 1);
            }
            else
            {
                (mCount + 1);
            }
            drawDateGrid(mCount, yCount);
            dispatchEvent(new Event("scroll"));
            return;
        }// end function

        private function onPrevClick(event:MouseEvent) : void
        {
            if (_disallowPrev)
            {
                return;
            }
            clearDateGrid();
            if (mCount == 0)
            {
                mCount = 11;
                (yCount - 1);
            }
            else
            {
                (mCount - 1);
            }
            drawDateGrid(mCount, yCount);
            dispatchEvent(new Event("scroll"));
            return;
        }// end function

        private function onCloseClick(event:Event) : void
        {
            this.visible = false;
            this.dispatchEvent(new Event("close"));
            return;
        }// end function

        private function onOver(event:MouseEvent) : void
        {
            event.target["alpha"] = 0.6;
            return;
        }// end function

        private function onOut(event:MouseEvent) : void
        {
            event.target["alpha"] = 1;
            return;
        }// end function

        private function drawDayNameRow(tx:Number, ty:Number) : Sprite
        {
            var _loc_5:int = 0;
            var _loc_3 = null;
            var _loc_4:* = new Sprite();
            new Sprite().x = tx;
            _loc_4.y = ty;
            _loc_4.addChild(drawRoundRect(this.width - 15, 22, bgColorDayNameRow, 0.8));
            _loc_5 = 0;
            while (_loc_5 < 7)
            {
                
                _loc_3 = new TextField();
                _loc_3.text = dayNames[(_loc_5 + firstDayOfWeek) % 7];
                _loc_3.width = 30;
                _loc_3.height = 20;
                _loc_3.selectable = false;
                _loc_3.y = 0;
                _loc_3.x = _loc_5 * 32;
                _loc_3.setTextFormat(_tfmDayNameRow);
                _loc_4.addChild(_loc_3);
                _loc_5++;
            }
            return _loc_4;
        }// end function

        private function drawRoundRect(w:Number, h:Number, col:uint, alph:Number) : Sprite
        {
            var _loc_5:* = new Sprite();
            new Sprite().graphics.beginFill(col, alph);
            _loc_5.graphics.drawRoundRect(0, 0, w, h, 10);
            _loc_5.graphics.endFill();
            return _loc_5;
        }// end function

        private function drawDateGrid(mm:Number, yy:Number) : void
        {
            var _loc_15:Boolean = false;
            var _loc_8:int = 0;
            var _loc_10:Boolean = false;
            var _loc_9:Boolean = false;
            var _loc_11 = null;
            var _loc_4:int = 0;
            var _loc_13:Number = NaN;
            var _loc_5 = null;
            var _loc_12 = null;
            monthTf.text = monthNames[mm] + " - " + yy;
            monthTf.setTextFormat(_tfmMonth);
            var _loc_7:* = yy % 4 == 0 && mm == 1 ? (29) : (daysMonthArray[mm]);
            var _loc_3:* = new Date(yy, mm, 1);
            var _loc_14:* = _loc_3.getDay() - firstDayOfWeek;
            var _loc_16:* = _loc_3.getDay();
            while (_loc_14 < 0)
            {
                
                _loc_14 = _loc_14 + 7;
            }
            var _loc_6:int = 1;
            _loc_8 = 1;
            while (_loc_8 <= _loc_7)
            {
                
                if (_loc_14 == 0 && _loc_8 != 1)
                {
                    _loc_6++;
                }
                if (_loc_3.valueOf() >= _selectableRangeStart.valueOf() && _loc_3.valueOf() <= _selectableRangeEnd.valueOf())
                {
                    _loc_15 = _disabledDays.indexOf(_loc_16) != -1;
                }
                else
                {
                    _loc_15 = true;
                }
                _loc_10 = _showToday && _todayDate.getDate() == _loc_8 && _todayDate.getMonth() == mm && _todayDate.fullYear == yy;
                _loc_9 = _selectedDate.fullYear == yy && _selectedDate.getMonth() == mm && _selectedDate.getDate() == _loc_8;
                _loc_11 = new Sprite();
                _loc_11.name = _loc_8 + "." + mm + "." + yy;
                _loc_11.x = _loc_14 * 33;
                _loc_11.y = _loc_6 * 20 + 30;
                _loc_11.mouseChildren = false;
                if (!_loc_15)
                {
                    _loc_11.buttonMode = true;
                    _loc_11.addEventListener("click", onDateClick);
                    _loc_11.addEventListener("mouseOver", onOver);
                    _loc_11.addEventListener("mouseOut", onOut);
                }
                _loc_4 = bgColorGrid;
                _loc_13 = 0.6;
                if (_loc_15)
                {
                    _loc_4 = bgColorDisabled;
                }
                else if (_loc_9)
                {
                    _loc_4 = bgColorSelectedDay;
                    _loc_13 = 1;
                }
                else if (_loc_10)
                {
                    _loc_4 = bgColorToday;
                    _loc_13 = 0.6;
                }
                else
                {
                    _loc_13 = 0.6;
                }
                _loc_5 = drawRoundRect(27, 18, _loc_4, _loc_13);
                _loc_5.x = 3;
                _loc_11.addChild(_loc_5);
                _loc_12 = new TextField();
                _loc_12.width = 28;
                _loc_12.height = 20;
                _loc_12.text = _loc_8;
                _loc_12.selectable = false;
                if (_loc_15)
                {
                    _loc_12.setTextFormat(_tfmDisabledDay);
                }
                else if (_loc_9)
                {
                    _loc_12.setTextFormat(_tfmSelectedDay);
                }
                else if (_loc_10)
                {
                    _loc_12.setTextFormat(_tfmToday);
                }
                else
                {
                    _loc_12.setTextFormat(_tfmGrid);
                }
                gridCont.addChild(_loc_11);
                _loc_11.addChild(_loc_12);
                _loc_12.y = _loc_12.y - 2;
                (_loc_3.date + 1);
                _loc_8++;
            }
            mCount = mm;
            yCount = yy;
            _disallowPrev = selectableRangeStart.valueOf() >= new Date(yCount, mCount, 1).valueOf();
            _disallowNext = selectableRangeEnd.valueOf() <= _loc_3.valueOf();
            return;
        }// end function

        private function clearDateGrid() : void
        {
            var _loc_3:int = 0;
            var _loc_1 = null;
            var _loc_2:* = gridCont.numChildren;
            _loc_3 = _loc_2 - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_1 = gridCont.getChildAt(_loc_3) as Sprite;
                _loc_1.removeEventListener("click", onDateClick);
                _loc_1.removeEventListener("mouseOver", onOver);
                _loc_1.removeEventListener("mouseOut", onOut);
                gridCont.removeChildAt(_loc_3);
                _loc_3--;
            }
            return;
        }// end function

        private function onDateClick(event:MouseEvent) : void
        {
            var _loc_2:* = (event.target as DisplayObject).name.split(".");
            selectDate = new Date(_loc_2[2], _loc_2[1], _loc_2[0]);
            this.dispatchEvent(new Event("select"));
            return;
        }// end function

        public function show() : void
        {
            visible = true;
            return;
        }// end function

        public function hide() : void
        {
            visible = false;
            return;
        }// end function

        private function drawArrow(__x:Number, __y:Number, __rot:Number) : Sprite
        {
            var _loc_4:* = new Sprite();
            new Sprite().graphics.lineStyle(1, 0);
            _loc_4.graphics.beginFill(arrowColor);
            _loc_4.graphics.lineTo(0, -7.5);
            _loc_4.graphics.lineTo(7.5, 0);
            _loc_4.graphics.lineTo(0, 7.5);
            _loc_4.graphics.endFill();
            _loc_4.x = __x;
            _loc_4.y = __y;
            _loc_4.rotation = __rot;
            return _loc_4;
        }// end function

        private function drawRadialBackground(tw:Number, th:Number) : Sprite
        {
            var _loc_4:int = 0;
            var _loc_11:* = new Sprite();
            var _loc_12:String = "linear";
            var _loc_3:Array = [];
            _loc_3 = [4937575, 2040366];
            var _loc_10:Array = [1, 1];
            var _loc_5:Array = [0, 255];
            var _loc_6:* = new Matrix();
            new Matrix().createGradientBox(tw, th, 90, 0, 0);
            var _loc_7:String = "pad";
            _loc_11.graphics.beginGradientFill(_loc_12, _loc_3, _loc_10, _loc_5, _loc_6, _loc_7);
            _loc_11.graphics.lineStyle(2, 14277081);
            _loc_11.graphics.drawRoundRect(0, 0, tw, th, 5);
            _loc_4 = 0;
            var _loc_13:* = new GlowFilter(_loc_4, 1, 50, 25, 1, 3, true, false);
            var _loc_8:* = new DropShadowFilter(5, 90, 0, 1, 10, 10, 0.9, 1, false, false);
            var _loc_9:* = new Array(_loc_13, _loc_8);
            _loc_11.filters = _loc_9;
            return _loc_11;
        }// end function

        public function get dayNames() : Array
        {
            return _dayNames;
        }// end function

        public function set dayNames(dayNames:Array) : void
        {
            _dayNames = dayNames;
            return;
        }// end function

        public function get disabledDays() : Array
        {
            return _disabledDays;
        }// end function

        public function set disabledDays(disabledDays:Array) : void
        {
            _disabledDays = disabledDays;
            return;
        }// end function

        public function get firstDayOfWeek() : uint
        {
            return _firstDayOfWeek;
        }// end function

        public function set firstDayOfWeek(firstDayOfWeek:uint) : void
        {
            _firstDayOfWeek = firstDayOfWeek;
            return;
        }// end function

        public function get monthNames() : Array
        {
            return _monthNames;
        }// end function

        public function set monthNames(monthNames:Array) : void
        {
            _monthNames = monthNames;
            return;
        }// end function

        public function get selectableRangeStart() : Date
        {
            return _selectableRangeStart;
        }// end function

        public function set selectableRangeStart(selectableRangeStart:Date) : void
        {
            _selectableRangeStart = selectableRangeStart;
            return;
        }// end function

        public function get selectableRangeEnd() : Date
        {
            return _selectableRangeEnd;
        }// end function

        public function set selectableRangeEnd(selectableRangeEnd:Date) : void
        {
            _selectableRangeEnd = selectableRangeEnd;
            return;
        }// end function

        public function get selectDate() : Date
        {
            return _selectedDate;
        }// end function

        public function set selectDate(v:Date) : void
        {
            _selectedDate = v;
            if (!_selectedDate)
            {
                _selectedDate = new Date();
            }
            if (_inited && _todayDate.getFullYear() == yCount && _todayDate.getMonth() == mCount)
            {
                clearDateGrid();
                drawDateGrid(mCount, yCount);
            }
            return;
        }// end function

        public function get tfmMonth() : TextFormat
        {
            return _tfmMonth;
        }// end function

        public function set tfmMonth(tfmMonth:TextFormat) : void
        {
            _tfmMonth = tfmMonth;
            return;
        }// end function

        public function get tfmSelectedDay() : TextFormat
        {
            return _tfmSelectedDay;
        }// end function

        public function set tfmSelectedDay(tfmSelectedDay:TextFormat) : void
        {
            _tfmSelectedDay = tfmSelectedDay;
            return;
        }// end function

        public function get tfmGrid() : TextFormat
        {
            return _tfmGrid;
        }// end function

        public function set tfmGrid(tfmGrid:TextFormat) : void
        {
            _tfmGrid = tfmGrid;
            return;
        }// end function

        public function get showToday() : Boolean
        {
            return _showToday;
        }// end function

        public function set showToday(v:Boolean) : void
        {
            if (_showToday == v)
            {
                return;
            }
            _showToday = v;
            if (_inited && _todayDate.getFullYear() == yCount && _todayDate.getMonth() == mCount)
            {
                clearDateGrid();
                drawDateGrid(mCount, yCount);
            }
            return;
        }// end function

        public function get tfmToday() : TextFormat
        {
            return _tfmToday;
        }// end function

        public function set tfmToday(tfmToday:TextFormat) : void
        {
            _tfmToday = tfmToday;
            return;
        }// end function

    }
}
