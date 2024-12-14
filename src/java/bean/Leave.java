    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    package bean;

    import java.io.Serializable;
    import java.util.Date;
    import javax.persistence.Basic;
    import javax.persistence.Column;
    import javax.persistence.Entity;
    import javax.persistence.GeneratedValue;
    import javax.persistence.GenerationType;
    import javax.persistence.Id;
    import javax.persistence.JoinColumn;
    import javax.persistence.ManyToOne;
    import javax.persistence.NamedQueries;
    import javax.persistence.NamedQuery;
    import javax.persistence.Table;
    import javax.persistence.Temporal;
    import javax.persistence.TemporalType;

    /**
     *
     * @author SAHANI VIPUL
     */
    @Entity
    @Table(name = "leave")
    @NamedQueries({
        @NamedQuery(name = "Leave.findAll", query = "SELECT l FROM Leave l"),
        @NamedQuery(name = "Leave.findByLeaveId", query = "SELECT l FROM Leave l WHERE l.leaveId = :leaveId"),
        @NamedQuery(name = "Leave.findByStartDate", query = "SELECT l FROM Leave l WHERE l.startDate = :startDate"),
        @NamedQuery(name = "Leave.findByEndDate", query = "SELECT l FROM Leave l WHERE l.endDate = :endDate")})
    public class Leave implements Serializable {

        private static final long serialVersionUID = 1L;
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Basic(optional = false)
        @Column(name = "leave_id")
        private Integer leaveId;
        @Column(name = "start_date")
        @Temporal(TemporalType.DATE)
        private Date startDate;
        @Column(name = "end_date")
        @Temporal(TemporalType.DATE)
        private Date endDate;
        @JoinColumn(name = "employee_id", referencedColumnName = "employee_id")
        @ManyToOne
        private int employeeId;
        @JoinColumn(name = "leave_type_id", referencedColumnName = "leave_type_id")
        @ManyToOne
        private int leaveTypeId;
        private String status;
        private String firstName;
        private String lastName;
        private String email;
        private String departmentName;
        private String leaveType;
        private int totalDays;
        private int takenLeaves;



        public Leave() {
        }

        public Leave(Integer leaveId) {
            this.leaveId = leaveId;
        }

        public Integer getLeaveId() {
            return leaveId;
        }

        public void setLeaveId(Integer leaveId) {
            this.leaveId = leaveId;
        }

        public Date getStartDate() {
            return startDate;
        }

        public void setStartDate(Date startDate) {
            this.startDate = startDate;
        }

        public Date getEndDate() {
            return endDate;
        }

        public void setEndDate(Date endDate) {
            this.endDate = endDate;
        }

        public int getEmployeeId() {
            return employeeId;
        }

        public void setEmployeeId(int employeeId) {
            this.employeeId = employeeId;
        }

        public int getLeaveTypeId() {
            return leaveTypeId;
        }

        public void setLeaveTypeId(int leaveTypeId) {
            this.leaveTypeId = leaveTypeId;
        }

        public String getStatus() {
            return status;
        }

        // Setter for status
        public void setStatus(String status) {
            this.status = status;
        }

        public String getFirstName() {
            return firstName;
        }

        public void setFirstName(String firstName) {
            this.firstName = firstName;
        }

        public String getLastName() {
            return lastName;
        }

        public void setLastName(String lastName) {
            this.lastName = lastName;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }


        public String getDepartmentName() {
            return departmentName;
        }

        public void setDepartmentName(String departmentName) {
            this.departmentName = departmentName;
        }

        public String getLeaveType() {
            return leaveType;
        }

        public void setLeaveType(String leaveType) {
            this.leaveType = leaveType;
        }

        public int getTotalDays() {
        return totalDays;
    }

    public void setTotalDays(int totalDays) {
        this.totalDays = totalDays;
    }
    public int getTakenLeaves() {
            return takenLeaves;
        }

        public void setTakenLeaves(int takenLeaves) {
            this.takenLeaves = takenLeaves;
        }


        @Override
        public int hashCode() {
            int hash = 0;
            hash += (leaveId != null ? leaveId.hashCode() : 0);
            return hash;
        }

        @Override
        public boolean equals(Object object) {
            // TODO: Warning - this method won't work in the case the id fields are not set
            if (!(object instanceof Leave)) {
                return false;
            }
            Leave other = (Leave) object;
            if ((this.leaveId == null && other.leaveId != null) || (this.leaveId != null && !this.leaveId.equals(other.leaveId))) {
                return false;
            }
            return true;
        }

        @Override
        public String toString() {
            return "bean.Leave[ leaveId=" + leaveId + " ]";
        }

    }
