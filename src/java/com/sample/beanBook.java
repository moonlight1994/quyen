/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sample;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author NGUYEN THU HA
 */
public class beanBook {

    public beanBook() {
    }
  
    private int book_Id;

    /**
     * Get the value of book_Id
     *
     * @return the value of book_Id
     */
    public int getBook_Id() {
        return book_Id;
    }

    /**
     * Set the value of book_Id
     *
     * @param book_Id new value of book_Id
     */
    public void setBook_Id(int book_Id) {
        this.book_Id = book_Id;
    }
  
    private String title;

    /**
     * Get the value of title
     *
     * @return the value of title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Set the value of title
     *
     * @param title new value of title
     */
    public void setTitle(String title) {
        this.title = title;
    }

    private int cate_Id;

    /**
     * Get the value of cate_Id
     *
     * @return the value of cate_Id
     */
    public int getCate_Id() {
        return cate_Id;
    }

    /**
     * Set the value of cate_Id
     *
     * @param cate_Id new value of cate_Id
     */
    public void setCate_Id(int cate_Id) {
        this.cate_Id = cate_Id;
    }

    private String description;

    /**
     * Get the value of description
     *
     * @return the value of description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Set the value of description
     *
     * @param description new value of description
     */
    public void setDescription(String description) {
        this.description = description;
    }

    private String selling;

    /**
     * Get the value of selling
     *
     * @return the value of selling
     */
    public String getSelling() {
        return selling;
    }

    /**
     * Set the value of selling
     *
     * @param selling new value of selling
     */
    public void setSelling(String selling) {
        this.selling = selling;
    }

    private String date;

    /**
     * Get the value of date
     *
     * @return the value of date
     */
    public String getDate() {
        return date;
    }

    /**
     * Set the value of date
     *
     * @param date new value of date
     */
    public void setDate(String date) {
        this.date = date;
    }

    private String discount;

    /**
     * Get the value of discount
     *
     * @return the value of discount
     */
    public String getDiscount() {
        return discount;
    }

    /**
     * Set the value of discount
     *
     * @param discount new value of discount
     */
    public void setDiscount(String discount) {
        this.discount = discount;
    }

    private String status;

    /**
     * Get the value of status
     *
     * @return the value of status
     */
    public String getStatus() {
        return status;
    }

    /**
     * Set the value of status
     *
     * @param status new value of status
     */
    public void setStatus(String status) {
        this.status = status;
    }

    private String discountFrom;

    /**
     * Get the value of discountFrom
     *
     * @return the value of discountFrom
     */
    public String getDiscountFrom() {
        return discountFrom;
    }

    /**
     * Set the value of discountFrom
     *
     * @param discountFrom new value of discountFrom
     */
    public void setDiscountFrom(String discountFrom) {
        this.discountFrom = discountFrom;
    }

    private String DiscountTo;

    /**
     * Get the value of DiscountTo
     *
     * @return the value of DiscountTo
     */
    public String getDiscountTo() {
        return DiscountTo;
    }

    /**
     * Set the value of DiscountTo
     *
     * @param DiscountTo new value of DiscountTo
     */
    public void setDiscountTo(String DiscountTo) {
        this.DiscountTo = DiscountTo;
    }

    private double price;

    /**
     * Get the value of price
     *
     * @return the value of price
     */
    public double getPrice() {
        return price;
    }

    /**
     * Set the value of price
     *
     * @param price new value of price
     */
    public void setPrice(double price) {
        this.price = price;
    }
int Category;

    public int getCategory() {
        return Category;
    }

    public void setCategory(int Category) {
        this.Category = Category;
    }
    
    private int Category2;

    public int getCategory2() {
        return Category2;
    }

    public void setCategory2(int Category2) {
        this.Category2 = Category2;
    }

    public ResultSet Search (String t){
        ResultSet rs = null;
        try {
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection conn=DriverManager.getConnection("jdbc:odbc:newProjectJava");
        String sql ="select * from Book where Title like '%" + t + "%'";
        PreparedStatement ps = conn.prepareStatement(sql);
         rs = ps.executeQuery();
          
        //conn.close();
             
        } catch (Exception e) {
            
        }
           return rs;
    }
  
    public ResultSet searchPrice(double d){
        ResultSet rs = null;
        try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection conn=DriverManager.getConnection("jdbc:odbc:newProjectJava");
        String sql ="select * from Book where Price = ?";  
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setDouble(1, d);
        rs = ps.executeQuery();
          
        }catch(Exception e){
       }
          return rs;
   
    }
     public ResultSet searchFull(String t, double d){
        ResultSet rs = null;
        try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection conn=DriverManager.getConnection("jdbc:odbc:newProjectJava");
        String sql ="select * from Book where Price = '"+d+" 'and Title like '%"+t+"%'" ;
        PreparedStatement ps = conn.prepareStatement(sql);
         rs = ps.executeQuery();
          
        }catch(Exception e){
       }
          return rs;  
    }
     
     
     public void Delete(){
         try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn=DriverManager.getConnection("jdbc:odbc:newProjectJava"); 
            String sql ="Delete  from Book where Book_ID ="+ book_Id;
            conn.createStatement().execute(sql);
            conn.close();
         } catch (Exception e) {
         }
     }
    
     
    public ResultSet searchCategory(int c){
             ResultSet rs = null;
        try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection conn=DriverManager.getConnection("jdbc:odbc:newProjectJava");
        String sql = "select * from Book where Cate_ID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
         ps.setInt(1, c);
         rs = ps.executeQuery();
          
        }catch(Exception e){
       }
          return rs;
    } 

}
