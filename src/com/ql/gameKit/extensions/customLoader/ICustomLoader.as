package com.ql.gameKit.extensions.customLoader
{

    public interface ICustomLoader
    {


        function start() : void;

        function close(isDispose:Boolean = false) : void;

        function destroy() : void;

    }
}
