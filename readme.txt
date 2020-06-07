ssm-crud（员工管理系统）IDEA版

技术点:
基础框架-ssm（SpringMVC+Spring+MyBatis）
数据库-MySQL 数据库连接池-druid
前端框架-bootstrap快速搭建简洁美观的界面
项目的依赖管理-Maven
分页-pagehelper
逆向工程-MyBatis Generator
功能点:
1、 分页-pagehelper
2、数据校验： jquery前端校验+JSR303后端校验
3、ajax
4、Rest风格的URI；使用HTTP协议请求方式的动词，来表示对资源的操作（GET（查询），POST（新增），PUT（修改），DELETE（删除））


通过Mybatis的逆向工程生成com.ssm.bean，com.ssm.dao，mapper下的文件

基础环境搭建
1、创建一个maven工程
2、引入项目的jar包 
spring、springmvc，mybatis，数据库连接池等
3、引入bootstrap前端框架
4、编写ssm整合的关键配置文件Web.xml
Spring配置文件的核心点：

 spring的配置文件 主要配置和业务逻辑有关的 数据源  事务控制等

 <!--  配置注解扫描-->
 <context:component-scan base-package="com.yc.ssm" use-default-filters="true">
           <!-- 扫描排除有@controller的类-->
    <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
</context:component-scan>
数据源
<!-- 导入外部文件-->
<context:property-placeholder location="classpath:jdbc.properties"/>
<!--        连接池druid -->
<bean id="druid" class="com.alibaba.druid.pool.DruidDataSource" init-method="init" destroy-method="close">
    <!--        基本属性：url，user，password-->
    <property name="url" value="${jdbc.url}"/>
    <property name="username" value="${jdbc.user}"/>
    <property name="password" value="${jdbc.password}"/>
    <property name="driverClassName" value="${jdbc.driverClass}"/>
    <!--        配置初始化大小-->
    <property name="initialSize" value="1"/>
    <property name="minIdle" value="1"/>
    <property name="maxActive" value="3"/>
    <!--        获取连接等待超时时间-->
    <property name="maxWait" value="3000"/>
    <property name="timeBetweenEvictionRunsMillis" value="60000"/>
    <property name="minEvictableIdleTimeMillis" value="300000"/>
    <property name="validationQuery" value="SELECT 'x'"/>
    <property name="testWhileIdle" value="true"/>
    <property name="testOnBorrow" value="false"/>
    <property name="testOnReturn" value="false"/>
</bean>

与mybatis的整合
 <!-- 配置和Mybatis的整合sqlSessionFactory-->
    <bean id="sqlSessionFactory04" class="org.mybatis.spring.SqlSessionFactoryBean">
        <!--指定mybatis全局配置文件的位置-->
        <property name="configLocation" value="mybatis-config.xml"/>
        <!--数据源-->
        <property name="dataSource" ref="druid"/>
        <!--指定mybatis的Mapper数据文件-->
        <property name="mapperLocations" value="classpath:mapper/*.xml"/>
<!--        <property name="typeAliasesPackage" value="com.yc.ssm.entity"/>-->
<!--        <property name="plugins">-->
<!--        <list>-->
<!--            <bean class="com.github.pagehelper.PageInterceptor">-->
<!--                <property name="properties">-->
<!--                    <value>resonable=true</value>-->
<!--                </property>-->
<!--            </bean>-->
<!--        </list>-->
<!--    </property>-->

    </bean>
    <!--配置扫描器 将mybatis接口的实现加入到ioc容器中-->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <!--扫描所有的dao接口 将实现加入到IOC容器中-->
        <property name="basePackage" value="com.yc.ssm.dao"/>
    </bean>

事务控制
<!--事务管理控制-->
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <!--控制住数据源-->
    <property name="dataSource" ref="druid"/>
</bean>
<!--    开启基于注解@trasanction的事务-->
<aop:config>
    <!--切入点表达式-->
    <aop:pointcut id="txPoint" expression="execution(* com.yc.ssm.service..*(..) )"/>
    <!--配置事务增强-->
    <aop:advisor advice-ref="txAdvice" pointcut-ref="txPoint"/>
