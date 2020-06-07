package com.yc.ssm.service;

import com.yc.ssm.dao.DepartmentMapper;
import com.yc.ssm.entity.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @authour:yc
 * @date 2020/6/2 17:40
 */
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDepts(){
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
