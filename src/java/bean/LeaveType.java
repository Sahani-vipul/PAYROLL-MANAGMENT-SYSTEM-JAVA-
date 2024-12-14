/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author SAHANI VIPUL
 */
@Entity
@Table(name = "leave_type")
@NamedQueries({
    @NamedQuery(name = "LeaveType.findAll", query = "SELECT l FROM LeaveType l"),
    @NamedQuery(name = "LeaveType.findByLeaveTypeId", query = "SELECT l FROM LeaveType l WHERE l.leaveTypeId = :leaveTypeId"),
    @NamedQuery(name = "LeaveType.findByLeaveType", query = "SELECT l FROM LeaveType l WHERE l.leaveType = :leaveType"),
    @NamedQuery(name = "LeaveType.findByLeaveDays", query = "SELECT l FROM LeaveType l WHERE l.leaveDays = :leaveDays")})
public class LeaveType implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "leave_type_id")
    private Integer leaveTypeId;
    @Column(name = "leave_type")
    private String leaveType;
    @Column(name = "leave_days")
    private Integer leaveDays;
    @OneToMany(mappedBy = "leaveTypeId")
    private Collection<Leave> leaveCollection;

    public LeaveType() {
    }

    public LeaveType(Integer leaveTypeId) {
        this.leaveTypeId = leaveTypeId;
    }

    public Integer getLeaveTypeId() {
        return leaveTypeId;
    }

    public void setLeaveTypeId(Integer leaveTypeId) {
        this.leaveTypeId = leaveTypeId;
    }

    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public Integer getLeaveDays() {
        return leaveDays;
    }

    public void setLeaveDays(Integer leaveDays) {
        this.leaveDays = leaveDays;
    }

    public Collection<Leave> getLeaveCollection() {
        return leaveCollection;
    }

    public void setLeaveCollection(Collection<Leave> leaveCollection) {
        this.leaveCollection = leaveCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (leaveTypeId != null ? leaveTypeId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LeaveType)) {
            return false;
        }
        LeaveType other = (LeaveType) object;
        if ((this.leaveTypeId == null && other.leaveTypeId != null) || (this.leaveTypeId != null && !this.leaveTypeId.equals(other.leaveTypeId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "bean.LeaveType[ leaveTypeId=" + leaveTypeId + " ]";
    }
    
}
