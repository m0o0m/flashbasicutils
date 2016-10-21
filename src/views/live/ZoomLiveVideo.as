/*
* Copyright(c) 2011 the original author or authors.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
* either express or implied. See the License for the specific language
* governing permissions and limitations under the License.
*/
package  views.live
{
	import com.ql.gameKit.manager.AssetManager;
	import com.ql.vgame.common.data.Resource;
	import com.ql.vgame.hall.view.skin.HallSkin;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * 放大的现场视频
	 * @author FF
	 */
	public class ZoomLiveVideo extends LiveVideo
	{
		private var _closeCallback:Function;
		
		public function ZoomLiveVideo(closeCallback:Function,con:MovieClip)
		{
			_closeCallback=closeCallback;
			super(con);
		}
		
		protected function getAsset():Class
		{
			return Config.resourceLoader.getClass("LiveVideoMcBig","videoComp");
		}
		
		override public function deactive():void
		{
			super.deactive();
			targetMc.closeBtn.removeEventListener(MouseEvent.CLICK, onClose);
		}
		
		override public function active():void
		{
			super.active();
			targetMc.closeBtn.addEventListener(MouseEvent.CLICK, onClose);
		}
		
		private function onClose(event:MouseEvent):void
		{
			if (null != _closeCallback) {
				_closeCallback();
			}
		}
	}
}
import com.ql.vgame.hall.view.component.video;

