<h2>逗你呢(dounine)框架管理系统 - 分布式集群项目</h2>
<h2>环境配置</h2>

**1**： eclipse等(IDE)<br/>
**2**： jdk7<br/>
**3**： git<br/>
**4**： maven<br/>
**5**： tomcat7.0<br/>
**6**： mysql<br/>
**7**： redis (配带windows)<br/>
**8**： nginx (配带)<br/>
<h2>部署开发环境</h2>
**①**:(方式一:使用 **Eclipse** )<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **1**. 下载地址 [Eclipse IDE for Java EE Developers]( http://eclipse.org/downloads/ )(带git的版本)<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **2**. 启动 eclpse,导入dounine-frame<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **3**. File -> Import -> Git -> Projects from Git -> Clone URI<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **4**. 然后在URI输入：`https://git.oschina.net/huanghuanlai/dounine.git`<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **5**. 等待漫长的下载过程....<br/>

**②**:(方式二:使用 **Git** )<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **1**. 下载地址 [ git for windows ] ( http://msysgit.github.io/ )<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **2**. 启动git,导入dounine-frame<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **3**. Git-Bash  -> 输入命令:` git clone https://git.oschina.net/huanghuanlai/dounine.git`<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **4**. 等待项目的下载...<br/>

**③**: 创建/instruction/sql/install.sql数据库<br/><br/>
**④**: 启动 **Redis** 缓存服务器,运行 `/instruction/tools/redis/start1.bat` <br/>

<h2>项目部署</h2>
&nbsp;&nbsp;&nbsp;&nbsp; **1**. 修改 /src/main/resources/jdbc.properties 里的数据库链接、用户名和密码为生产环境的值<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **2**. 修改 /src/main/resources/redis.properties 里的redis、用户名和密码为生产环境的值（默认不用）<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **3**. 配置会话共享  请按照/instruction/tools/tomcat7集群/readme.txt 里面的说明来完成操作<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **4**. 启动Redis缓存服务器<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **5**. `mvn clean package`<br/>
&nbsp;&nbsp;&nbsp;&nbsp; **6**. 生成/target/dounine-frame.war<br/>
<h2>项目交流</h2>

&nbsp;&nbsp;&nbsp;&nbsp;项目问题交流群： **174481989** <br/></br/></br/>
