package com.yc.ssm.test;

import com.github.pagehelper.PageInfo;
import com.yc.ssm.entity.Employee;
import org.junit.Before;
import org.junit.Test;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;

import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @authour:yc
 * @date 2020/5/30 23:38
 * 使用spring测试模块提供的测试请求，测试CRUD的正确性
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml",
        "classpath:springMVC-servlet.xml"})
public class MVCtest {
    //虚拟mvc,获取到处理结果
    MockMvc mockMvc;

    //springMVC容器
    @Autowired
    WebApplicationContext context;

    @Before
    public void initMockMvc(){
       mockMvc= MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/getEmps").param("pn","1")).andReturn();

        //请求成功后，请求域中会有pageinfo信息，我们可以取出pageinfo来校验
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前是第几页："+pi.getPageNum());
        System.out.println("总页数："+pi.getPages());
        System.out.println("总记录数："+pi.getTotal());
        System.out.println("当前页面需要连续显示的页码");
        int[] Nums = pi.getNavigatepageNums();
        for (int i : Nums) {
            System.out.print(" "+i);
        }
        //获取员工数据
        List<Employee> list = pi.getList();
        for (Employee emp : list) {
            System.out.println("ID:"+emp.getEmpId()+"name:"+emp.getEmpName()
            +"gender:"+emp.getGender()+"email:"+emp.getEmail()+"deptName:"
                    +emp.getDepartment().getDeptName());
        }
    }
}
