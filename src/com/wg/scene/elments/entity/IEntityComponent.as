package com.wg.scene.elments.entity
{
	public interface IEntityComponent
	{
		function set owner(value:BasicSceneEntity):void;
		function get owner():BasicSceneEntity;
	}
}