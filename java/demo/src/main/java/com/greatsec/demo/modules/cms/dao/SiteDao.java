
package com.greatsec.demo.modules.cms.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.greatsec.demo.common.persistence.BaseDao;
import com.greatsec.demo.common.persistence.BaseDaoImpl;
import com.greatsec.demo.modules.cms.entity.Site;

/**
 * 站点DAO接口
 * @author bmwm.cn
 * @version 2013-01-15
 */
public interface SiteDao extends SiteDaoCustom, CrudRepository<Site, Long> {
	
	@Modifying
	@Query("update Site set delFlag=?2 where id = ?1")
	public int updateDelFlag(Long id, String delFlag);
}

/**
 * DAO自定义接口
 * @author bmwm.cn
 */
interface SiteDaoCustom extends BaseDao<Site> {

}

/**
 * DAO自定义接口实现
 * @author bmwm.cn
 */
@Repository
class SiteDaoImpl extends BaseDaoImpl<Site> implements SiteDaoCustom {

}
