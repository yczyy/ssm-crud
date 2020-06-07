package com.yc.ssm.controller;

import com.yc.ssm.entity.Department;
import com.yc.ssm.entity.Msg;
import com.yc.ssm.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @authour:yc
 * @date 2020/6/2 17:38
 * 处理和部门有关的请求
 */
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> list = departmentService.getDepts();

        return Msg.success().add("depts",list);
    }

}
