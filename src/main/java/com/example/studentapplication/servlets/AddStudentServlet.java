package com.example.studentapplication.servlets;

import com.example.studentapplication.Student;
import com.example.studentapplication.StudentService;
import com.google.gson.Gson;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/addStudent")
public class AddStudentServlet extends HttpServlet {

    private StudentService studentService;

    @Override
    public void init() {
        this.studentService = new StudentService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Прочитайте данные из запроса в виде JSON
            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            // Преобразуйте JSON в объект Student
            Gson gson = new Gson();
            Student student = gson.fromJson(sb.toString(), Student.class);

            // Вызовите метод addStudent из studentService, передавая объект Student
            studentService.addStudent(student);

            // Отправьте клиенту успешный статус ответа
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Ваша логика для GET-запроса (если нужно)
    }
}
