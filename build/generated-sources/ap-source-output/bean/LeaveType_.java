package bean;

import bean.Leave;
import javax.annotation.processing.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="org.eclipse.persistence.internal.jpa.modelgen.CanonicalModelProcessor", date="2024-12-14T11:12:15", comments="EclipseLink-2.7.12.v20230209-rNA")
@StaticMetamodel(LeaveType.class)
public class LeaveType_ { 

    public static volatile SingularAttribute<LeaveType, Integer> leaveDays;
    public static volatile SingularAttribute<LeaveType, String> leaveType;
    public static volatile SingularAttribute<LeaveType, Integer> leaveTypeId;
    public static volatile CollectionAttribute<LeaveType, Leave> leaveCollection;

}