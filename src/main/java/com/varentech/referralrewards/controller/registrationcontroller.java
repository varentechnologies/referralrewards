package com.varentech.referralrewards.controller;

import com.varentech.referralrewards.security.DefaultUser;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class registrationcontroller extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DefaultUser employee = (DefaultUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long employeeId = employee.getId();


        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String candidateln=request.getParameter("candidateln");
        String candidatefn=request.getParameter("candidatefn");
        String candemail=request.getParameter("candemail");
        String phone=request.getParameter("phone");
        String clearance=request.getParameter("clearance");
        String position=request.getParameter("position");
        String relation=request.getParameter("relation");
        String qualification=request.getParameter("qualification");
        String anonymous=request.getParameter("anonymous");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            // loads mysql driver

            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/varendatabase", "root", "varenpassword");

            String query = "insert into varendatabase.referralcandidates values(?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query); // generates sql query

            ps.setString(1, candidateln);
            ps.setString(2, candidatefn);
            ps.setString(3, candemail);
            ps.setString(4, phone);
            ps.setString(5, phone);
            ps.setString(6, clearance);
            ps.setString(7, position);
            ps.setString(8, relation);
            ps.setString(9, qualification);
            ps.setString(10, anonymous);

            ps.executeUpdate(); // execute it on test database
            System.out.println("successfully inserted");
            ps.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            //
            e.printStackTrace();
        }
        RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
        rd.forward(request, response);
        }
}
