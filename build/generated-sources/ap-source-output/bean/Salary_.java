package bean;

import bean.Employee;
import java.math.BigDecimal;
import java.util.Date;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2024-12-14T11:12:15", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Salary.class)
public class Salary_ { 

    public static volatile SingularAttribute<Salary, String> departmentName;
    public static volatile SingularAttribute<Salary, String> lastName;
    public static volatile SingularAttribute<Salary, String> firstName;
    public static volatile SingularAttribute<Salary, BigDecimal> basicSalary;
    public static volatile SingularAttribute<Salary, String> paymentMethod;
    public static volatile SingularAttribute<Salary, Employee> employeeId;
    public static volatile SingularAttribute<Salary, BigDecimal> allowances;
    public static volatile SingularAttribute<Salary, BigDecimal> netSalary;
    public static volatile SingularAttribute<Salary, BigDecimal> deductions;
    public static volatile SingularAttribute<Salary, Date> paymentDate;
    public static volatile SingularAttribute<Salary, Integer> salaryId;
    public static volatile SingularAttribute<Salary, String> email;

}