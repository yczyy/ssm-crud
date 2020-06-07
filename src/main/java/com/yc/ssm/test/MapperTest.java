package com.yc.ssm.test;

import com.yc.ssm.dao.DepartmentMapper;
import com.yc.ssm.dao.EmployeeMapper;
import com.yc.ssm.entity.Department;
import com.yc.ssm.entity.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import java.util.UUID;

/**
 * @authour:yc
 * @date 2020/5/30 20:16
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
//        //创建springIOC容器
//        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
//        //从springIOC容器中获取mapper
//        DepartmentMapper departmentMapper = context.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);
//        插入几个部门信息
//        departmentMapper.insertSelective(new Department(null,"研发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //插入几个员工信息
//        employeeMapper.insertSelective(new Employee(null,"杨晨","女","184610@qq.com",1));
//        employeeMapper.insertSelective(new Employee(null,"赵双","男","182369@qq.com",2));
//        employeeMapper.insertSelective(new Employee(null,"又又","男","235722@qq.com",1));

        //批量插入员工信息 可以使用Sql Session
//        for (int i = 0; i <100 ; i++) {
//            employeeMapper.insertSelective(new Employee(null,"又又","男","235722@qq.com",1));
//        }
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i <1000 ; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uid,"男",uid+"@163.com",1));
        } System.out.println("批量生成完成");

    }
}
