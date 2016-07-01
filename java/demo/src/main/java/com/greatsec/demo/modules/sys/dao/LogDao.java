
package com.greatsec.demo.modules.sys.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.greatsec.demo.common.persistence.BaseDao;
import com.greatsec.demo.common.persistence.BaseDaoImpl;
import com.greatsec.demo.modules.sys.entity.Log;

/**
 * 日志DAO接口
 * @author bmwm.cn
 * @version 2013-06-02
 */
public interface LogDao extends LogDaoCustom, CrudRepository<Log, Long> {
	
}

/**
 * DAO自定义接口
 * @author bmwm.cn
 */
interface LogDaoCustom extends BaseDao<Log> {

}

/**
 * DAO自定义接口实现
 * @author bmwm.cn
 */
@Repository
class LogDaoImpl extends BaseDaoImpl<Log> implements LogDaoCustom {

}
