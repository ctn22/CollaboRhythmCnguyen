/**
 * Copyright 2011 John Moore, Scott Gilroy
 *
 * This file is part of CollaboRhythm.
 *
 * CollaboRhythm is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later
 * version.
 *
 * CollaboRhythm is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with CollaboRhythm.  If not, see
 * <http://www.gnu.org/licenses/>.
 */
package collaboRhythm.plugins.diary.model
{

	public class UrineEntry
	{

        private var _date:Date;
        private var _value:String;
        private var _color:String;
        private var _comment:String;


        public function UrineEntry(date:Date, text:String, color:String, comment:String) {
            _date = date;
            _value = text;
            _color = color;
            _comment = comment;
        }
        public function get date():Date {
            return _date;
        }
        public function get text():String {
            return _value;
        }
        public function get color():String {
            return _color
        }
        public function get comment():String{
            return _comment;
        }

	}
}
