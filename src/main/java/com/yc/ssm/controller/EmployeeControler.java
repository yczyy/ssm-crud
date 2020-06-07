package com.yc.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yc.ssm.entity.Employee;
import com.yc.ssm.entity.Msg;
import com.yc.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @authour:yc
 * @date 2020/5/30 22:48
 * 处理员工crud
 */

@Controller
public class EmployeeControler {

    //@ResponseBody使用，需要导入jackson包,返回json格式

    @Autowired
    private EmployeeService employeeService;

    //删除emp信息
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg delEmp(@PathVariable("ids")String ids){
        if (ids.contains("-")){
            List<Integer> del_ids=new ArrayList();
            String[] split = ids.split("-");
            for (String s : split) {
                del_ids.add(Integer.parseInt(s));
            }
            employeeService.delEmpBatch(del_ids);
        }else {
            Integer id=Integer.parseInt(ids);
            employeeService.delEmp(id);
        }
        return Msg.success();
    }

//<!--支持发送PUT之类的请求，并将请求体中的数据解析进行封装成map
//    request被重新包装，request.getParameter()被重新重写
//    在web.xml中配置上HttpPutFormContentFilter

    //更新emp信息
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        System.out.println("将要更新的员工为："+employee.toString());
        return Msg.success();

    }

    //查询单个emp信息
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee emp = employeeService.getEmp(id);
        return Msg.success().add("emp",emp);

    }
    //检查用户名是否存在
    @RequestMapping(value = "/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg","请输入2-5中文或6-16位英文或字母的组合");
        }
        boolean b = employeeService.checkUser(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名已存在！");
        }
    }
    //保存员工信息 JSR303校验
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //将错误信息封装到map中
            Map<String,Object> map = new HashMap();
            //从result中提取所有字段的校验信息
            List<FieldError> errors=result.getFieldErrors();
            //遍历错误信息
            for(FieldError fieldError : errors){
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }
    //保存员工信息
//    @RequestMapping(value = "/emp",method = RequestMethod.POST)
//    @ResponseBody
//    public Msg saveEmp( Employee employee){
//        employeeService.saveEmp(employee);
//        return Msg.success();
//    }
    //查询所有员工信息并分页显示
    @RequestMapping("/getEmps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value ="pn",defaultValue = "1") Integer pn){
        //引入pagehelper分页插件
        //在查询之前只需要调用，传入页码，以及每页查询的条数
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果， 只需要将PageInfo交给页面即可
        //封装了详细的分页信息，包括有我们查询出来的信息；传入连续现实的页数
        PageInfo page = new PageInfo(emps,5);

        return Msg.success().add("pageInfo",page);
    }

//    @RequestMapping("/getEmps")
//    public String getEmps(@RequestParam(value ="pn",defaultValue = "1") Integer pn,
//                          Model model){
//        //引入pagehelper分页插件
//        //在查询之前只需要调用，传入页码，以及每页查询的条数
//        PageHelper.startPage(pn,5);
//        //startPage后面紧跟的这个查询就是分页查询
//        List<Employee> emps = employeeService.getAll();
//        //使用PageInfo包装查询后的结果， 只需要将PageInfo交给页面即可
//        //封装了详细的分页信息，包括有我们查询出来的信息；传入连续现实的页数
//        PageInfo pageInfo = new PageInfo(emps,5);
//        model.addAttribute("pageInfo",pageInfo);
//        return "list";
//    }

}
