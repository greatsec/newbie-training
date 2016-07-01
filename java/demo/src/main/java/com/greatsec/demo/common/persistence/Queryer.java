/*
 * 文件名称：HibernateQuery.java  下午8:46:23 2012-3-6
 * 版权说明：js.todaysoft Technologies Co., Ltd. Copyright 2010-2017, All rights reserved.
 */
package com.greatsec.demo.common.persistence;

import java.util.ArrayList;
import java.util.List;

/**
 * hql查询器
 *
 * @author  xuxin
 * @version 1.0, 2012-3-6
 */
public class Queryer
{
    private String hql;
    
    private List<Object> parameters = new ArrayList<Object>();
    

    public String getHql()
    {
        return hql;
    }
    
    public void setHql(String hql)
    {
        this.hql = hql;
    }
    
    public List<Object> getParameters()
    {
        return parameters;
    }
    
    public void setParameters(List<Object> parameters)
    {
        this.parameters = parameters;
    }
    
    public void addParameter(Object parameter)
    {
        parameters.add(parameter);
    }
}
