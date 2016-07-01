/*
 * 文件名称：Constants.java  2:56:51 PM Jul 27, 2012
 */
package com.greatsec.demo.common.utils;

/**
 * 系统常量 
 *
 * @author  lvdong
 * @version 1.1.2, Jul 27, 2012
 * @see     [相关类/方法]
 */

public class Constants
{
    public static final String AGREE_STATUS = "agreeStatus"; //工作流中三种状态：同意，反对，驳回
    
    public static final String AGREE_CONTENT = "agreeContent"; //工作流中领导的审批意见
    
    public static final int TASK_SUCCESS = 1;

    public static final String RESPONSE = "response";
    
    public static final int TASK_REJECT_FAIL = 2;
    
    public static final int PAGE_SIZE = 10;
    
    public static final String PREFIX = "TYAU";
    
    /**
     * 假删除
     */
    public static final Long DELETE_STATUS = 1L;
    
    /**
     * 已发货
     */
    public static final Long SEND_FINISH = 2L;
    
    /**
     * 已到货
     */
    public static final long ARRIVAL_FINISH = 3L;
    
    /**
     * 增加成功
     */
    public static final Integer ADD_SUCCESS = 1;
    
    /**
     * 更新成功
     */
    public static final Integer UPDATE_SUCCESS = 2;
    
    /**
     * 删除成功
     */
    public static final Integer DEL_SUCCESS = 3;
    
    /**
     * 启动成功
     */
    public static final Integer START_SUCCESS = 4;
    
    /**
     * 已结算
     */
    public static final Long BALANCE_FINISH = 1L;
    
    /**
     * 已开票
     */
    public static final Long BILLED_FINISH = 2L;
    
    /**
     * 已付款
     */
    public static final Long PAIED_FINISH = 3L;
    
    public static final int ENTERPRISE_BULLETIN = 0;
    
    public static final int DEPARTMENT_BULLETIN = 1;
    
    /**
     * 薪酬审批附件category
     */
    public static final int ATTACH_CATEGORY_SALARY = 1;
    
    /**
     * 供应商附件category
     */
    public static final int ATTACH_CATEGORY_SUPPLIER = 2;
    
    /**
     * 文档附件category
     */
    public static final int ATTACH_CATEGORY_COMMON_DOCUMENT = 3;
    
    /**
     * 短消息未读
     */
    public static final Long UNREAD = 0L;
    
    /**
     * 短消息已读
     */
    public static final Long READ = 1L;
    
    public static final int ATTACH_CATEGORY_CONTRACT_DOCUMENT = 4;
    
}
