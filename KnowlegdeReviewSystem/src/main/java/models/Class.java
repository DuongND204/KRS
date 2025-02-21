package models;

import java.util.Date;
import java.util.List;

public class Class {
    private int id;
    private int subjectId;
    private int managerId;
    private String className;
    private String code;
    private int createdBy;
    private int modifiedBy;
    private List<Integer> classStudents;
    private Date createdAt;
    private Date modifiedAt;


    public Class() {
    }

    public Class(int id, String className, String code, int createdBy, int modifiedBy) {
        this.id = id;
        this.className = className;
        this.code = code;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
    }

    public Class(int id, int subjectId, int managerId, String className, String code, int createdBy, int modifiedBy) {
        this.id = id;
        this.subjectId = subjectId;
        this.managerId = managerId;
        this.className = className;
        this.code = code;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
    }

    //region Getter & Setter
    public int getId() {
        return id;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getModifiedAt() {
        return modifiedAt;
    }

    public void setModifiedAt(Date modifiedAt) {
        this.modifiedAt = modifiedAt;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public int getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(int modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public List<Integer> getClassStudents() {
        return classStudents;
    }

    public void setClassStudents(List<Integer> classStudents) {
        this.classStudents = classStudents;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    //endregion
}
