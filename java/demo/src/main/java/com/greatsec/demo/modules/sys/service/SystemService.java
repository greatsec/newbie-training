package com.greatsec.demo.modules.sys.service;

import com.greatsec.demo.common.persistence.Page;
import com.greatsec.demo.common.security.Digests;
import com.greatsec.demo.common.service.BaseService;
import com.greatsec.demo.common.utils.Encodes;
import com.greatsec.demo.common.utils.StringUtils;
import com.greatsec.demo.modules.sys.dao.MenuDao;
import com.greatsec.demo.modules.sys.dao.RoleDao;
import com.greatsec.demo.modules.sys.dao.UserDao;
import com.greatsec.demo.modules.sys.entity.Menu;
import com.greatsec.demo.modules.sys.entity.Office;
import com.greatsec.demo.modules.sys.entity.Role;
import com.greatsec.demo.modules.sys.entity.User;
import com.greatsec.demo.modules.sys.security.SystemAuthorizingRealm;
import com.greatsec.demo.modules.sys.utils.UserUtils;
import org.apache.shiro.SecurityUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.sql.JoinType;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 * 
 * @author bmwm.cn
 * @version 2013-5-15
 */
@Service
@Transactional(readOnly = true)
public class SystemService extends BaseService implements InitializingBean {

    public static final String HASH_ALGORITHM = "SHA-1";
    public static final int HASH_INTERATIONS = 1024;
    public static final int SALT_SIZE = 8;

    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private MenuDao menuDao;
    @Autowired
    private SystemAuthorizingRealm systemRealm;

   
    // -- User Service --//

    public User getUser(Long id) {
	return userDao.findOne(id);
    }

    public Page<User> findUser(Page<User> page, User user) {
	DetachedCriteria dc = userDao.createDetachedCriteria();
	User currentUser = UserUtils.getUser();
	dc.createAlias("company", "company");
	if (user.getCompany() != null && user.getCompany().getId() != null) {
	    dc.add(Restrictions.or(
		    Restrictions.eq("company.id", user.getCompany().getId()),
		    Restrictions.like("company.parentIds", "%,"
			    + user.getCompany().getId() + ",%")));
	}
	dc.createAlias("office", "office");
	if (user.getOffice() != null && user.getOffice().getId() != null) {
	    dc.add(Restrictions.or(
		    Restrictions.eq("office.id", user.getOffice().getId()),
		    Restrictions.like("office.parentIds", "%,"
			    + user.getOffice().getId() + ",%")));
	}
	if(user.getRoleId()!=null){//根据角色搜索
	    Role role = roleDao.findOne(user.getRoleId());
	    List<User> userList = role.getUserList();
	    if(userList!=null && userList.size()>0){
		Long[] ids = new Long[userList.size()];
		for (int i = 0; i < userList.size(); i++) {
		    ids[i] = userList.get(i).getId();
		}
		dc.add(Restrictions.in("id", ids));
	    }
	    
	}
	// 如果不是超级管理员，则不显示超级管理员用户
	if (!currentUser.isAdmin()) {
	    dc.add(Restrictions.ne("id", 1L));
	}
	dc.add(dataScopeFilter(currentUser, "office", ""));
	// System.out.println(dataScopeFilterString(currentUser, "office", ""));
	if (StringUtils.isNotEmpty(user.getLoginName())) {
	    dc.add(Restrictions.like("loginName", "%" + user.getLoginName()
		    + "%"));
	}
	if (StringUtils.isNotEmpty(user.getName())) {
	    dc.add(Restrictions.like("name", "%" + user.getName() + "%"));
	}
	dc.add(Restrictions.eq(User.DEL_FLAG, User.DEL_FLAG_NORMAL));
	if (!StringUtils.isNotEmpty(page.getOrderBy())) {
	    dc.addOrder(Order.asc("company.code"))
		    .addOrder(Order.asc("office.code"))
		    .addOrder(Order.desc("id"));
	}
	return userDao.find(page, dc);
    }

