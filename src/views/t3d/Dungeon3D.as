package views.t3d
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 * @author Administrator
	 * 
	 */
	public class Dungeon3D extends MovieClip
	{
		public var Ceiling:Class;
		public var Floor:Class;
		public var Coin:Class;
		public var Wall:Class;
		public var Map:Class;
		public var Square:Class;
		private var viewSprite:Sprite;
		private var worldSprite:Sprite;
		private var map:Object;
		private var worldObjects:Array;
		private var squares:Array;
		private var leftArrow:Boolean;
		private var rightArrow:Boolean;
		private var upArrow:Boolean;
		private var downArrow:Boolean;
		
		// keep track of virtual position of character
		private var charPos:Point = new Point(0,0);
		// car direction and speed
		private var dir:Number = 90;
		private var speed:Number = 0;
		public function Dungeon3D()
		{
			super();
			
		}
		public function init():void
		{
			initContainer();
			addCeil();
			addFloor();
			addWallWithMap();
			zSort();
			addEvent();
		}
		private function initContainer():void
		{
			// create the world and center it
			viewSprite = this;
			viewSprite.x = 275;//550
			viewSprite.y = 250;//400
			viewSprite.z = -1100;
			//addChild(viewSprite);
			
			// add an inner sprite to hold everything, lay it down
			worldSprite = new Sprite();
			viewSprite.addChild(worldSprite);
			worldSprite.rotationX = -90;
		}
		//==================================================
		private function addCeil():void
		{
			// cover above with ceiling tiles
			for(var i:int=-5;i<5;i++) {
				for(var j:int=-6;j<1;j++) {
					var ceiling:MovieClip = new Ceiling();
					ceiling.x = i*200;
					ceiling.y = j*200;
					ceiling.z = -200; // above
					worldSprite.addChild(ceiling);
				}
			}
		}
		
		private function addFloor():void
		{
			// cover below with floor tiles
			for(var i=-5;i<5;i++) {
				for(var j=-6;j<1;j++) {
					var floor:MovieClip = new Floor();
					floor.x = i*200;
					floor.y = j*200;
					floor.z = 0; // below
					worldSprite.addChild(floor);
				}
			}
		}
		//=============================================
		private function addWallWithMap():void
		{
			// get the game map
			map = new Map();
			
			// look for squares in map, and put four walls in each spot
			// also move coins up and rotate them
			worldObjects = new Array();
			squares = new Array();
			for(var i=0;i<map.numChildren;i++) {
				var object:MovieClip = map.getChildAt(i);
				
				if (object is Square) {
					// add four walls, one for each edge of square
					addWall(object.x+object.width/2, object.y, object.width, 0);
					
					addWall(object.x, object.y+object.height/2, object.height, 90);
					addWall(object.x+object.width, object.y+object.height/2, object.height, 90);
					addWall(object.x+object.width/2, object.y+object.height, object.width, 0);
					
					// remember squares for collision detection
					squares.push(object);
					
				} else if (object is Coin) {
					object.z = -50; // move up
					object.rotationX = -90; // turn to face player
					worldSprite.addChild(object);
					worldObjects.push(object); // add to array fo zSort
				}
			}
			
		}
		// add a vertical wall 
		public function addWall(x, y, len, rotation):void {
			var wall:MovieClip = new Wall();
			wall.x = x ;
			wall.y = y;
			wall.z = -wall.height/2;
			wall.width = len;
			wall.rotationX = 90;
			wall.rotationZ = rotation;
			worldSprite.addChild(wall);
			worldObjects.push(wall);
			
		}
		
		//======================================================
		private function addEvent():void
		{
			// respond to key events
			Config.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyPressedDown);
			Config.stage.addEventListener(KeyboardEvent.KEY_UP,keyPressedUp);
			
			// advance game
			addEventListener(Event.ENTER_FRAME, moveGame);
		}
		// set arrow variables to true
		public function keyPressedDown(event:KeyboardEvent):void {
			if (event.keyCode == 37) {
				leftArrow = true;
			} else if (event.keyCode == 39) {
				rightArrow = true;
			} else if (event.keyCode == 38) {
				upArrow = true;
			} else if (event.keyCode == 40) {
				downArrow = true;
			}
		}
		
		// set arrow variables to false
		public function keyPressedUp(event:KeyboardEvent):void {
			if (event.keyCode == 37) {
				leftArrow = false;
			} else if (event.keyCode == 39) {
				rightArrow = false;
			} else if (event.keyCode == 38) {
				upArrow = false;
			} else if (event.keyCode == 40) {
				downArrow = false;
			}
		}
		// main game function
		public function moveGame(e):void {
			
			// see if turning left or right
			var turn:Number = 0;
			if (leftArrow) {
				turn = 10;
			} else if (rightArrow) {
				turn = -10;
			}
			
			// turn
			if (turn != 0) {
				//turnPlayer(turn);
			}
			
			// if up arrow pressed, then accelerate, otherwise decelerate
			speed = 0;
			if (upArrow) {
				speed = 10;
			} else if (downArrow) {
				speed = -10;
			}
			
			// move
			if (speed != 0) {
				//movePlayer(speed);
			}
			
			// re-sort objects
			if ((speed != 0) || (turn != 0)) {
				//zSort();
			}
			
			// see if any coins hit
			//checkCoins();
			trace(1);
			//测试用
			this.x += turn;
			this.y += speed;
		}
		public function movePlayer(d):void {
			// calculate current player area
			
			// make a rectangle to approximate space used by player
			var charSize:Number = 50; // approximate player size
			var charRect:Rectangle = new Rectangle(charPos.x-charSize/2, charPos.y-charSize/2, charSize, charSize);
			
			// get new rectangle for future position of player
			var newCharRect:Rectangle = charRect.clone();
			var charAngle:Number = (-dir/360)*(2.0*Math.PI);
			var dx:Number = d*Math.cos(charAngle);
			var dy:Number = d*Math.sin(charAngle);
			newCharRect.x += dx;
			newCharRect.y += dy;
			
			// calculate new location
			var newX:Number = charPos.x + dx;
			var newY:Number = charPos.y + dy;
			
			// loop through squares and check collisions
			for(var i:int=0;i<squares.length;i++) {
				
				// get block rectangle, see if there is a collision
				var blockRect:Rectangle = squares[i].getRect(map);
				if (blockRect.intersects(newCharRect)) {
					
					// horizontal push-back
					if (charPos.x <= blockRect.left) {
						newX +=  blockRect.left - newCharRect.right;
					} else if (charPos.x >= blockRect.right) {
						newX += blockRect.right - newCharRect.left;
					}
					
					// vertical push-back
					if (charPos.y >= blockRect.bottom) {
						newY +=  blockRect.bottom - newCharRect.top;
					} else if (charPos.y <= blockRect.top) {
						newY +=  blockRect.top - newCharRect.bottom;
					}
				}
				
			}
			
			// move character position
			charPos.y = newY;
			charPos.x = newX;
			
			// move terrain to show proper view
			worldSprite.x = -newX;
			worldSprite.z = newY;
		}
		//=====================================
		// spin coins and see if any have been hit
		private function checkCoins():void {
			
			// look at all objects
			for(var i:int=worldObjects.length-1;i>=0;i--) {
				
				// only look at coins
				if (worldObjects[i] is Coin) {
					
					// spin it!
					worldObjects[i].rotationZ += 10;
					
					// check distance from character
					var dist:Number = Math.sqrt(Math.pow(charPos.x-worldObjects[i].x,2)+Math.pow(charPos.y-worldObjects[i].y,2));
					
					// if close enough, remove coin
					if (dist < 50) {
						worldSprite.removeChild(worldObjects[i]);
						worldObjects.splice(i,1);
					}
				}
			}
		}
		private function turnPlayer(d):void {
			
			// change direction
			dir += d;
			
			// rotate world to change view
			viewSprite.rotationY = dir-90;
		}
		// sort all objects so the closest ones are highest in the display list
		private function zSort():void {
			var objectDist:Array = new Array();
			for(var i:int=0;i<worldObjects.length;i++) {
				var z:Number = worldObjects[i].transform.getRelativeMatrix3D(this.parent).position.z;
				objectDist.push({z:z,n:i});
			}
			objectDist.sortOn( "z", Array.NUMERIC | Array.DESCENDING );
			for(i=0;i<objectDist.length;i++) {
				worldSprite.addChild(worldObjects[objectDist[i].n]);
			}
		}
	}
}