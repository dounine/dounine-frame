#dounine-frame 分布式集群项目

##环境配置

* 如下工具需要自行下载
 * eclipse等(IDE)
 * jdk7
 * git
 * maven3.0
 * tomcat7.0
 * mysql5.5
 * redis (配带windows)
 * nginx (配带)

##部署开发环境

* 方式一:使用 **Eclipse**
  * 下载地址 [Eclipse IDE for Java EE Developers]( http://eclipse.org/downloads/ )(带git的版本)
  * 启动 eclpse,导入dounine-frame
  * File -> Import -> Git -> Projects from Git -> Clone URI
  * 然后在URI输入：`https://github.com/dounine/dounine-frame.git`
  * 然后就等待漫长的下载过程吧....

* 方式二:使用 **Git**
  * 下载地址 [git]( http://msysgit.github.io/ )
  * 使用 `git` 克隆 `dounine-frame` 项目
 
  ```shell
  git clone https://github.com/dounine/dounine-frame.git
  ```
  
  * 继续等待漫长的下载过程吧....

##项目部署

* 步骤如下:
  * 导入 `/instruction/sql/install.sql` 数据库脚本
  * 修改 `/src/main/resources/jdbc.properties` 里的数据库链接、用户名和密码为生产环境的值
  * 修改 `/src/main/resources/redis.properties` 里的redis、用户名和密码为生产环境的值(默认不用)
  * 如需配置会话共享(集群),请参照 `/instruction/tools/tomcat7集群/readme.txt` 里面的说明来完成操作
  * 启动 `Redis` 执行(`/instruction/tools/redis/start1.bat`)缓存服务器
  * 执行打包 `mvn clean package`
  * 在 `target` 目录下会自动生成 `dounine-frame.war` 压缩包
  * 就可以把 `dounine-frame.war` 压缩包扔到tomcat的webapps里面了
