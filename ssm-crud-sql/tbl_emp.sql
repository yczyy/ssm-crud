
CREATE TABLE `tbl_emp` (
`emp_id`  int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
`emp_name`  varchar(255)  NOT NULL ,
`gender`  char(1)  ,
`email`  varchar(255) ,
`d_id`  int(11) NOT NULL ,
CONSTRAINT `fk_emp_dept` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
ROW_FORMAT=DYNAMIC
;

 select *
    from tbl_emp e
    left join tbl_dept d on d.dept_id=e.d_id
order by e.emp_id;
insert into tbl_emp VALUES(null,'haha','女','chsn@163.com',1);
show index from tbl_dept;
show index from tbl_emp;
#列出外键(注意它与索引名不同)
SHOW CREATE TABLE  tbl_emp;
CREATE TABLE `tbl_emp` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `d_id` int(11) NOT NULL,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC

CREATE TABLE `tbl_emp` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `d_id` int(11) NOT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_emp_dept` (`d_id`),
  CONSTRAINT `fk_emp_dept` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC
#删除(外接/主/键)键
ALTER TABLE <Table Name> DROP FOREIGN KEY <Foreign key name>
alter table tbl_emp drop foreign key fk_emp_dept;
#删除索引。
drop index fk_emp_dept on tbl_emp;
drop index tbl_emp_emp_id_index on tbl_emp;

#添加bai外键 ,alter table B

#语法：alter table 表名du add constraint 外键约束名 foreign key(列名) references 引用外键表(列名) 

alter table tbl_emp add constraint fk_emp_dept foreign key(d_id) REFERENCES tbl_dept (dept_id); 

