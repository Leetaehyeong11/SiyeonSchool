package com.kh.contacts.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import static com.kh.common.JDBCTemplate.*;

import com.kh.contacts.model.dao.ContactsDao;
import com.kh.contacts.model.vo.Contacts;
import com.kh.contacts.model.vo.ContactsCategory;
import com.kh.contacts.model.vo.ContactsMember;
import com.kh.contacts.model.vo.ContactsUsersSortInfo;
import com.kh.user.model.vo.User;

public class ContactsService {
	
	public ArrayList<ContactsCategory> selectCategoryList() {
		Connection conn = getConnection();
		ArrayList<ContactsCategory> list = new ContactsDao().selectCategoryList(conn);
		close(conn);
		return list;
	}
	
	public ArrayList<Contacts> selectPrivateContactsList(int ownerNo) {
		Connection conn = getConnection();
		ArrayList<Contacts> list = new ContactsDao().selectPrivateContactsList(conn, ownerNo);
		close(conn);
		return list;
	}
	
	public ArrayList<Contacts> selectPublicContactsList(int categoryNo) {
		Connection conn = getConnection();
		ArrayList<Contacts> list = new ContactsDao().selectPublicContactsList(conn, categoryNo);
		close(conn);
		return list;
	}
	
	public ArrayList<User> selectAllUsersList(int currentUserNo) {
		Connection conn = getConnection();
		ArrayList<User> list = new ContactsDao().selectAllUsersList(conn, currentUserNo);
		close(conn);
		return list;
	}
	
	public ArrayList<User> selectAllUsersListOrderBy(ContactsUsersSortInfo si) {
		Connection conn = getConnection();
		ArrayList<User> list = new ContactsDao().selectAllUsersListOrderBy(conn, si);
		close(conn);
		return list;
	}

	public ArrayList<User> selectContactsUsersList(int currentUserNo, int contactsNo) {
		Connection conn = getConnection();
		ArrayList<User> list = new ContactsDao().selectContactsUsersList(conn, currentUserNo, contactsNo);
		close(conn);
		return list;
	}
	
	public ArrayList<User> selectContactsUsersListOrderBy(ContactsUsersSortInfo si) {
		Connection conn = getConnection();
		ArrayList<User> list = new ContactsDao().selectContactsUsersListOrderBy(conn, si);
		close(conn);
		return list;
	}
	
	public ArrayList<User> selectCategoryUsersList(int currentUserNo, int categoryNo) {
		Connection conn = getConnection();
		ArrayList<User> list = new ContactsDao().selectCategoryUsersList(conn, currentUserNo, categoryNo);
		close(conn);
		return list;
	}

	public ArrayList<User> selectCategoryUsersListOrderBy(ContactsUsersSortInfo si) {
		Connection conn = getConnection();
		ArrayList<User> list = new ContactsDao().selectCategoryUsersListOrderBy(conn, si);
		close(conn);
		return list;
	}

	public int insertStar(int currentUserNo, int otherUserNo) {
		Connection conn = getConnection();
		int result = new ContactsDao().insertStar(conn, currentUserNo, otherUserNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public int deleteStar(int currentUserNo, int otherUserNo) {
		Connection conn = getConnection();
		int result = new ContactsDao().deleteStar(conn, currentUserNo, otherUserNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public ArrayList<Contacts> selectContactsList(int ownerNo) {
		Connection conn = getConnection();
		ArrayList<Contacts> list = new ContactsDao().selectContactsList(conn, ownerNo);
		close(conn);
		return list;
	}

	public int insertContactsMember(int contactsNo, ArrayList<Integer> checkedUsersNoList) {
		Connection conn = getConnection();
		int result = new ContactsDao().insertContactsMember(conn, contactsNo, checkedUsersNoList);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public int deleteContactsMember(ArrayList<ContactsMember> contactsMemberList) {
		Connection conn = getConnection();
		int result = new ContactsDao().deleteContactsMember(conn, contactsMemberList);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int insertPrivateContacts(String contactsName, int ownerNo) {
		Connection conn = getConnection();
		int result = new ContactsDao().insertPrivateContacts(conn, contactsName, ownerNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int selectContactNo(String contactsName, int ownerNo) {
		Connection conn = getConnection();
		int contactsNo = new ContactsDao().selectContactNo(conn, contactsName, ownerNo);
		close(conn);
		return contactsNo;
	}

	public int insertPublicContacts(int categoryNo, String contactsName) {
		Connection conn = getConnection();
		int result = new ContactsDao().insertPublicContacts(conn, categoryNo, contactsName);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int selectCategoryNoByContactsNo(int contactsNo) {
		Connection conn = getConnection();
		int result = new ContactsDao().selectCategoryNoByContactsNo(conn, contactsNo);
		close(conn);
		return result;
	}

	public int selectCategoryNoByCategoryName(String categoryName) {
		Connection conn = getConnection();
		int result = new ContactsDao().selectCategoryNoByCategoryName(conn, categoryName);
		close(conn);
		return result;
	}
	
	public int insertCategory(String newCategoryName) {
		Connection conn = getConnection();
		int result = new ContactsDao().insertCategory(conn, newCategoryName);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int deleteCategory(int categoryNo) {
		Connection conn = getConnection();
		int result = new ContactsDao().deleteCategory(conn, categoryNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int updateCategoryName(int categoryNo, String newCategoryName) {
		Connection conn = getConnection();
		int result = new ContactsDao().updateCategoryName(conn, categoryNo, newCategoryName);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int updateContactsName(int contactsNo, String newContactsName) {
		Connection conn = getConnection();
		int result = new ContactsDao().updateContactsName(conn, contactsNo, newContactsName);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

	public int deleteContacts(int contactsNo) {
		Connection conn = getConnection();
		int result = new ContactsDao().deleteContacts(conn, contactsNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result;
	}

}
