package com.greatsec.demo.modules.sys.utils;

import com.greatsec.demo.common.service.BaseService;
import com.greatsec.demo.common.utils.SpringContextHolder;
import com.greatsec.demo.modules.sys.dao.AreaDao;
import com.greatsec.demo.modules.sys.dao.MenuDao;
import com.greatsec.demo.modules.sys.dao.OfficeDao;
import com.greatsec.demo.modules.sys.dao.UserDao;
import com.greatsec.demo.modules.sys.entity.Area;
import com.greatsec.demo.modules.sys.entity.Menu;
import com.greatsec.demo.modules.sys.entity.Office;
import com.greatsec.demo.modules.sys.entity.User;
import com.greatsec.demo.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.greatsec.demo.modules.sys.service.SystemService;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.subject.Subject;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import java.util.List;
import java.util.Map;

/**
 * 用户工具类
 * 
 * @author bmwm.cn
 * @version 2013-5-29
 */
public class UserUtils extends BaseService {
    private static SystemService systemService = SpringContextHolder
	    .getBean(SystemService.class);
    private static UserDao userDao = SpringContextHolder.getBean(UserDao.class);
    private static MenuDao menuDao = SpringContextHolder.getBean(MenuDao.class);
    private static AreaDao areaDao = SpringContextHolder.getBean(AreaDao.class);
    private static OfficeDao officeDao = SpringContextHolder
	    .getBean(OfficeDao.class);
    public static final String CACHE_USER = "user";
    public static final String CACHE_MENU_LIST = "menuList";
    public static final String CACHE_AREA_LIST = "areaList";
    public static final String CACHE_VIDEO_CATEGORY_LIST = "videoCategoryList";
    public static final String CACHE_OFFICE_LIST = "officeList";

    public static User getUser() {
	User user = (User) getCache(CACHE_USER);
	if (user == null) {
	    Principal principal = (Principal) SecurityUtils.getSubject()
		    .getPrincipal();
	    if (principal != null) {
		user = userDao.findOne(principal.getId());
		putCache(CACHE_USER, user);
	    }
	}
	if (user == null) {
	    user = new User();
	    SecurityUtils.getSubject().logout();
	}
	return user;
    }

    //根据用户的一个或多个角色下面的数据范围查看其拥有的所有用户
    public static Long[] findUsersByRoles(){
	Map<Long,User> map = systemService.findUsersByRoles(getUser());
	if(null==map){
	    return null;
	}else{
	    Long[] idsArray = new Long[map.size()];
	    int i = 0;
	    for (Map.Entry<Long, User> entry : map.entrySet()) {
		idsArray[i] = entry.getKey();
		i++;
	    }
	    return idsArray;
	}
    }
    
    public static User getUserById(Long id) {
	return userDao.findById(id);
    }

    public static String getUserNameById(Long id) {
	return userDao.findById(id).getName();
    }

    public static String getUserByTask(String id) {
        if (StringUtils.isEmpty(id)) {
            return "";
        }

        String username = getUserNameById(Long.valueOf(id));
        if (StringUtils.isEmpty(username)) {
            return "";
        }
        return username;
    }

    public static User getUser(boolean isRefresh) {
	if (isRefresh) {
	    removeCache(CACHE_USER);
	}
	return getUser();
    }

    public static List<Menu> getMenuList() {
	@SuppressWarnings("unchecked")
	List<Menu> menuList = (List<Menu>) getCache(CACHE_MENU_LIST);
	if (menuList == null) {
	    User user = getUser();
	    if (user.isAdmin()) {
		menuList = menuDao.findAllList();
	    } else {
		menuList = menuDao.findByUserId(user.getId());
	    }
	    putCache(CACHE_MENU_LIST, menuList);
	}
	return menuList;
    }

    public static List<Area> getAreaList() {
	@SuppressWarnings("unchecked")
	List<Area> areaList = (List<Area>) getCache(CACHE_AREA_LIST);
	if (areaList == null) {
	    // User user = getUser();
	    // if (user.isAdmin()){
	    areaList = areaDao.findAllList();
	    // }else{
	    // areaList = areaDao.findAllChild(user.getArea().getId(),
	    // "%,"+user.getArea().getId()+",%");
	    // }
	    putCache(CACHE_AREA_LIST, areaList);
	}
	return areaList;
    }
    
    public static List<Office> getOfficeList() {
	@SuppressWarnings("unchecked")
	List<Office> officeList = (List<Office>) getCache(CACHE_OFFICE_LIST);
	if (officeList == null) {
	    User user = getUser();
	    // if (user.isAdmin()){
	    // officeList = officeDao.findAllList();
	    // }else{
	    // officeList = officeDao.findAllChild(user.getOffice().getId(),
	    // "%,"+user.getOffice().getId()+",%");
	    // }
	    DetachedCriteria dc = officeDao.createDetachedCriteria();
	    dc.add(dataScopeFilter(user, dc.getAlias(), ""));
	    dc.add(Restrictions.eq("delFlag", Office.DEL_FLAG_NORMAL));
	    dc.addOrder(Order.asc("code"));
	    officeList = officeDao.find(dc);
	    putCache(CACHE_OFFICE_LIST, officeList);
	}
	return officeList;
    }

    // ============== User Cache ==============

    public static Object getCache(String key) {
	return getCache(key, null);
    }

    public static Object getCache(String key, Object defaultValue) {
	Object obj = getCacheMap().get(key);
	return obj == null ? defaultValue : obj;
    }

    public static void putCache(String key, Object value) {
	getCacheMap().put(key, value);
    }

    public static void removeCache(String key) {
	getCacheMap().remove(key);
    }

    public static Map<String, Object> getCacheMap() {
	Map<String, Object> map = Maps.newHashMap();
	try {
	    Subject subject = SecurityUtils.getSubject();
	    Principal principal = (Principal) subject.getPrincipal();
	    return principal != null ? principal.getCacheMap() : map;
	} catch (UnavailableSecurityManagerException e) {
	    return map;
	}
    }

    public static Office getRootOffice(){
	return officeDao.findOne(1l);
    }
}
