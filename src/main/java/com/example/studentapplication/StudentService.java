package com.example.studentapplication;

import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.List;

public class StudentService {

    private StudentDAO studentDAO;

    public StudentService() {
        this.studentDAO = new StudentDAO();
    }

    public void addStudent(Student student) throws SQLException {
        studentDAO.addStudent(student);
    }

    public List<Student> getAllStudents() throws ClassNotFoundException, InvocationTargetException, NoSuchMethodException, InstantiationException, IllegalAccessException {
        return studentDAO.getAllStudents();
    }


    // другая бизнес-логика
}
