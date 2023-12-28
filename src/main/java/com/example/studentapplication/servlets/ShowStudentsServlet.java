package com.example.studentapplication.servlets;
// src/main/java/com/вашакомпания/вашеприложение/web/AddStudentServlet.java
import com.example.studentapplication.Student;
import com.example.studentapplication.StudentService;
import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/showStudents")
public class ShowStudentsServlet extends HttpServlet {

    private StudentService studentService;

    @Override
    public void init() {
        this.studentService = new StudentService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // обработка отправки формы и вызов сервиса для добавления студента
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            List<Student> students = studentService.getAllStudents();

            // Преобразуйте список студентов в JSON и отправьте на клиент
            Gson gson = new Gson();
            String jsonStudents = gson.toJson(students);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonStudents);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
