/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author SAHANI VIPUL
 */
public class DepartmentDao {

    public static ArrayList<Department> getAllDepartments() throws Exception {
        ArrayList<Department> departments = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = UserDao.getConnection();
            String sql = "SELECT * FROM department";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Department d = new Department();
                d.setDepartmentId(rs.getInt("department_id"));
                d.setDepartmentName(rs.getString("department_name"));
                departments.add(d);
//                departments.add(rs.getString("department_name"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return departments;
    }

   public static int AddDepartment(Department bean){
     
      int result = 0;
      
       try{
       
           Connection con = UserDao.getConnection();
           String sql = "INSERT INTO `department`(`department_name`) VALUES (?)";
           PreparedStatement pst = con.prepareStatement(sql);
           pst.setString(1,bean.getDepartmentName());
           
           result = pst.executeUpdate();
       }catch(Exception e){
       
           System.err.println(e);
       }
      return result;
   } 
   
   public static int deleteDepartment(int id){
       
       int status = 0;
       Connection con;
        try{
            con = UserDao.getConnection();
            PreparedStatement pst = con.prepareStatement("delete from department where department_id = ?");
            pst.setInt(1,id);
            status = pst.executeUpdate();
        }catch(Exception e){
            System.out.println("bean.UserDao.delete()");
        }
       return status;
   }
}
