
package com.greatsec.demo.modules.cms.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.greatsec.demo.common.persistence.BaseDao;
import com.greatsec.demo.common.persistence.BaseDaoImpl;
import com.greatsec.demo.modules.cms.entity.Article;

/**
 * 文章DAO接口
 * @author bmwm.cn
 * @version 2013-01-15
 */
public interface ArticleDao extends ArticleDaoCustom, CrudRepository<Article, Long> {

	@Modifying
	@Query("update Article set delFlag=?2 where id = ?1")
	public int updateDelFlag(Long id, String status);
	
	public List<Article> findByIdIn(Long[] ids);
	
	@Modifying
	@Query("update Article set hits=hits+1 where id = ?1")
	public int updateHitsAddOne(Long id);
	
	@Modifying
	@Query("update Article set weight=0 where weight > 0 and weightDate < current_timestamp()")
	public int updateExpiredWeight();
	
}

/**
 * DAO自定义接口
 * @author bmwm.cn
 */
interface ArticleDaoCustom extends BaseDao<Article> {

}

/**
 * DAO自定义接口实现
 * @author bmwm.cn
 */
@Repository
class ArticleDaoImpl extends BaseDaoImpl<Article> implements ArticleDaoCustom {

}
