package bean;

import bean.Attendance;
import bean.Leave;
import bean.Salary;
import bean.Users;
import java.math.BigDecimal;
import java.sql.Date;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2024-12-14T11:12:15", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Employee.class)
public class Employee_ { 

    public static volatile SingularAttribute<Employee, String> departmentName;
    public static volatile SingularAttribute<Employee, String> lastName;
    public static volatile SingularAttribute<Employee, String> role;
    public static volatile SingularAttribute<Employee, Integer> departmentId;
    public static volatile SingularAttribute<Employee, Integer> employeeId;
    public static volatile CollectionAttribute<Employee, Leave> leaveCollection;
    public static volatile SingularAttribute<Employee, String> firstName;
    public static volatile SingularAttribute<Employee, Date> dateOfJoining;
    public static volatile CollectionAttribute<Employee, Salary> salaryCollection;
    public static volatile CollectionAttribute<Employee, Attendance> attendanceCollection;
    public static volatile SingularAttribute<Employee, String> phone;
    public static volatile SingularAttribute<Employee, BigDecimal> basicSalary;
    public static volatile CollectionAttribute<Employee, Users> usersCollection;
    public static volatile SingularAttribute<Employee, String> email;

}