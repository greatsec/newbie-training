
package com.greatsec.demo.modules.sys.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.greatsec.demo.common.persistence.Page;
import com.greatsec.demo.common.service.BaseService;
import com.greatsec.demo.common.utils.CacheUtils;
import com.greatsec.demo.modules.sys.dao.DictDao;
import com.greatsec.demo.modules.sys.entity.Dict;
import com.greatsec.demo.modules.sys.utils.DictUtils;

/**
 * 字典Service
 * @author bmwm.cn
 * @version 2013-5-29
 */
@Service
@Transactional(readOnly = true)
public class DictService extends BaseService {

	@Autowired
	private DictDao dictDao;
	
	public Dict get(Long id) {
		return dictDao.findOne(id);
	}
	
	public Page<Dict> find(Page<Dict> page, Dict dict) {
		DetachedCriteria dc = dictDao.createDetachedCriteria();
		if (StringUtils.isNotEmpty(dict.getType())){
			dc.add(Restrictions.eq("type", dict.getType()));
		}
		if (StringUtils.isNotEmpty(dict.getDescription())){
			dc.add(Restrictions.like("description", "%"+dict.getDescription()+"%"));
		}
		dc.add(Restrictions.eq(Dict.DEL_FLAG, Dict.DEL_FLAG_NORMAL));
		dc.addOrder(Order.asc("type")).addOrder(Order.asc("sort")).addOrder(Order.desc("id"));
		return dictDao.find(page, dc);
	}
	
	public List<String> findTypeList(){
		return dictDao.findTypeList();
	}
	
	public List<Dict> findDictList(){
		return dictDao.findDictList();
	}
	
	public List<Dict> findDictByValues(String[] values){
	    DetachedCriteria dc = dictDao.createDetachedCriteria();
	    dc.add(Restrictions.in("value", values));
	    return dictDao.find(dc);
	}
	
	@Transactional(readOnly = false)
	public void save(Dict dict) {
		dictDao.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}
	
	@Transactional(readOnly = false)
	public void delete(Long id) {
		dictDao.deleteById(id);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}
	
}
