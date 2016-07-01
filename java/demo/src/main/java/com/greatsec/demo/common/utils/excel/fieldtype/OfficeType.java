
package com.greatsec.demo.common.utils.excel.fieldtype;

import com.greatsec.demo.modules.sys.entity.Office;
import com.greatsec.demo.modules.sys.utils.UserUtils;

/**
 * 字段类型转换
 * @author bmwm.cn
 * @version 2013-03-10
 */
public class OfficeType {

	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {
		for (Office e : UserUtils.getOfficeList()){
			if (val.equals(e.getName())){
				return e;
			}
		}
		Office rootOffice = UserUtils.getRootOffice();
		if(val.equals(rootOffice.getName())){
		    return rootOffice;
		}else{
		    return null;
		}
	}

	/**
	 * 设置对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null && ((Office)val).getName() != null){
			return ((Office)val).getName();
		}
		return "";
	}
}
