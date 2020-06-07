ssm-crud��Ա������ϵͳ��IDEA��

������:
�������-ssm��SpringMVC+Spring+MyBatis��
���ݿ�-MySQL ���ݿ����ӳ�-druid
ǰ�˿��-bootstrap���ٴ������۵Ľ���
��Ŀ����������-Maven
��ҳ-pagehelper
���򹤳�-MyBatis Generator
���ܵ�:
1�� ��ҳ-pagehelper
2������У�飺 jqueryǰ��У��+JSR303���У��
3��ajax
4��Rest����URI��ʹ��HTTPЭ������ʽ�Ķ��ʣ�����ʾ����Դ�Ĳ�����GET����ѯ����POST����������PUT���޸ģ���DELETE��ɾ������


ͨ��Mybatis�����򹤳�����com.ssm.bean��com.ssm.dao��mapper�µ��ļ�

���������
1������һ��maven����
2��������Ŀ��jar�� 
spring��springmvc��mybatis�����ݿ����ӳص�
3������bootstrapǰ�˿��
4����дssm���ϵĹؼ������ļ�Web.xml
Spring�����ļ��ĺ��ĵ㣺

 spring�������ļ� ��Ҫ���ú�ҵ���߼��йص� ����Դ  ������Ƶ�

 <!--  ����ע��ɨ��-->
 <context:component-scan base-package="com.yc.ssm" use-default-filters="true">
           <!-- ɨ���ų���@controller����-->
    <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
</context:component-scan>
����Դ
<!-- �����ⲿ�ļ�-->
<context:property-placeholder location="classpath:jdbc.properties"/>
<!--        ���ӳ�druid -->
<bean id="druid" class="com.alibaba.druid.pool.DruidDataSource" init-method="init" destroy-method="close">
    <!--        �������ԣ�url��user��password-->
    <property name="url" value="${jdbc.url}"/>
    <property name="username" value="${jdbc.user}"/>
    <property name="password" value="${jdbc.password}"/>
    <property name="driverClassName" value="${jdbc.driverClass}"/>
    <!--        ���ó�ʼ����С-->
    <property name="initialSize" value="1"/>
    <property name="minIdle" value="1"/>
    <property name="maxActive" value="3"/>
    <!--        ��ȡ���ӵȴ���ʱʱ��-->
    <property name="maxWait" value="3000"/>
    <property name="timeBetweenEvictionRunsMillis" value="60000"/>
    <property name="minEvictableIdleTimeMillis" value="300000"/>
    <property name="validationQuery" value="SELECT 'x'"/>
    <property name="testWhileIdle" value="true"/>
    <property name="testOnBorrow" value="false"/>
    <property name="testOnReturn" value="false"/>
</bean>

��mybatis������
 <!-- ���ú�Mybatis������sqlSessionFactory-->
    <bean id="sqlSessionFactory04" class="org.mybatis.spring.SqlSessionFactoryBean">
        <!--ָ��mybatisȫ�������ļ���λ��-->
        <property name="configLocation" value="mybatis-config.xml"/>
        <!--����Դ-->
        <property name="dataSource" ref="druid"/>
        <!--ָ��mybatis��Mapper�����ļ�-->
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
    <!--����ɨ���� ��mybatis�ӿڵ�ʵ�ּ��뵽ioc������-->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <!--ɨ�����е�dao�ӿ� ��ʵ�ּ��뵽IOC������-->
        <property name="basePackage" value="com.yc.ssm.dao"/>
    </bean>

�������
<!--����������-->
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <!--����ס����Դ-->
    <property name="dataSource" ref="druid"/>
</bean>
<!--    ��������ע��@trasanction������-->
<aop:config>
    <!--�������ʽ-->
    <aop:pointcut id="txPoint" expression="execution(* com.yc.ssm.service..*(..) )"/>
    <!--����������ǿ-->
    <aop:advisor advice-ref="txAdvice" pointcut-ref="txPoint"/>
