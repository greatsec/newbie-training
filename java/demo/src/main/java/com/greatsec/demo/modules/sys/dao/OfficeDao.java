
package com.greatsec.demo.modules.sys.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.greatsec.demo.common.persistence.BaseDao;
import com.greatsec.demo.common.persistence.BaseDaoImpl;
import com.greatsec.demo.modules.sys.entity.Office;

/**
 * 机构DAO接口
 * @author bmwm.cn
 * @version 2013-05-15
 */
public interface OfficeDao extends OfficeDaoCustom, CrudRepository<Office, Long> {

	@Modifying
	@Query("update Office set delFlag='" + Office.DEL_FLAG_DELETE + "' where id = ?1 or parentIds like ?2")
	public int deleteById(Long id, String likeParentIds);
	
	public List<Office> findByParentIdsLike(String parentIds);

//	@Query("from Office where delFlag='" + Office.DEL_FLAG_NORMAL + "' order by code")
//	public List<Office> findAllList();
//	
//	@Query("from Office where (id=?1 or parent.id=?1 or parentIds like ?2) and delFlag='" + Office.DEL_FLAG_NORMAL + "' order by code")
//	public List<Office> findAllChild(Long parentId, String likeParentIds);
}

/**
 * DAO自定义接口
 * @author bmwm.cn
 */
interface OfficeDaoCustom extends BaseDao<Office> {

}

/**
 * DAO自定义接口实现
 * @author bmwm.cn
 */
@Repository
class OfficeDaoImpl extends BaseDaoImpl<Office> implements OfficeDaoCustom {

}
