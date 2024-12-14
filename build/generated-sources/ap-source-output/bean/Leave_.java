package bean;

import bean.LeaveType;
import java.util.Date;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2024-12-14T11:12:15", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(Leave.class)
public class Leave_ { 

    public static volatile SingularAttribute<Leave, String> departmentName;
    public static volatile SingularAttribute<Leave, String> lastName;
    public static volatile SingularAttribute<Leave, Integer> takenLeaves;
    public static volatile SingularAttribute<Leave, Date> endDate;
    public static volatile SingularAttribute<Leave, int> employeeId;
    public static volatile SingularAttribute<Leave, String> firstName;
    public static volatile SingularAttribute<Leave, String> leaveType;
    public static volatile SingularAttribute<Leave, Integer> totalDays;
    public static volatile SingularAttribute<Leave, Integer> leaveId;
    public static volatile SingularAttribute<Leave, LeaveType> leaveTypeId;
    public static volatile SingularAttribute<Leave, Date> startDate;
    public static volatile SingularAttribute<Leave, String> email;
    public static volatile SingularAttribute<Leave, String> status;

}