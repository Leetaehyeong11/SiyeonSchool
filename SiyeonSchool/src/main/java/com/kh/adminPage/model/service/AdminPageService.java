package com.kh.adminPage.model.service;

import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.adminPage.model.dao.AdminPageDao;
import com.kh.user.model.vo.User;	

public class AdminPageService {

    public ArrayList<User> selectStudentList(){
        Connection conn = getConnection();

        ArrayList<User> list = new AdminPageDao().selectStudentList(conn);
        
        close(conn);

        return list;
    }

    public ArrayList<User> selectSignRequest(){
        Connection conn = getConnection();
        
        ArrayList<User> list = new AdminPageDao().selectSignRequest(conn);
        
        close(conn);
        
        return list;
    }

    public int approveUser(int userNo){
        Connection conn = getConnection();
        
        int result = new AdminPageDao().approveUser(conn, userNo);

        if(result > 0){
            commit(conn);
        }else{
            rollback(conn);
        }

        close(conn);
        
        return result;
    }

    public int refusalStudent(int userNo){
        Connection conn = getConnection();
        
        int result = new AdminPageDao().refusalStudent(conn, userNo);

        if(result > 0){
            commit(conn);
        }else{
            rollback(conn);
        }
        
        close(conn);
        
        return result;
    }

}


