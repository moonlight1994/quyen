<%--
    Document   : searchBook
    Created on : Mar 14, 2015, 6:24:01 PM
    Author     : NGUYEN THU HA
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>m5Book</title>
    </head>
    <body>
        <p><i><b><marquee align="center" direction="left" height="50"  scrollamount="5" width="100%">Find information of book which you are interested  the way quickly and efficiently!</marquee></b></i></p>

        <jsp:useBean class="com.sample.beanBook" id="bea" scope="session"/>
        <jsp:useBean class="com.sample.DataAccess" id="be" scope="session"/>
        <form name="mform">
            <%
                session.setAttribute("cnt", 1);
            %>

            <table style="text-align: center" >

                <tr>
                    <td><b>Book Title:</b></td>
                    <td><p><input type="text" name="txtBookTitle" value="" /></p></td>
                </tr>
                <tr>
                    <td><b>Category :</b></td>
                    <td style="width: 100px">
                        <%
                            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                            Connection conn
                                    = DriverManager.getConnection("jdbc:odbc:newProjectJava");
                            String sql = "select * from Category";
                            ResultSet rs1 = conn.createStatement().executeQuery(sql);
                        %>
                        <select name="slcCat">
                            <%
                                while (rs1.next()) {
                                    int id = rs1.getInt(1);
                                    String name = rs1.getString(2);
                            %>
                            <option value="<%=id%>"><%=name%></option>
                            <%
                                }
                                conn.close();

                            %>
                            <option value="Null" selected></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Price : </b></td>
                    <td><input type="text" name="txtPrice" value="" /></td>
                    <td style="width: 100px"> </td>
                    <td style="width: 100px"> </td>
                    <td style="width: 100px"> </td>
                </tr>

                <tr>
                    <td><big><p><input type="submit" value="Search" name="btnSearch" /></p></big></td>
                <td><big><input type="reset" value="Clear" name="txtClear" onclick="window.location = 'searchBook.jsp'"/></big></td>   
                <td style="width: 100px"> </td>
                <td style="width: 100px"> </td>
                <td style="width: 100px"> </td>
                </tr> 
            </table>
            <table border='3'>
                <tr bgcolor="#61AB0D">
                    <td style="width: 100px"><big>ID</big></td>
                <td style="width: 100px"><big>Title</big></td>
                <td style="width: 100px"><big>Price(USD)</big></td>
                <td style="width: 100px"><big>Description</big></td>
                <td style="width: 100px"><big>Create date</big></td>
                <td style="width: 100px"><big>Category</big></td>
                <td style="width: 100px"><big>Action</big></td>
                </tr>
                <%                    //check input
                    if (request.getParameter("btnSearch") != null
                            && request.getParameter("btnSearch").length() > 0) {
                        boolean check = true;
                        int key = 0;
                        //Check la so 
                        try {
                            if (!request.getParameter("txtPrice").equals("")) {
                                double price = Double.parseDouble(request.getParameter("txtPrice"));
                            }
                        } catch (Exception ex) {
                            check = false;
                            key = 1;
                %>
                <p><i><span style="color: red">Price Must a number</span></i></p>
                <%
                    }
                    //check la so duong
                    if (key == 0) {
                        if (!request.getParameter("txtPrice").equals("")) {
                            double price = Double.parseDouble(request.getParameter("txtPrice"));

                            if (price <= 0) {
                                check = false;
                %>
                <p><i><span style="color: red">Price Must a number greater than 0!</span></i></p>
                <%
                            }

                        }
                    }

                    //truong hop search tai o titleA
                    if (check == true && !request.getParameter("txtBookTitle").equals("")
                            && request.getParameter("txtPrice").equals("") && request.getParameter("slcCat").equals("Null")) {

                        String title = request.getParameter("txtBookTitle");
                        bea.setTitle(title);
                        ResultSet rs = bea.Search(title);
                        int i = 0;
                        String color = "";
                        if (rs.next()) {
                            rs = bea.Search(title);
                            while (rs.next()) {
                                bea.setBook_Id(rs.getInt(1));
                                bea.setTitle(rs.getString(2));
                                bea.setDescription(rs.getString(4));
                                bea.setDate(rs.getString(6));
                                bea.setPrice(rs.getDouble(11));
                                i++;
                                if (i % 2 == 0) {
                                    color = "#8DF245";
                                } else {
                                    color = "#D3FAB8";
                                }
                                 Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                            Connection conn2
                                    = DriverManager.getConnection("jdbc:odbc:newProjectJava");
                            String sql2 = "select Category_Name from Category Where Category_ID = '" + bea.getCategory() + "'";
                            ResultSet rs2 = conn2.createStatement().executeQuery(sql);
                            rs2.next();
                            String catery = rs2.getString(1);
                                
                %>

                <tr bgcolor="<%=color%>">
                    <td><%=bea.getBook_Id()%></td>
                    <td><%=bea.getTitle()%></td>
                    <td><%=bea.getPrice()%></td>
                    <td><%=bea.getDescription()%></td>
                    <td><%=bea.getDate()%></td> 
                    <td><%=catery%></td>
                    <td><a href="Delete.jsp?book_Id=<%=bea.getBook_Id()%>&title=<%=bea.getTitle()%>">Delete</a></td>                 

                </tr>
                <%
                    }
                } else {
                %>
                <p style="color: red"><i>Not find appropriate books!</i></p>
                <%
                    }
                } //truong hop search tai o price
                else if (check == true && request.getParameter("txtBookTitle").equals("")
                        && !request.getParameter("txtPrice").equals("") && request.getParameter("slcCat").equals("Null")) {
                    double price = Double.parseDouble(request.getParameter("txtPrice"));
//                    while(Integer.parseInt(session.getAttribute("cnt").toString()) == 1){
//                        session.setAttribute("cnt",2);
////                        int price2 = 0;
////                        if(price % 1 == 0){
////                            price2 = (int) price;
////                        }
//                        String link = "searchBook.jsp?txtBookTitle=&txtPrice=";
//                        link += price;
//                        link += "&btnSearch=Search";
//                        response.sendRedirect("./" + link);
//                        break;
//                    }

                    bea.setPrice(price);

                    ResultSet rs = bea.searchPrice(price);
                    int i = 0;
                    String color = "";
                    if (rs.next()) {
                        //session.setAttribute("cnt",1);
                        rs = bea.searchPrice(price);
                        while (rs.next()) {
                            bea.setBook_Id(rs.getInt(1));
                            bea.setTitle(rs.getString(2));
                            bea.setDescription(rs.getString(4));
                            bea.setDate(rs.getString(6));
                            bea.setPrice(rs.getDouble(11));
                            i++;
                            if (i % 2 == 0) {
                                color = "#8DF245";
                            } else {
                                color = "#D3FAB8";
                            }

                            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                            Connection conn2
                                    = DriverManager.getConnection("jdbc:odbc:newProjectJava");
                            String sql2 = "select Category_Name from Category Where Category_ID = '" + bea.getCategory() + "'";
                            ResultSet rs2 = conn2.createStatement().executeQuery(sql);
                            rs2.next();
                            String catery = rs2.getString(1);

                %>

                <tr>
                    <td><%=bea.getBook_Id()%></td>
                    <td><%=bea.getTitle()%></td>
                    <td><%=bea.getPrice()%></td>
                    <td><%=bea.getDescription()%></td>
                    <td><%=bea.getDate()%></td>
                    <td><%=catery%></td>
                    <td><a href="Delete.jsp?book_Id=<%=bea.getBook_Id()%>&title=<%=bea.getTitle()%>">Delete</a></td

                </tr>
                <%
                    }
                } else {
                %>
                <p style="color: red"><i>Not find appropriate books!<i></p>
                            <%
                                }
                            } //truong hop search ca 2 o title va price
                            else if (check == true && !request.getParameter("txtBookTitle").equals("")
                                    && !request.getParameter("txtPrice").equals("") && request.getParameter("slcCat").equals("Null")) {
                                String title = request.getParameter("txtBookTitle");
                                bea.setTitle(title);
                                double price = Double.parseDouble(request.getParameter("txtPrice"));
                                bea.setPrice(price);
                                ResultSet rs = bea.searchFull(title, price);
                                int i = 0;
                                String color = "";
                                if (rs.next()) {
                                    rs = bea.searchFull(title, price);
                                    while (rs.next()) {
                                        bea.setBook_Id(rs.getInt(1));
                                        bea.setTitle(rs.getString(2));
                                        bea.setDescription(rs.getString(4));
                                        bea.setDate(rs.getString(6));
                                        bea.setPrice(rs.getDouble(11));
                                        i++;
                                        if (i % 2 == 0) {
                                            color = "#8DF245";
                                        } else {
                                            color = "#D3FAB8";
                                        }
                                        
                                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                                        Connection conn2
                                                = DriverManager.getConnection("jdbc:odbc:newProjectJava");
                                        String sql2 = "select Category_Name from Category Where Category_ID = '" + bea.getCategory() + "'";
                                        ResultSet rs2 = conn2.createStatement().executeQuery(sql);
                                        rs2.next();
                                        String catery = rs2.getString(1);
                            %>

                            <tr>
                                <td><%=bea.getBook_Id()%></td>
                                <td><%=bea.getTitle()%></td>
                                <td><%=bea.getPrice()%></td>
                                <td><%=bea.getDescription()%></td>
                                <td><%=bea.getDate()%></td>
                                <td><%=catery%></td>
                                <td><a href="Delete.jsp?book_Id=<%=bea.getBook_Id()%>&title=<%=bea.getTitle()%>">Delete</a></td

                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <p style="color: red"><i>Not find appropriate books!</i></p>
                            <%
                                }
                            } else if (check == true && request.getParameter("txtBookTitle").equals("")
                                    && request.getParameter("txtPrice").equals("") && !request.getParameter("slcCat").equals("Null")) {
                                String Cate = request.getParameter("slcCat");
                                
                                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                                Connection conn2 = DriverManager.getConnection("jdbc:odbc:newProjectJava");
                                String sql2 = "select Category_Name from Category Where Category_ID = ?";
                                PreparedStatement ps = conn2.prepareStatement(sql2);
                                ps.setInt(1, Integer.parseInt(request.getParameter("slcCat")));
                                ResultSet rs2 = ps.executeQuery();
                                String catery = "";
                                if (rs2.next()){
                                    catery = rs2.getString(1);
                                }
                                
                                ResultSet rs3 = bea.searchCategory(Integer.parseInt(Cate));
                                int i = 0;
                                String color = "";
                                if (rs3.next()) {
                                    do {
                                        bea.setBook_Id(rs3.getInt(1));
                                        bea.setTitle(rs3.getString(2));
                                        bea.setCategory2(rs3.getInt(3));
                                        bea.setDescription(rs3.getString(4));
                                        bea.setDate(rs3.getString(6));
                                        bea.setPrice(rs3.getDouble(11));
                                        i++;
                                        if (i % 2 == 0) {
                                            color = "#8DF245";
                                        } else {
                                            color = "#D3FAB8";
                                        }
                            %>

                            <tr bgcolor="<%=color%>">
                                <td><%=bea.getBook_Id()%></td>
                                <td><%=bea.getTitle()%></td>
                                <td><%=bea.getPrice()%></td>
                                <td><%=bea.getDescription()%></td>
                                <td><%=bea.getDate()%></td> 
                                <td><%=catery%></td>
                                <td><a href="Delete.jsp?book_Id=<%=bea.getBook_Id()%>&title=<%=bea.getTitle()%>">Delete</a></td>                 
                                <td><a href="update.jsp?book_Id=<%=bea.getBook_Id()%>&title=<%=bea.getTitle()%>">Update</a></td> 
                            </tr>
                            <%
                                } while (rs3.next());
                            } else {
                            %>
                            <p style="color: red"><i>Not find appropriate books!</i></p>
                            <%
                                        }
                                    }
                                }
                            %>                 
                            </table>
                            </form>
                            </body>
                            </html>
