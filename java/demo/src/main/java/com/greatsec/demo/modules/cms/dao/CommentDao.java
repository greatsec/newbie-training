
package com.greatsec.demo.modules.cms.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.greatsec.demo.common.persistence.BaseDao;
import com.greatsec.demo.common.persistence.BaseDaoImpl;
import com.greatsec.demo.modules.cms.entity.Comment;

/**
 * 评论DAO接口
 * @author bmwm.cn
 * @version 2013-01-15
 */
public interface CommentDao extends CommentDaoCustom, CrudRepository<Comment, Long> {

	@Modifying
	@Query("update Comment set delFlag=?2 where id = ?1")
	public int updateDelFlag(Long id, String status);
	
}

/**
 * DAO自定义接口
 * @author bmwm.cn
 */
interface CommentDaoCustom extends BaseDao<Comment> {

}

/**
 * DAO自定义接口实现
 * @author bmwm.cn
 */
@Repository
class CommentDaoImpl extends BaseDaoImpl<Comment> implements CommentDaoCustom {

}
