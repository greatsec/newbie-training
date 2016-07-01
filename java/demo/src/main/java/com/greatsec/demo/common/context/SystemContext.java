/*
 * 文件名称：SystemContext.java  上午8:18:32 2012-9-3
 */
package com.greatsec.demo.common.context;

/**
 * <一句话功能简述>
 * <功能详细描述>
 *
 * @author  Administrator
 * @version 1.1.2, 2012-9-3
 * @see     [相关类/方法]
 */

public class SystemContext
{
    private static ThreadLocal<Integer> pageNo = new ThreadLocal<Integer>();
    
    private static ThreadLocal<Integer> pageSize = new ThreadLocal<Integer>();
    
    private static ThreadLocal<String> sort = new ThreadLocal<String>();
    
    
    
    public static String getSort() {
		return sort.get();
	}

	public static void setSort(String _sort) {
		sort.set(_sort);
	}
	
	public static void removeSot()
	{
		sort.remove();
	}

	public static Integer getPageNo()
    {
        return pageNo.get();
    }
    
    public static void setPageNo(Integer _pageNo)
    {
        pageNo.set(_pageNo);
    }
    
    public static void removePageNo()
    {
        pageNo.remove();
    }

    public static Integer getPageSize()
    {
        return pageSize.get();
    }
    
    public static void setPageSize(Integer _pageSize)
    {
        pageSize.set(_pageSize);
    }
    
    public static void removePageSize()
    {
        pageSize.remove();
    }

}