</aop:config>
<!--配置事务增强 事务如何切入-->
<tx:advice id="txAdvice">
    <tx:attributes >
        <!--所有方法都是事务方法-->
        <tx:method name="*"/>
        <!--以get开始的方法都是事务方法-->
        <tx:method name="get*" read-only="true"/>
    </tx:attributes>

</tx:advice>
springMVC配置文件的核心点：
<!-- 扫描controller -->
<context:component-scan base-package="com.yc.ssm.controller" use-default-filters="false">
    <!--只扫描控制器-->
    <context:include-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
</context:component-scan>
<!-- 视图解析器 方便页面返回 -->
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/views/"/>
    <property name="suffix" value=".jsp"/>
</bean>
<!--注册静态资源 将springmvc不能处理的资源交给tomcat-->
<mvc:default-servlet-handler/>
<!--注册注解开发驱动 支持springmvc更高级的功能，譬如JSP303校验，更快捷的ajax，映射文件-->
Jdbc.properties
jdbc.user=root
jdbc.password=123456
jdbc.url=jdbc:mysql://localhost:3306/ssm_crud?useUnicode=true&charcterEncoding=utf-8
jdbc.driverClass=com.mysql.jdbc.Driver
Mybatis配置文件
<configuration>
    <settings>
        <!--驼峰命名-->
        <setting name="mapUnderscoreToCamelCase" value="true"/>
    </settings>

    <typeAliases>
        <package name="com.yc.ssm.entity"/>
    </typeAliases>
    <plugins>
        <plugin interceptor="com.github.pagehelper.PageInterceptor">
            <!--分页参数合理化-->
            <property name="reasonable" value="true"/>
        </plugin>
    </plugins>
</configuration>

Web.xml
<!--    启动spring容器-->
    <context-param>
        <param-name>contextConfigLocation </param-name>
        <param-value>classpath:applicationContext.xml</param-value>
    </context-param>
    <listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
<!--    springmvc前端控制器 拦截所有请求-->
    <servlet>
        <servlet-name>springMVC</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:springMVC-servlet.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>

    </servlet>
    <servlet-mapping>
        <servlet-name>springMVC</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
    <!--解决springMVC中post乱码问题  放在所有过滤器之前-->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>utf-8</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
    <!--    rest风格的URI 将页面普通的post请求转化为普通的delete或者put请求-->
    <filter>
        <filter-name>HiddenHttpMethodFilter</filter-name>
        <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>HiddenHttpMethodFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

<!--    在Spring MVC过滤器-HiddenHttpMethodFilter中我们提到，-->
<!--    jsp或者说html中的form的method值只能为post或get，我们可以通过HiddenHttpMethodFilter获取put表单中的参数-值，-->
<!--    而在Spring3.0中获取put表单的参数-值还有另一种方法，即使用HttpPutFormContentFilter过滤器。-->
<!--    HttpPutFormContentFilter过滤器的作为就是获取put表单的值，并将之传递到Controller中标注了method为RequestMethod.put的方法中-->
<!--    &lt;!&ndash;支持发送PUT之类的请求，并将请求体中的数据解析进行封装成map-->
<!--    request被重新包装，request.getParameter()被重新重写&ndash;&gt;-->
    <filter>
        <filter-name>HttpPutFormContentFilter</filter-name>
        <filter-class>org.springframework.web.filter.HttpPutFormContentFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>HttpPutFormContentFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
</web-app>
查询
1.访问index.jsp页面
2.Index.jsp页面发送出查询员工列表的请求
3.EmployeeController来接收请求，查出员工数据
4.来到list.jsp页面进行展示
URI:
查询-ajax
1.访问index.jsp页面直接发送ajax请求进行员工数据分页查询
2.服务器将查出的数据以json字符串形式返回给浏览器
3.浏览器收到json字符串后使用js进行解析，使用js通过DOM增删改改变页面；
4.返回json。实现客户端的无关性。
URI:

