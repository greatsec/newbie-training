
package com.greatsec.demo.modules.sys.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.greatsec.demo.common.persistence.BaseDao;
import com.greatsec.demo.common.persistence.BaseDaoImpl;
import com.greatsec.demo.modules.sys.entity.Role;

/**
 * 角色DAO接口
 * @author bmwm.cn
 * @version 2013-05-15
 */
public interface RoleDao extends RoleDaoCustom, CrudRepository<Role, Long> {
	
	@Query("from Role where name = ?1 and delFlag = '" + Role.DEL_FLAG_NORMAL + "'")
	public Role findByName(String name);

	@Modifying
	@Query("update Role set delFlag='" + Role.DEL_FLAG_DELETE + "' where id = ?1")
	public int deleteById(Long id);

//	@Query("from Role where delFlag='" + Role.DEL_FLAG_NORMAL + "' order by name")
//	public List<Role> findAllList();
//
//	@Query("select distinct r from Role r, User u where r in elements (u.roleList) and r.delFlag='" + Role.DEL_FLAG_NORMAL +
//			"' and u.delFlag='" + User.DEL_FLAG_NORMAL + "' and u.id=?1 or (r.user.id=?1 and r.delFlag='" + Role.DEL_FLAG_NORMAL +
//			"') order by r.name")
//	public List<Role> findByUserId(Long userId);
}

/**
 * DAO自定义接口
 * @author bmwm.cn
 */
interface RoleDaoCustom extends BaseDao<Role> {
	
//	void deleteWithReference(Long id);

}

/**
 * DAO自定义接口实现
 * @author bmwm.cn
 */
@Repository
class RoleDaoImpl extends BaseDaoImpl<Role> implements RoleDaoCustom {

//	private static final String QUERY_USER_BY_GROUPID = "select u from User u left join u.roleList g where g.id=?";
//
//	@Override
//	public void deleteWithReference(Long id) {
//		Role role = getEntityManager().find(Role.class, id);
//		@SuppressWarnings("unchecked")
//		List<User> users = getEntityManager().createQuery(QUERY_USER_BY_GROUPID).setParameter(1, id).getResultList();
//		for (User u : users) {
//			u.getRoleList().remove(role);
//		}
//		getEntityManager().remove(role);
//		
//	}

}