</aop:config>
<!--����������ǿ �����������-->
<tx:advice id="txAdvice">
    <tx:attributes >
        <!--���з����������񷽷�-->
        <tx:method name="*"/>
        <!--��get��ʼ�ķ����������񷽷�-->
        <tx:method name="get*" read-only="true"/>
    </tx:attributes>

</tx:advice>
springMVC�����ļ��ĺ��ĵ㣺
<!-- ɨ��controller -->
<context:component-scan base-package="com.yc.ssm.controller" use-default-filters="false">
    <!--ֻɨ�������-->
    <context:include-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
</context:component-scan>
<!-- ��ͼ������ ����ҳ�淵�� -->
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/views/"/>
    <property name="suffix" value=".jsp"/>
</bean>
<!--ע�ᾲ̬��Դ ��springmvc���ܴ������Դ����tomcat-->
<mvc:default-servlet-handler/>
<!--ע��ע�⿪������ ֧��springmvc���߼��Ĺ��ܣ�Ʃ��JSP303У�飬����ݵ�ajax��ӳ���ļ�-->
Jdbc.properties
jdbc.user=root
jdbc.password=123456
jdbc.url=jdbc:mysql://localhost:3306/ssm_crud?useUnicode=true&charcterEncoding=utf-8
jdbc.driverClass=com.mysql.jdbc.Driver
Mybatis�����ļ�
<configuration>
    <settings>
        <!--�շ�����-->
        <setting name="mapUnderscoreToCamelCase" value="true"/>
    </settings>

    <typeAliases>
        <package name="com.yc.ssm.entity"/>
    </typeAliases>
    <plugins>
        <plugin interceptor="com.github.pagehelper.PageInterceptor">
            <!--��ҳ��������-->
            <property name="reasonable" value="true"/>
        </plugin>
    </plugins>
</configuration>

Web.xml
<!--    ����spring����-->
    <context-param>
        <param-name>contextConfigLocation </param-name>
        <param-value>classpath:applicationContext.xml</param-value>
    </context-param>
    <listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
<!--    springmvcǰ�˿����� ������������-->
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
    <!--���springMVC��post��������  �������й�����֮ǰ-->
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
    <!--    rest����URI ��ҳ����ͨ��post����ת��Ϊ��ͨ��delete����put����-->
    <filter>
        <filter-name>HiddenHttpMethodFilter</filter-name>
        <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>HiddenHttpMethodFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

<!--    ��Spring MVC������-HiddenHttpMethodFilter�������ᵽ��-->
<!--    jsp����˵html�е�form��methodֵֻ��Ϊpost��get�����ǿ���ͨ��HiddenHttpMethodFilter��ȡput���еĲ���-ֵ��-->
<!--    ����Spring3.0�л�ȡput���Ĳ���-ֵ������һ�ַ�������ʹ��HttpPutFormContentFilter��������-->
<!--    HttpPutFormContentFilter����������Ϊ���ǻ�ȡput����ֵ������֮���ݵ�Controller�б�ע��methodΪRequestMethod.put�ķ�����-->
<!--    &lt;!&ndash;֧�ַ���PUT֮������󣬲����������е����ݽ������з�װ��map-->
<!--    request�����°�װ��request.getParameter()��������д&ndash;&gt;-->
    <filter>
        <filter-name>HttpPutFormContentFilter</filter-name>
        <filter-class>org.springframework.web.filter.HttpPutFormContentFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>HttpPutFormContentFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
</web-app>
��ѯ
1.����index.jspҳ��
2.Index.jspҳ�淢�ͳ���ѯԱ���б������
3.EmployeeController���������󣬲��Ա������
4.����list.jspҳ�����չʾ
URI:
��ѯ-ajax
1.����index.jspҳ��ֱ�ӷ���ajax�������Ա�����ݷ�ҳ��ѯ
2.�������������������json�ַ�����ʽ���ظ������
3.������յ�json�ַ�����ʹ��js���н�����ʹ��jsͨ��DOM��ɾ�ĸı�ҳ�棻
4.����json��ʵ�ֿͻ��˵��޹��ԡ�
URI:

