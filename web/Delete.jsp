<%-- 
    Document   : Delete
    Created on : Mar 15, 2015, 12:39:54 PM
    Author     : NGUYEN THU HA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:useBean class="com.sample.beanBook" id="bea" scope="session"/>
         <%
            
            String id = request.getParameter("book_Id");
            String title = request.getParameter("title");
        %>
        <form name="mform">
            <%
            if(id != null){
                bea.setBook_Id(Integer.parseInt(id));
//                int id1 = Integer.parseInt(request.getParameter("book_Id"));
//              bea.setBook_Id(id1);
            }
            bea.setTitle(title);
            
            if(request.getParameter("btnYes") == null){
                session.setAttribute("book_Id", id);
            }
             if(request.getParameter("btnYes") != null && request.getParameter("btnYes").length() > 0){
                bea.Delete();
                response.sendRedirect("./searchBook.jsp");
            }
           %> 
            <h1>
            Are you sure you want to delete category <%=bea.getTitle()%>
            </h1> 
      
           
        <input type="submit" value="Yes" name="btnYes" />
        <input type="button" value="No" name="btnNo" onclick="window.location='searchBook.jsp'" />
        </form>
    </body>
</html>