    public Page<User> findAllUser(Page<User> page, User user) {
	DetachedCriteria dc = userDao.createDetachedCriteria();
	dc.createAlias("company", "company");
	if (user.getCompany() != null && user.getCompany().getId() != null) {
	    dc.add(Restrictions.or(
		    Restrictions.eq("company.id", user.getCompany().getId()),
		    Restrictions.like("company.parentIds", "%,"
			    + user.getCompany().getId() + ",%")));
	}
	dc.createAlias("office", "office");
	if (user.getOffice() != null && user.getOffice().getId() != null) {
	    dc.add(Restrictions.or(
		    Restrictions.eq("office.id", user.getOffice().getId()),
		    Restrictions.like("office.parentIds", "%,"
			    + user.getOffice().getId() + ",%")));
	}
	// System.out.println(dataScopeFilterString(currentUser, "office", ""));
	if (StringUtils.isNotEmpty(user.getLoginName())) {
	    dc.add(Restrictions.like("loginName", "%" + user.getLoginName()
		    + "%"));
	}
	if (StringUtils.isNotEmpty(user.getName())) {
	    dc.add(Restrictions.like("name", "%" + user.getName() + "%"));
	}
	dc.add(Restrictions.eq(User.DEL_FLAG, User.DEL_FLAG_NORMAL));
	if (!StringUtils.isNotEmpty(page.getOrderBy())) {
	    dc.addOrder(Order.asc("company.code"))
		    .addOrder(Order.asc("office.code"))
		    .addOrder(Order.desc("id"));
	}
	return userDao.find(page, dc);
    }

    // 根据角色数据范围查看该范围下所有拥有的人
    public Map<Long,User> findUsersByRoles(User user) {
	List<Role> roleList = user.getRoleList();
	//判断是否拥有所有数据权限
	boolean allData = false;//是否拥有所有用户数据
	for (Role role : roleList) {
	    if(role.getDataScope().equals(Role.DATA_SCOPE_ALL)){//1：所有数据
		allData = true;
		break;
	    }
	}
	if(allData){//返回null，所有用户
	    return null;
	}else{
	    Map<Long, List<User>> usersMap = new HashMap<Long, List<User>>();
	    //开始----遍历角色，把该角色对应的数据范围下的所有用户放入usersMap
	    for (Role role : roleList) {
		String dataScope = role.getDataScope();// 数据范围（1：所有数据；2：所在公司及以下数据；3：所在公司数据；4：所在部门及以下数据；5：所在部门数据；6：仅本人数据；7：按明细设置）
		List<User> users = new ArrayList<User>();
		if(dataScope.equals(Role.DATA_SCOPE_SELF)){//6：仅本人数据
		    users.add(user);
		}else{
		    DetachedCriteria dc = userDao.createDetachedCriteria();
		    if (dataScope.equals(Role.DATA_SCOPE_COMPANY_AND_CHILD)) {// 2所在公司及以下数据
			if (user.getCompany() != null&& user.getCompany().getId() != null) {
			    dc.createAlias("company", "company");
			    dc.add(Restrictions.or(Restrictions.eq("company.id", user.getCompany().getId()), Restrictions.like("company.parentIds", "%," + user.getCompany().getId() + ",%")));
			}
		    } else if (dataScope.equals(Role.DATA_SCOPE_COMPANY)) {// 3所在公司数据
			if (user.getCompany() != null
				&& user.getCompany().getId() != null) {
			    dc.createAlias("company", "company");
			    dc.add(Restrictions.eq("company.id", user.getCompany()
				    .getId()));
			}
		    } else if (dataScope.equals(Role.DATA_SCOPE_OFFICE_AND_CHILD)) {// 4所在部门及以下数据
			if (user.getOffice() != null
				&& user.getOffice().getId() != null) {
			    dc.createAlias("office", "office");
			    dc.add(Restrictions.or(Restrictions.eq("office.id", user
				    .getOffice().getId()), Restrictions.like(
					    "office.parentIds", "%," + user.getOffice().getId()
					    + ",%")));
			}
		    } else if (dataScope.equals(Role.DATA_SCOPE_OFFICE)) {// 5所在部门数据
			if (user.getOffice() != null
				&& user.getOffice().getId() != null) {
			    dc.createAlias("office", "office");
			    dc.add(Restrictions.eq("office.id", user.getOffice()
				    .getId()));
			}
		    } else if (dataScope.equals(Role.DATA_SCOPE_CUSTOM)) {// 7按明细设置
		         List<Office> officeList = role.getOfficeList();
		         if(null!=officeList && officeList.size()>0){
		             Long[] officeIdArray = new Long[officeList.size()];
		             for(int i=0;i<officeList.size();i++){
		        	 officeIdArray[i] = officeList.get(i).getId();
		             }
		             dc.add(Restrictions.in("office.id", officeIdArray));
		         }
		    }
		    dc.add(Restrictions.eq(User.DEL_FLAG, User.DEL_FLAG_NORMAL));
		    users = userDao.find(dc);
		    if(null==user || users.size() == 0){
			users.add(user);
		    }
		}
		usersMap.put(role.getId(), users);
	    }
	    //结束----遍历角色，把该角色对应的数据范围下的所有用户放入usersMap
	    //遍历usersMap，去掉重复的user
	    Map<Long,User> map = new HashMap<Long,User>();
	    for (Map.Entry<Long, List<User>> entry : usersMap.entrySet()) {
		for (User userTemp : entry.getValue()) {
		    if(null==map.get(userTemp.getId())){
			map.put(userTemp.getId(), userTemp);
		    }
		}
	    }
	    return  map;
	}
    }

