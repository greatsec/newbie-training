package com.greatsec.demo.common.filter;

import java.io.IOException;

import javax.servlet.*;

import com.greatsec.demo.common.context.SystemContext;

public class SystemContextFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		try {
			int pageNo = 1;
			int pageSize = 10;
			try {
				pageNo = Integer.parseInt(req.getParameter("pageNo"));
			} catch (Exception e) {
				pageNo = 1;
			}
            SystemContext.setPageNo(pageNo);
			Integer sysPageSize =10;
			if(sysPageSize !=null)
			{
				pageSize = sysPageSize;
			}
			SystemContext.setPageSize(pageSize);
			chain.doFilter(req, resp);
		} finally
		{
			SystemContext.removePageNo();
			SystemContext.removePageSize();
		}
		

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
