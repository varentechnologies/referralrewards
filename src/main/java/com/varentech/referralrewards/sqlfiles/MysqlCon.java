package com.varentech.referralrewards.sqlfiles;

import java.sql.*;
class MysqlCon{
    public static void main(String args[]){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/varendatabase","root","varenpassword");

            con.close();
        }catch(Exception e){ System.out.println(e);}
    }
}
