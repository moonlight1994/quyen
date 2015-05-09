package com.sample;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author NGUYEN THU HA
 */
public class DataAccess {
    Connection conn =null;
     public DataAccess(){
        try{
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            conn=DriverManager.getConnection("jdbc:odbc:newProjectJava");
        }
        catch(Exception ex){
            
        }
    
    }
       @Override
    protected void finalize() throws Throwable {
        if(conn != null)
            conn.close();
    }
       public ResultSet getAllBook(){
        ResultSet rs = null;
        try{
            String sqlSelect = "select * from Book";            
            rs = conn.createStatement().executeQuery(sqlSelect);
        }
        catch(Exception ex){
            
        }
        return rs;
    }
    
}
