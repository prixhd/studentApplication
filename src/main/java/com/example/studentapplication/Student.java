package com.example.studentapplication;

public class Student {
    private int id;
    private String firstName;
    private String lastName;
    private String middleName;
    private int course;
    private String faculty;
    private String studyForm;
    private String scholarship;
    private int orderNumber;
    private String orderDate;
    private String issuanceEndDate;
    private String foundationEndDate;
    private String foundationReason;

    public Student() {}
    public Student(String firstName, String lastName, String middleName,
                   int course, String faculty, String studyForm,
                   String scholarship, int orderNumber, String orderDate,
                   String issuanceEndDate, String foundationEndDate, String foundationReason) {

        this.firstName = firstName;
        this.lastName = lastName;
        this.middleName = middleName;
        this.course = course;
        this.faculty = faculty;
        this.studyForm = studyForm;
        this.scholarship = scholarship;
        this.orderNumber = orderNumber;
        this.orderDate = orderDate;
        this.issuanceEndDate = issuanceEndDate;
        this.foundationEndDate = foundationEndDate;
        this.foundationReason = foundationReason;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public int getCourse() {
        return course;
    }

    public void setCourse(int course) {
        this.course = course;
    }

    public String getFaculty() {
        return faculty;
    }

    public void setFaculty(String faculty) {
        this.faculty = faculty;
    }

    public String getStudyForm() {
        return studyForm;
    }

    public void setStudyForm(String studyForm) {
        this.studyForm = studyForm;
    }

    public String getScholarship() {
        return scholarship;
    }

    public void setScholarship(String scholarship) {
        this.scholarship = scholarship;
    }

    public int getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(int orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getIssuanceEndDate() {
        return issuanceEndDate;
    }

    public void setIssuanceEndDate(String issuanceEndDate) {
        this.issuanceEndDate = issuanceEndDate;
    }

    public String getFoundationEndDate() {
        return foundationEndDate;
    }

    public void setFoundationEndDate(String foundationEndDate) {
        this.foundationEndDate = foundationEndDate;
    }

    public String getFoundationReason() {
        return foundationReason;
    }

    public void setFoundationReason(String foundationReason) {
        this.foundationReason = foundationReason;
    }
}

