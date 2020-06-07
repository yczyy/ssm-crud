package com.yc.ssm.service;

import com.yc.ssm.dao.EmployeeMapper;
import com.yc.ssm.entity.Employee;
import com.yc.ssm.entity.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

/**
 * @authour:yc
 * @date 2020/5/30 23:00
 */
@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAll(){
        EmployeeExample example=new EmployeeExample();
        example.setOrderByClause("emp_id ASC");
        return employeeMapper.selectByExampleWithDept(example);
    }

    public void  saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    public boolean checkUser(String empName){
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count= employeeMapper.countByExample(example);
        return count==0;
    }

    public Employee getEmp(Integer id){
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee){
      employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void delEmp(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void delEmpBatch(List<Integer> ids){
        EmployeeExample example =new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }

}
