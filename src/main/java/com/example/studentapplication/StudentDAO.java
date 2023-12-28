package com.example.studentapplication;

// src/main/java/com/вашакомпания/вашеприложение/dao/StudentDAO.java
import jakarta.servlet.http.HttpServletRequest;

import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {


    private String url = "jdbc:mysql://localhost:3306/students";
    private String username = "root";
    private String password = "root";

    // логика подключения к базе данных
    public void addStudent(Student student) throws SQLException {
        String firstName = student.getFirstName();
        String lastName = student.getLastName();
        String middleName = student.getMiddleName();
        int course = student.getCourse();
        String faculty = student.getFaculty();
        String studyForm = student.getStudyForm();
        String scholarship = student.getScholarship();
        int orderNumber = student.getOrderNumber();
        String orderDate = student.getOrderDate();
        String issuanceEndDate = student.getIssuanceEndDate();
        String foundationEndDate = student.getFoundationEndDate();
        String foundationReason = student.getFoundationReason();

        try {

            // Загружаем драйвер
            try {
                Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
            } catch (InstantiationException | IllegalAccessException | InvocationTargetException |
                     NoSuchMethodException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }

            // Открываем соединение с базой данных
            try (Connection conn = DriverManager.getConnection(url, username, password)) {
                String sql = "INSERT INTO students_univ " +
                        "(firstName, lastName, middleName, course, faculty, studyForm, scholarship, orderNumber, orderDate, issuanceEndDate, foundationEndDate, foundationReason) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                // Используем try-with-resources для автоматического закрытия ресурсов
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, firstName);
                    statement.setString(2, lastName);
                    statement.setString(3, middleName);
                    statement.setInt(4, course);
                    statement.setString(5, faculty);
                    statement.setString(6, studyForm);
                    statement.setString(7, scholarship);
                    statement.setInt(8, orderNumber);
                    statement.setString(9, orderDate);
                    statement.setString(10, issuanceEndDate);
                    statement.setString(11, foundationEndDate);
                    statement.setString(12, foundationReason);

                    // Выполняем запрос на добавление записи
                    statement.executeUpdate();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

        } catch(Exception ex){
            System.out.println("...");
        } finally {
            System.out.println("---");
        }
    }


    public List<Student> getAllStudents() throws ClassNotFoundException, NoSuchMethodException, InvocationTargetException, InstantiationException, IllegalAccessException {
        List<Student> students = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
            try (Connection connection = DriverManager.getConnection(url, username, password)) {
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT * FROM students_univ");

                while (resultSet.next()) {
                    Student student = new Student();
                    student.setId(resultSet.getInt("id"));
                    student.setFirstName(resultSet.getString("firstName"));
                    student.setLastName(resultSet.getString("lastName"));
                    student.setMiddleName(resultSet.getString("middleName"));
                    student.setCourse(resultSet.getInt("course"));
                    student.setFaculty(resultSet.getString("faculty"));
                    student.setStudyForm(resultSet.getString("studyForm"));
                    student.setScholarship(resultSet.getString("scholarship"));
                    student.setOrderNumber(resultSet.getInt("orderNumber"));
                    student.setOrderDate(resultSet.getString("orderDate"));
                    student.setIssuanceEndDate(resultSet.getString("issuanceEndDate"));
                    student.setFoundationEndDate(resultSet.getString("foundationEndDate"));
                    student.setFoundationReason(resultSet.getString("foundationReason"));
                    // другие поля
                    students.add(student);
                }
            }
        } catch (InstantiationException | IllegalAccessException | IllegalArgumentException |
                 InvocationTargetException | NoSuchMethodException | SecurityException | ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return students;
    }




    // другие операции CRUD
}