    public Page<Role> findRole(Page<Role> page, Role role) {
	DetachedCriteria dc = roleDao.createDetachedCriteria();
	if (StringUtils.isNotEmpty(role.getName())) {
	    dc.add(Restrictions.like("name", "%" + role.getName() + "%"));
	}
	return roleDao.find(page, dc);
    }

    public User getUserByLoginName(String loginName) {
	return userDao.findByLoginName(loginName);
    }

    @Transactional(readOnly = false)
    public void saveUser(User user) {
	userDao.clear();
	userDao.save(user);
	systemRealm.clearAllCachedAuthorizationInfo();
	// 同步到Activiti
	// saveActivitiUser(user, user.getId()==null);
    }

    @Transactional(readOnly = false)
    public void deleteUser(Long id) {
	userDao.deleteById(id);
	// 同步到Activiti
	// deleteActivitiUser(userDao.findOne(id));
    }

    @Transactional(readOnly = false)
    public void updatePasswordById(Long id, String loginName, String newPassword) {
	userDao.updatePasswordById(entryptPassword(newPassword), id);
	systemRealm.clearCachedAuthorizationInfo(loginName);
    }

    @Transactional(readOnly = false)
    public void updateUserLoginInfo(Long id) {
	userDao.updateLoginInfo(SecurityUtils.getSubject().getSession()
		.getHost(), new Date(), id);
    }

