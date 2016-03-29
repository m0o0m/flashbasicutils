package
{
	import avmplus.getQualifiedClassName;
	
	import com.adobe.utils.StringUtil;
	import com.wg.logging.ConsoleLogger;
	import com.wg.logging.Log;
	import mymap.elements.MyselfElement;
	import com.wg.scene.elments.SeaMapSceneEntity;
	import com.wg.scene.utils.GameMathUtil;
	import com.wg.schedule.Scheduler;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.FileReference;
	import flash.net.LocalConnection;
	import flash.sampler.DeleteObjectSample;
	import flash.sampler.NewObjectSample;
	import flash.sampler.Sample;
	import flash.sampler.clearSamples;
	import flash.sampler.getSampleCount;
	import flash.sampler.getSamples;
	import flash.sampler.pauseSampling;
	import flash.sampler.startSampling;
	import flash.sampler.stopSampling;
	import flash.system.Capabilities;
	import flash.system.IME;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import mymap.scene.Mapscene;
	
	

	/**
	 * Client debug CMD, cmd的名字必须以public方式实现. F3 激活.
	 * @author boyo
	 * 
	 */	
	public class ClientdebugLogic
	{
		//Client Debug CMD================================================================================================
		private static const DEBUG_CMDS:Array = [
			"帮助----------------------------------------------",
			"Clientdebug: help psw s// 帮助(加参数1表示保存到电脑)",
			"--------------------------------------------------\n",
			
			"全局控制--------------------------------------------",
			"Clientdebug: frameRate value //修改帧频",
			"Clientdebug: showWmode //修改帧频",
			"Clientdebug: switchStats //打开关|闭性能测试",
			"Clientdebug: switchUI //打开|关闭UI条",
			"Clientdebug: switchActivityUI //打开|关闭活动图标",
			"Clientdebug: switchCampBossBattleInfoUI //打开|关闭阵营boss战信息ui",
			"Clientdebug: switchDieNotifyUI //打开|关闭复活界面ui",
			"Clientdebug: switchDungeonReward //打开|关闭副本结算ui",
			"Clientdebug: switchKaiFuActivity //打开|关闭开服活动ui",
			"Clientdebug: switchVipPanel //打开|关闭Vip ui",
			"Clientdebug: switchTavernPanel //打开|关闭酒馆 ui",
			"Clientdebug: switchSceneMouseEnable //打开|关闭场景鼠标事件",
			"Clientdebug: switchExcuteCMDErrorCatche //打开|关闭运行时报错捕捉",
			"Clientdebug: setClientTimeScale timeScale //设置时间缩放",
			"Clientdebug: enableLog true|false //Log开关设置",
			"Clientdebug: appendLogFilter level|func|content //添加Log过滤（空的也必须加|）",
			"Clientdebug: throwError msg //抛错误",
			"Clientdebug: switchAllowTrunkSendErrorMsg //trunk 报错提交",
			
			"Clientdebug: playDramma drammaId//播放剧情",
			"--------------------------------------------------\n",
			
			"场景控制--------------------------------------------",
			"Clientdebug: traceSceneInfo //打印场景信息）",
			"Clientdebug: traceSelfRangeElementsUIDS // 打印当前玩家范围内的uid",
			"Clientdebug: traceSceneGridNodeWalkable col row //打印可行走数据",
			"Clientdebug: traceSelfSceneElementUID //打印当前玩家uid",
			"Clientdebug: traceSceneElementInfo uid // 打印uid对象的信息",
			"Clientdebug: traceSceneElementExist uid //打印uid对象是否存在",
			"Clientdebug: traceSceneElementPosition uid //打印uid对象位置",
			"Clientdebug: traceSceneAllElementCount //打印场景所有元素数量",
			"Clientdebug: traceSceneGridWalkable //打印场景可行走信息",
			"Clientdebug: showSceneElementDebugLine uid true|false //显示关闭uid对象的调试线",
			"Clientdebug: moveSceneElement uid x y //将uid对象移动到 x，y坐标",
			"Clientdebug: moveSelfToTarget uid //将当前玩家移动到uid处",
			"Clientdebug: followTargetFromSceneElementAToSceneElementB uidA uidB //将A对象设置跟随B对象",
			"Clientdebug: callSceneElementFunction uid parameters //设置场景对象方法",
			"Clientdebug: createMockMonsterElement modelIds(XX,XXX,XXX) count radius isLoopMoving //在当前玩家周围随机创建N个怪物对象，并移动",
//			"Clientdebug: createMockMonsterElement 2100027,2100028,2100029 10 500 true //在当前玩家周围随机创建N个怪物对象，并移动",
			"Clientdebug: removeSceneElementByUID uid //删除uid的场景对象",
			"Clientdebug: removeAllSceneElements //删除所有其他场景元素",
			"Clientdebug: enableFogOfWar true|false //打开|关闭迷雾",
			"Clientdebug: setBattleSceneAlpah alpha //设置战斗场景透明",
			"Clientdebug: setSceneSeaColor color //设置场景颜色",
			"Clientdebug: enablePrintSceneElementCRUD 1/0 //设置场景CRUD操作",
			"Clientdebug: switchAvatarCache //开启模型缓存模式",
			
			"--------------------------------------------------\n",	
			"摄像机控制--------------------------------------------",
			"Clientdebug: followCameraToTarget uid //摄像机跟随uid对象",
			"Clientdebug: resetCamerToSelfTarget // 摄像机回放跟随自己",
			"Clientdebug: dettachCamerFromTarget //解除摄像机的跟随",
			"Clientdebug: moveToCamera x y //移动摄像机",
			"Clientdebug: moveDeltaCamera x y //移动摄像机",
			"Clientdebug: fadeCamera color time isFadeIn",
			"Clientdebug: stopFadeCamera",
			"Clientdebug: shakeCamera intensity duration direction //抖动摄像机镜头   shakeCamera 0.05 0.5 0",
			"Clientdebug: stopShakeCamera",
			"Clientdebug: wideScreenCamera duration height  isWideOut //宽屏幕效果",
			"Clientdebug: stopWideScreenCamera",
			"Clientdebug: stopShakeCamera",
			"--------------------------------------------------\n",
			
			"战斗控制--------------------------------------------",
			"Clientdebug: openClientWarDebugMode //打开客户端战斗调试模式",
			"Clientdebug: quitFight //退出战斗",
			"Clientdebug: selfReleaseSkill skillId attackColIndex attackRowIndex subHP",
			"--------------------------------------------------\n",
			
			//profile
			"System Bebug--------------------------------------------",
			"Clientdebug:: systemInfo //系统信息(加参数表示保存到电脑)",
			"Clientdebug:: systemPause //flahs player 暂停 ",
			"Clientdebug:: systemResume //flahs player 继续",
			"Clientdebug:: systemPauseForGCIfCollectionImminent imminence",
			"Clientdebug: systemGC",
			"Clientdebug: foolGC",
			"Clientdebug: traceShareObjectCacheManagerInfo //打印对象缓存信息(加参数保存到电脑)",
			"Clientdebug: shareObjectCacheManagerForceSwip //强制一次扫描",
			"Clientdebug: debugStartSampling",
			"Clientdebug: debugStopSampling",
			"Clientdebug: debugPauseSampling",
			"Clientdebug: debugGetSampleCount",
			"Clientdebug: debugClearSamples",
			"Clientdebug: debugPrintAllSamples",
			"Clientdebug: debugSwitchKeyPressListener",
			"Clientdebug: debugSwitchMousePressListener",
			"--------------------------------------------------\n",
			
			"Clientdebug: openUI",
			"Clientdebug: switchLog",
			"Clientdebug: showGameConfig",
		];
		
		public function help(handlerName:String, parameters:Array):Boolean
		{
			if(parameters.length < 1)
			{
				Log.error("ClientdebugLogic Error: handlerName (" +  handlerName + " ) parameters format Error!!!");
			}
			
			var inputPSW:String = parameters[0];
			var psw:String = "boyo123";
			/*var rootParameters:Object = Config.stage.loaderInfo.parameters;
			if("clientDebugPSW" in rootParameters)
			{
				psw = rootParameters["clientDebugPSW"];
			}*/
			
			if(inputPSW != psw) 
			{
				Log.error("help psw error!");
				
				return false;
			}
			
			var results:String = "";
			
			for(var i:int = 0; i < DEBUG_CMDS.length; i++)
			{
				results += DEBUG_CMDS[i] + "\n"
			}
			
			if(parameters.length > 1)
			{
				var f:FileReference = new FileReference();
				f.save(results, "Client_Debug_CMD.text");
			}
			else
			{
				Log.info(results);
			}
			
			return true;
		}
		//================================================================================================================
		
		
		//================================================================================================================

		public function frameRate(handlerName:String, parameters:Array):Boolean
		{
			if(parameters.length == 0)
			{
				Log.error("ClientdebugLogic Error: handlerName (" +  handlerName + " ) parameters format Error!!!");
				
				return false;
			}
			
			var frameRate:Number = parameters[0];
			
			_stage.frameRate = frameRate;
			
			return true;
		}
		
		public function showWmode(handlerName:String, parameters:Array):Boolean
		{
//			Log.debug(Starling.context.driverInfo.toLowerCase());
			return true;
		}
		
/*		public function switchUI(handlerName:String, parameters:Array):Boolean
		{
			Config.view.layout.panelLayer.visible = Config.view.layout.chatLayer.visible = 
				!Config.view.layout.panelLayer.visible;
			
			return true;
		}*/
		
		
		
		
		
		
		public function switchTavernPanel(handlerName:String, parameters:Array):Boolean
		{
//			Config.view.tavern.show();
			return true;
		}
		
		public function switchSceneMouseEnable(handlerName:String, parameters:Array):Boolean
		{
			/*Config.view.screen.seaMapScene.mouseEnabled = 
				Config.view.screen.seaMapScene.mouseChildren = !Config.view.screen.seaMapScene.mouseChildren;
			*/
			return true;
		}
		
		private var mExcuteCMDErrorCatche:Boolean = true;
		
		public function switchExcuteCMDErrorCatche(handlerName:String, parameters:Array):Boolean
		{
			mExcuteCMDErrorCatche = !mExcuteCMDErrorCatche;
			
			Log.debug("excuteCMDErrorCatche: is open: " + mExcuteCMDErrorCatche);
			
			return true;
		}
		
		public function setClientTimeScale(handlerName:String, parameters:Array):Boolean
		{
			if(parameters.length == 0)
			{
				Log.error("ClientdebugLogic Error: handlerName (" +  handlerName + " ) parameters format Error!!!");
				
				return false;
			}
			
			var timeScale:Number = parameters[0];
			
			Scheduler.getInstance().timeScale = timeScale;
			
			return true;
		}
		
		public function enableLog(handlerName:String, parameters:Array):Boolean
		{
			if(parameters.length == 0)
			{
				Log.error("ClientdebugLogic Error: handlerName (" +  handlerName + " ) parameters format Error!!!");
				
				return false;
			}
			
			var enable:Boolean = parameters[0].toLowerCase() == "true";
			
			Log.instance.enable = enable;
			
			return true;
		}
		
		public function appendLogFilter(handlerName:String, parameters:Array):Boolean
		{
			if(parameters.length == 0)
			{
				Log.error("ClientdebugLogic Error: handlerName (" +  handlerName + " ) parameters format Error!!!");
				
				return false;
			}
			
			var parameterArr:Array = String(parameters[0]).split("|");
			if(!parameterArr || parameterArr.length != 3)
			{
				Log.error("ClientdebugLogic Error: handlerName (" +  handlerName + " ) parameters format Error. Need 3!!!");
				
				return false;
			}
			
			var level:String = parameterArr[0];
			var func:String = parameterArr[1];
			var content:String = parameterArr[2];
			
			var filter:Object = {};
			if(level && level.length)
			{
				filter.level = level;
			}
			
			if(func && func.length)
			{
				filter.func = func;
			}
			
			if(content && content.length)
			{
				filter.content = content;
			}
			
			Log.instance.appendFilter(filter);
			
			
			return true;
		}
		
		public function throwError(handlerName:String, parameters:Array):Boolean
		{
			var errorMsg:String = parameters.length > 0 ? parameters[0] : "";
			
			throw new Error(errorMsg);
			
			return true;
		}
		
		
		
		private function completeMove():void
		{
			trace("虚拟怪兽移动完成");
		}
		

		

		
		public static var isEnablePrintSceneElementCRUD:Boolean = false;
		
		public function enablePrintSceneElementCRUD(handlerName:String, parameters:Array):Boolean
		{
			if(parameters.length == 0)
			{
				Log.error("ClientdebugLogic Error: handlerName (" +  handlerName + " ) parameters format Error!!!");
				
				return false;
			}
			
			isEnablePrintSceneElementCRUD = parseInt(parameters[0]) == 1;
			
			return true;
		}
		
		
		//================================================================================================================

		
		
		public function traceSceneInfo(handlerName:String, parameters:Array):Boolean
		{
			Log.debug("ClientdebugLogic traceSceneInfo :" + Config.mapscene.toString());
			
			return true;
		}
	
		
		public function traceSelfRangeElementsUIDS(handlerName:String, parameters:Array):Boolean
		{
			if(parameters.length < 1)
			{
				Log.error("ClientdebugLogic Error: handlerName (" +  handlerName + " ) parameters format Error!!!");
				
				return false;
			}
			
			var range:Number = parseFloat(parameters[0]);
			if(isNaN(range) || range < 0) range = 0;
			
			var seaMapScene:Mapscene = Config.mapscene;
			var selfPlayer:MyselfElement = seaMapScene.currentSelfPlayer;
			
			var distance:Number = 0.0;
			
			function findFilterFunction(entity:SeaMapSceneEntity):Boolean
			{
				if(entity !== selfPlayer)
				{
					distance = GameMathUtil.distance(selfPlayer.x, selfPlayer.y , entity.x, entity.y);
					
					if(distance <= range)
					{
						return true;
					}
				}
				
				return false;
			}
			
			var results:Array = seaMapScene.getSceneElementsByFunction(findFilterFunction);
			if(results && results.length)
			{
				for each(var elemet:SeaMapSceneEntity in results)
				{
					Log.trace("uid: " + elemet.uid);
				}
			}
			else
			{
				Log.trace("no elements!");
			}
			
			return true;
		}
	
		
	
		
		
	
		
		
		public function switchLog(handlerName:String, parameters:Array):Boolean
		{
			ConsoleLogger.enable = !ConsoleLogger.enable;
			return true;
		}
		
	
		
		
		
		public function systemInfo(handlerName:String, parameters:Array):Boolean
		{
			var results:String = "";
			
			var IMconversionMode:String = IME.conversionMode;
			var IMenabled:Boolean = IME.enabled;
			var IMisSupported:Boolean = IME.isSupported;
			
			var	freeMemory:Number = System.freeMemory;
			var privateMemory:Number = System.privateMemory;
			var totalMemory:Number = System.totalMemory;
			var totalMemoryNumber:Number = System.totalMemoryNumber;
			
			results += 	"freeMemory: " + int(freeMemory * 100 / 1024 / 1024) * 0.01 + "M" + "\n" +
				"privateMemory: " + int(privateMemory * 100 / 1024 / 1024) * 0.01 + "M" + "\n" +
				"totalMemory: " + int(totalMemory * 100 / 1024 / 1024) * 0.01 + "M" + "\n" +
				"totalMemoryNumber: " + int(totalMemoryNumber * 100 / 1024 / 1024) * 0.01 + "M" + "\n" +
				"---------------------------------------\n" +
				"os : " + Capabilities.os + "\n" +
				"version: " + Capabilities.version + "\n" +
				"playerType: " + Capabilities.playerType + "\n" +
				"isDebugger: " + Capabilities.isDebugger + "\n" +
				"language : " + Capabilities.language + "\n" +
				"IMconversionMode: " + IMconversionMode + "\n" +
				"IMenabled: " + IMenabled + "\n" +
				"IMisSupported: " + IMisSupported + "\n" +
				"hasAudio: " + Capabilities.hasAudio + "\n" +
				"hasIME: " + Capabilities.hasIME + "\n" +
				"hasMP3: " + Capabilities.hasMP3 + "\n" +
				"pixelAspectRatio: " + Capabilities.pixelAspectRatio + "\n" +
				"screenColor: " + Capabilities.screenColor + "\n" +
				"screenDPI: " + Capabilities.screenDPI + "\n" +
				"screenResolutionX: " + Capabilities.screenResolutionX + "\n" +
				"screenResolutionY: " + Capabilities.screenResolutionY + "\n" +
				"serverString: " + Capabilities.serverString + "\n" +
				"supports32BitProcesses: " + Capabilities.supports32BitProcesses + "\n" +
				"supports64BitProcesses: " + Capabilities.supports64BitProcesses + "\n";
			
			if(parameters.length > 0)
			{
				var f:FileReference = new FileReference();
				f.save(results, "Client System Info.text");
			}
			else
			{
				Log.debug(results);
			}
			
			return true;
		}
		
		public function systemPause(handlerName:String, parameters:Array):Boolean
		{
			System.pause();
			
			return true;
		}
		
		public function systemResume(handlerName:String, parameters:Array):Boolean
		{
			System.resume();
			
			return true;
		}
		
		public function systemPauseForGCIfCollectionImminent(handlerName:String, parameters:Array):Boolean
		{
			if(parameters.length < 1)
			{
				Log.error("ClientdebugLogic Error: handlerName (" +  handlerName + " ) parameters format Error!!!");
				
				return false;
			}
			
			var imminence:Number = parseFloat(parameters[0]);
			
			System.pauseForGCIfCollectionImminent(imminence);
			
			return true;
		}
		
		public function systemGC(handlerName:String, parameters:Array):Boolean
		{
			System.gc();
			
			return true;
		}
		
		public function foolGC(handlerName:String, parameters:Array):Boolean
		{
			try 
			{
				new LocalConnection().connect("bdebdd96-7bf8-407b-bec9-8336b2b0c329");
				new LocalConnection().connect("bdebdd96-7bf8-407b-bec9-8336b2b0c329");
			}
			catch (error:Error) {
			}
			
			return true;
		}
		
		public function debugStartSampling(handlerName:String, parameters:Array):Boolean
		{
			startSampling();
			
			return true;
		}
		
		public function debugStopSampling(handlerName:String, parameters:Array):Boolean
		{
			stopSampling();
			
			return true;
		}
		
		public function debugPauseSampling(handlerName:String, parameters:Array):Boolean
		{
			pauseSampling();
			
			return true;
		}
		
		public function debugGetSampleCount(handlerName:String, parameters:Array):Boolean
		{
			Log.debug(getSampleCount());
			
			return true;
		}
		
		public function debugClearSamples(handlerName:String, parameters:Array):Boolean
		{
			clearSamples();
			
			return true;
		}
		
		public function debugPrintAllSamples(handlerName:String, parameters:Array):Boolean
		{
			var sample:Sample; 
			var typeString:String;
			var id:Number;
			var size:Number;
			var objectStr:String;
			var stackStr:String;
			var resultStr:String = "";
			var count:int = 0;
			
			resultStr += "remove----------------------------------------------------------\n";
			
			//--
			for each (sample in getSamples()) 
			{
				if (sample is DeleteObjectSample) 
				{
					count++;
					
					var deleteObjectSample:DeleteObjectSample = sample as DeleteObjectSample;
					
					id = deleteObjectSample.id;
					size = deleteObjectSample.size;
					stackStr = deleteObjectSample.stack ? deleteObjectSample.stack.toString() : "";
					
					resultStr += "remove id: " + id + "\n" +
						"size: " + size + "\n" + 
						"stack: " + stackStr + "\n\n";
				}
			}
			
			resultStr += "remove count:" + count + "----------------------------------------------------------\n";
			
			resultStr += "add----------------------------------------------------------\n";
			
			//---
			count = 0;
			for each (sample in getSamples()) 
			{
				if (sample is NewObjectSample) 
				{
					count++;
					
					var newObjectSample:NewObjectSample = sample as NewObjectSample;
					
					//type
					id = newObjectSample.id;
					
					typeString = getQualifiedClassName(newObjectSample.type);
					
					if(typeString == "String" ||
						typeString == "Array" ||
						typeString == "Number" ||
						typeString == "Object" ||
						typeString == "Error" ||
						typeString == "Date" ||
						typeString == "flash.geom::Point")
					{
						continue;
					}
					
					size = newObjectSample.size;
					stackStr = newObjectSample.stack ? newObjectSample.stack.join("\n") : "";
					objectStr = null;
					if(newObjectSample.object)
					{
						objectStr = "toString" in newObjectSample.object ? newObjectSample.object.toString() : "";
						
						if("name" in newObjectSample.object)
						{
							objectStr = "name: " + newObjectSample.object["name"];
						}
					}
					else
					{
//						objectStr = "mark as deleted Object";
						continue;
					}
					
					resultStr += "new object id: " + id + "\n" +
						"type: " + typeString + "\n" +
						"object: " + objectStr + "\n" + 
						"size: " + size + "\n" + 
						"stack: " + stackStr + "\n\n";
				} 
			}
			
			resultStr += "add count:" + count + "----------------------------------------------------------\n";
			
			//--
			
			
			var f:FileReference = new FileReference();
			f.save(resultStr, "Client Samples.text");
			
			return true;
		}
		
		private var mKeyPressListener:Boolean = false;
/*		public function debugSwitchKeyPressListener(handlerName:String, parameters:Array):Boolean
		{
			mKeyPressListener = !mKeyPressListener;
			
			if(mKeyPressListener)
			{
				Config.stage.addEventListener(KeyboardEvent.KEY_UP, stageDebugKeyPressHandler, false, int.MAX_VALUE);
			}
			else
			{
				Config.stage.removeEventListener(KeyboardEvent.KEY_UP, stageDebugKeyPressHandler);
			}
			
			Log.debug("KeyPressListener: is open: " + mKeyPressListener);
			
			return true;
		}*/
		
		private function stageDebugKeyPressHandler(event:KeyboardEvent):void
		{
			var altKey:Boolean = event.altKey;
			var ctrlKey:Boolean = event.ctrlKey;
			var shiftKey:Boolean = event.shiftKey;
			var charCode:uint = event.charCode;
			var char:String = String.fromCharCode(charCode);
			var keyCode:uint = event.keyCode;
			var keyLocation:uint = event.keyLocation;
			var targetStr:String = event.target ? 
				getQualifiedClassName(event.target) + " :: " + event.target.toString() :
				"Null";
			
			var results:String = "altKey: " + altKey + "\n" + 
				"ctrlKey: " + ctrlKey + "\n" + 
				"altKey: " + altKey + "\n" + 
				"shiftKey: " + shiftKey + "\n" + 
				"charCode: " + charCode + "\n" +
				"char: " + char + "\n" + 
				"charCode: " + charCode + "\n" + 
				"keyCode: " + keyCode + "\n" + 
				"keyLocation: " + keyLocation + "\n" +
				"target: " + targetStr;
			
			Log.debug("Key Press: \n" + results);
		}
		
		private var mMousePressListener:Boolean = false;
/*		public function debugSwitchMousePressListener(handlerName:String, parameters:Array):Boolean
		{
			mMousePressListener = !mMousePressListener;
			
			if(mMousePressListener)
			{
				Config.stage.addEventListener(MouseEvent.CLICK, stageDebugMousePressHandler, true);
			}
			else
			{
				Config.stage.removeEventListener(MouseEvent.CLICK, stageDebugMousePressHandler, true);
			}
			
			Log.debug("MousePressListener: is open: " + mMousePressListener);
			
			return true;
			
		}*/
		
/*		public function openUI(handlerName:String, parameters:Array):Boolean
		{
			var view:View = Config.view;
			
			if(parameters.length==1)
			{
				var viewName:String = parameters[0];
				if(view.hasOwnProperty(viewName))
				{
					view[viewName].show();
				}
			}
			return true;
		}*/
		
/*		public function showGameConfig(handlerName:String, parameters:Array):Boolean
		{
			Log.debug("defaultFont: " + Config.config.get("Font")["defaultFont"]);
			Log.debug("defaultSize: " + Config.config.get("Font")["defaultSize"]);
			Log.debug("language: " + Config.config.get("Font")["language"]);
			Log.debug("langTypes: " + StaticUtils.ENTER_GAME_LANG.langTypes);
			Log.debug("defaultLang: " +  StaticUtils.ENTER_GAME_LANG.defaultLang);
			return true;
		}*/
		
		private function stageDebugMousePressHandler(event:MouseEvent):void
		{
			var altKey:Boolean = event.altKey;
			var buttonDown:Boolean = event.buttonDown;
			var ctrlKey:Boolean = event.ctrlKey;
			var shiftKey:Boolean = event.shiftKey;
			var stageX:Number = event.stageX;
			var stageY:Number = event.stageY;
			var objectStr:String = event.target ? 
				getQualifiedClassName(event.target) + " :: " + event.target.toString() :
				"Null";
			
			var results:String = "altKey: " + altKey + "\n" +
				"buttonDown: " + buttonDown + "\n" +
				"ctrlKey: " + ctrlKey + "\n" +
				"shiftKey: " + shiftKey + "\n" +
				"stageX: " + stageX + "\n" +
				"stageY: " + stageY + "\n" +
				"target: " + objectStr;
			
			Log.debug("Mouse Press: \n" + results);
		}
		//============================================================================================================
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		//=========================================================================================================================
		
		private function stageKeyUpHandler(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.F3)
			{
				_debugInputTextField.visible = !_debugInputTextField.visible;
			}
			
			if(_debugInputTextField.visible)
			{
				event.stopImmediatePropagation();
			}
		}
		
		private function parseInputCMDCharsToMatchLogicCMD(handlerName:String, parameters:Array):Boolean
		{
			if(this.hasOwnProperty(handlerName) && this[handlerName] is Function)
			{
				var func:Function = this[handlerName] as Function;
				var result:Boolean = false;
				
				if(mExcuteCMDErrorCatche)
				{
					try
					{
						Log.debug("\n" + handlerName + ":=============================================================================\n");
						result = func(handlerName, parameters);
						Log.debug("\n=============================================================================\n");
						
						return result;
					}
					catch(error:Error)
					{
						Log.error("ClientdebugLogic Error: Function Excute Exception!!!  " + error.message.toString());
						
						return false;
					}
				}
				else
				{
					Log.debug("\n" + handlerName + ":=============================================================================\n");
					result = func(handlerName, parameters);
					Log.debug("\n=============================================================================\n");
					
					return result;
				}
			}
			else
			{
				Log.error("ClientdebugLogic Error: function not exsit!!!");
				
				return false;
			}
			
			return true;
		}
		
		//format: handler parameters
		private function excuteLogicCMD(cmdChars:String):void
		{
			if(!cmdChars || cmdChars.length == 0) 
			{
				Log.error("ClientdebugLogic Error: debug input format !!!");
				return;
			}
			
			var elementsArr:Array = cmdChars.split(" ");
			if(!elementsArr || elementsArr.length < 1) 
			{
				Log.error("ClientdebugLogic Error: debug input format !!!");
				return;
			}
			
			var handlerName:String = StringUtil.trim(elementsArr.shift().toString());
			var parameters:Array = elementsArr.concat();
			
			if(parseInputCMDCharsToMatchLogicCMD(handlerName, parameters))
			{
				_debugCMDStack.push(cmdChars);
				
				if(_debugCMDStack.length > DEBUG_CMD_LENGTH)
					_debugCMDStack.shift();
				
				_debugCMDStackIndex = _debugCMDStack.length - 1;
				_debugInputTextField.text = "";
			}
		}
		
		private function debugInputTextFieldKeyDownHandler(event:KeyboardEvent):void
		{
			if(!_debugInputTextField.visible) return;
			
			event.stopImmediatePropagation();
			
			if(event.keyCode == Keyboard.ENTER)
			{
				event.preventDefault();
				
				excuteLogicCMD(StringUtil.trim(_debugInputTextField.text));
			}
			else if(event.keyCode == Keyboard.UP)
			{
				if(_debugCMDStack.length > 0)
				{
					_debugInputTextField.text = _debugCMDStack[_debugCMDStackIndex];
					
					_debugCMDStackIndex--;
					if(_debugCMDStackIndex < 0) _debugCMDStackIndex = 0;
				}
			}
			else if(event.keyCode == Keyboard.DOWN)
			{
				if(_debugCMDStack.length > 0)
				{
					_debugInputTextField.text = _debugCMDStack[_debugCMDStackIndex];
					
					_debugCMDStackIndex++;
					if(_debugCMDStackIndex > _debugCMDStack.length - 1) _debugCMDStackIndex = _debugCMDStack.length - 1;
				}
			}
		}
		
		//======================================================================
		
		public function ClientdebugLogic(stage:Stage)
		{
			super();
			
			_stage = stage;
			
			_debugInputTextField = new TextField();
			_debugInputTextField.width = 600;
			_debugInputTextField.height = 20;
			_debugInputTextField.textColor = 0x000000;
			_debugInputTextField.background = true;
			_debugInputTextField.backgroundColor = 0xff0000;
			_debugInputTextField.border = true;
			_debugInputTextField.borderColor = 0xEEEEEE;
			_debugInputTextField.visible = true;
//						_debugInputTextField.x = 100;
//						_debugInputTextField.y = 100;
			_debugInputTextField.name = "_debugInputTextField";
			_stage.addChild(_debugInputTextField);
			
			_debugInputTextField.type = TextFieldType.INPUT;
			_debugInputTextField.addEventListener(KeyboardEvent.KEY_DOWN, debugInputTextFieldKeyDownHandler);
			
			_stage.addEventListener(KeyboardEvent.KEY_UP, stageKeyUpHandler);
		}
		
		//======================================================================
		private static const DEBUG_CMD_LENGTH:uint = 5;
		
		private var _debugInputTextField:TextField;
		private var _stage:Stage;
		private var _debugCMDStack:Array = [];
		private var _debugCMDStackIndex:int = 0;
	}
}