package bean;

import java.util.Date;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2024-12-14T11:12:15", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Attendance.class)
public class Attendance_ { 

    public static volatile SingularAttribute<Attendance, Date> date;
    public static volatile SingularAttribute<Attendance, String> departmentName;
    public static volatile SingularAttribute<Attendance, String> firstName;
    public static volatile SingularAttribute<Attendance, String> lastName;
    public static volatile SingularAttribute<Attendance, Date> checkOutTime;
    public static volatile SingularAttribute<Attendance, Date> checkInTime;
    public static volatile SingularAttribute<Attendance, int> employeeId;
    public static volatile SingularAttribute<Attendance, Integer> attendanceId;
    public static volatile SingularAttribute<Attendance, String> email;
    public static volatile SingularAttribute<Attendance, String> status;

}