    /**
     * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
     */
    public static String entryptPassword(String plainPassword) {
	byte[] salt = Digests.generateSalt(SALT_SIZE);
	byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt,
		HASH_INTERATIONS);
	return Encodes.encodeHex(salt) + Encodes.encodeHex(hashPassword);
    }

    /**
     * 验证密码
     * 
     * @param plainPassword
     *            明文密码
     * @param password
     *            密文密码
     * @return 验证成功返回true
     */
    public static boolean validatePassword(String plainPassword, String password) {
	byte[] salt = Encodes.decodeHex(password.substring(0, 16));
	byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt,
		HASH_INTERATIONS);
	return password.equals(Encodes.encodeHex(salt)
		+ Encodes.encodeHex(hashPassword));
    }


    public boolean andoridLogin(User user) {
        boolean isLogin = false;
        User currentUser =  getUserByLoginName(user.getLoginName());
        if (currentUser != null) {
            isLogin = validatePassword(user.getPassword(),currentUser.getPassword());
        }
        return isLogin;
    }


    // -- Role Service --//

    public Role getRole(Long id) {
	return roleDao.findOne(id);
    }

    public Role findRoleByName(String name) {
	return roleDao.findByName(name);
    }

    public List<Role> findAllRole() {
	User user = UserUtils.getUser();
	DetachedCriteria dc = roleDao.createDetachedCriteria();
	dc.createAlias("office", "office");
	dc.createAlias("userList", "userList", JoinType.LEFT_OUTER_JOIN);
	dc.add(dataScopeFilter(user, "office", "userList"));
	dc.add(Restrictions.eq(Role.DEL_FLAG, Role.DEL_FLAG_NORMAL));
	dc.addOrder(Order.asc("office.code")).addOrder(Order.asc("name"));
	return roleDao.find(dc);
    }

    @Transactional(readOnly = false)
    public void saveRole(Role role) {
	roleDao.clear();
	roleDao.save(role);
	systemRealm.clearAllCachedAuthorizationInfo();
	// 同步到Activiti
	//saveActivitiGroup(role, role.getId() == null);
    }

    @Transactional(readOnly = false)
    public void deleteRole(Long id) {
	roleDao.deleteById(id);
	systemRealm.clearAllCachedAuthorizationInfo();
	// 同步到Activiti
	//deleteActivitiGroup(roleDao.findOne(id));
    }

    @Transactional(readOnly = false)
    public Boolean outUserInRole(Role role, Long userId) {
	User user = userDao.findOne(userId);
	List<Long> roleIds = user.getRoleIdList();
	List<Role> roles = user.getRoleList();
	//
	if (roleIds.contains(role.getId())) {
	    roles.remove(role);
	    saveUser(user);
	    return true;
	}
	return false;
    }

    @Transactional(readOnly = false)
    public User assignUserToRole(Role role, Long userId) {
	User user = userDao.findOne(userId);
	List<Long> roleIds = user.getRoleIdList();
	if (roleIds.contains(role.getId())) {
	    return null;
	}
	user.getRoleList().add(role);
	saveUser(user);
	return user;
    }

    // -- Menu Service --//

    public Menu getMenu(Long id) {
	return menuDao.findOne(id);
    }

    public List<Menu> findAllMenu() {
	return UserUtils.getMenuList();
    }

    @Transactional(readOnly = false)
    public void saveMenu(Menu menu) {
	menu.setParent(this.getMenu(menu.getParent().getId()));
	String oldParentIds = menu.getParentIds(); // 获取修改前的parentIds，用于更新子节点的parentIds
	menu.setParentIds(menu.getParent().getParentIds()
		+ menu.getParent().getId() + ",");
	menuDao.clear();
	menuDao.save(menu);
	// 更新子节点 parentIds
	List<Menu> list = menuDao.findByParentIdsLike("%," + menu.getId()
		+ ",%");
	for (Menu e : list) {
	    e.setParentIds(e.getParentIds().replace(oldParentIds,
		    menu.getParentIds()));
	}
	menuDao.save(list);
	systemRealm.clearAllCachedAuthorizationInfo();
	UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
    }

    @Transactional(readOnly = false)
    public void deleteMenu(Long id) {
	menuDao.deleteById(id, "%," + id + ",%");
	systemRealm.clearAllCachedAuthorizationInfo();
	UserUtils.removeCache(UserUtils.CACHE_MENU_LIST);
    }

    // /////////////// Synchronized to the Activiti //////////////////

    public Set<String> getUserIdByRoleIds(String userIds) {
	Set<String> set = new HashSet<String>();
	String[] idsArray = userIds.split("[,]");
	for (String roleId : idsArray) {
	    if (org.apache.commons.lang3.StringUtils.isNotEmpty(roleId)) {
		Role role = roleDao.findOne(new Long(roleId));
		for (Long id : role.getUserIdList()) {
		    set.add(id.toString());
		}
	    }
	}
	return set;
    }

	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub
		
	}

    // /////////////// Synchronized to the Activiti end //////////////////

}
