 <!--
 
redis充当tomcat7 session store需要用到的jar包使用说明：
1、将zip解压出来的jar包放到tomcat的lib目录下.
2、修改tomcat/conf下的context.xml文件，示例如下：
3、如果redis服务器不设置密码,请把password去掉
 
 -->
 
 <!-- Default set of monitored resources -->
    <WatchedResource>WEB-INF/web.xml</WatchedResource>

    <!-- Uncomment this to disable session persistence across Tomcat restarts -->
    <!--
    <Manager pathname="" />
    -->

    <!-- Uncomment this to enable Comet connection tacking (provides events
         on session expiration as well as webapp lifecycle) -->
    <!--
    <Valve className="org.apache.catalina.valves.CometConnectionManagerValve" />
	-->

	<Valve className="com.orangefunction.tomcat.redissessions.RedisSessionHandlerValve" />        
	<Manager className="com.orangefunction.tomcat.redissessions.RedisSessionManager" 
		host="localhost" 
		port="6379" 
		password="lailake"
		database="0" 
		maxInactiveInterval="60"/>