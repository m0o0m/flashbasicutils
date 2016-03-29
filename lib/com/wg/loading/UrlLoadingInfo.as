package com.wg.loading
{
	
	import com.wg.utils.arrayUtils.ArrayUtil;
	
	import flash.events.ProgressEvent;

	public class UrlLoadingInfo
	{
		public var datas:Array = [];
		public var waitingDatas:Array = [];
		public var successDatas:Array = [];
		public var errorDatas:Array = [];

		public var loadingData:UrlData;
		public var loadingDataIndex:int = -1;
		public var loadingDataProgressEvent:ProgressEvent;

		public var onProgress:Function;
		public var onCompleteOnce:Function;
		public var onComplete:Function;
		
		public function UrlLoadingInfo(datas_:Array, onProgress_:Function, onCompleteOnce_:Function, onComplete_:Function)
		{
			datas = ArrayUtil.cloneArray(datas_);
			waitingDatas = ArrayUtil.cloneArray(datas);
			onProgress = onProgress_;
			onCompleteOnce = onCompleteOnce_;
			onComplete = onComplete_;			
		}
	}
}