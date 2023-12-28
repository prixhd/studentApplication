<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.lang.reflect.InvocationTargetException" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Студенческая информационная система</title>
  <link rel="stylesheet" type="text/css"
        href="resources/style.css" />
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script>
    $(document).ready(function () {
      // Обработчик события submit для формы с ID 'addStudentForm'
      $("#addStudentForm").on('submit', function (event) {
        // Отменяем стандартное поведение формы (отправку по HTTP)
        event.preventDefault();

        // Вызываем функцию addStudent
        addStudent();
      });

      // Функция для выполнения AJAX-запроса
      function addStudent() {
        // Используйте serializeArray для получения данных из формы в виде массива объектов
        var formDataArray = $('#addStudentForm').serializeArray();

        // Преобразуйте массив данных в объект
        var formData = {};
        formDataArray.forEach(function (entry) {
          formData[entry.name] = entry.value;
        });

        // Выполняем AJAX-запрос к серверу
        $.ajax({
          type: 'POST',
          url: 'addStudent',
          contentType: 'application/json',  // Указываем, что отправляем JSON
          data: JSON.stringify(formData),  // Преобразуем объект в JSON
          success: function (data) {
            alert("We added a new student to our Database");

            // Сбрасываем значения введенных полей
            $('#addStudentForm')[0].reset();

            // Обновляем список студентов (вызовите вашу функцию showStudents)
            showStudents();
          },
          error: function (xhr, status, error) {
            console.error("Error: " + error);
          }
        });
      }

    });

    function showStudents() {
      // Выполняем AJAX-запрос к серверу с использованием jQuery
      $.get("showStudents", function (data) {
        // Вставляем данные в таблицу или другой элемент на странице
        var table = "<table class='table'>" +
                "<tr>" +
                "<th>ID</th>\n" +
                "<th>Фамилия</th>\n" +
                "<th>Имя</th>\n" +
                "<th>Отчество</th>\n" +
                "<th>Курс</th>\n" +
                "<th>Факультет</th>\n" +
                "<th>Форма обучения</th>\n" +
                "<th>Стипендия</th>\n" +
                "<th>Номер приказа</th>\n" +
                "<th>Дата приказа</th>\n" +
                "<th>Дата окончания выдачи по каждому из приказов</th>\n" +
                "<th>Окончание срока основания</th>\n" +
                "<th>Основаниe</th>\n" +
                "</tr>";

        for (var i = 0; i < data.length; i++) {
          table += "<tr>" +
                  "<td>" + data[i].id + "</td>\n" +
                  "<td>" + data[i].lastName + "</td>\n" +
                  "<td>" + data[i].firstName + "</td>\n" +
                  "<td>" + data[i].middleName + "</td>\n" +
                  "<td>" + data[i].course + "</td>\n" +
                  "<td>" + data[i].faculty + "</td>\n" +
                  "<td>" + data[i].studyForm + "</td>\n" +
                  "<td>" + data[i].scholarship + "</td>\n" +
                  "<td>" + data[i].orderNumber + "</td>\n" +
                  "<td>" + data[i].orderDate + "</td>\n" +
                  "<td>" + data[i].issuanceEndDate + "</td>\n" +
                  "<td>" + data[i].foundationEndDate + "</td>\n" +
                  "<td>" + data[i].foundationReason + "</td>\n" +
                  "<td>" +
                  "    <button onclick='editStudent(" + data[i].id + ")'>Изменить</button>" +
                  "</td>" +
                  "<td>" +
                  "    <button onclick='deleteStudent(" + data[i].id + ")'>Удалить</button>" +
                  "</td>" +
                  "</tr>";
        }

        table += "</table>";

        // Вставляем таблицу в элемент с id "output" на странице
        $("#output").html(table);
      });
    }

    function searchStudents() {
      var searchQuery = document.getElementById("searchQuery").value;
      var filter = document.getElementById("filter").value;
      var sortColumn = document.getElementById("sortColumn").value;
      var sortDirection = document.getElementById("sortDirection").value;

      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          document.getElementById("output").innerHTML = xhr.responseText;
        }
      };

      var url = "?action=searchStudents&searchQuery=" + encodeURIComponent(searchQuery) +
              "&filter=" + encodeURIComponent(filter) +
              "&sortColumn=" + encodeURIComponent(sortColumn) +
              "&sortDirection=" + encodeURIComponent(sortDirection);

      xhr.open("POST", url, true);
      xhr.send();
    }

    function handleFilterChange() {
      // Perform any necessary actions when the filter changes
      searchStudents();
    }

    function handleSortColumnChange() {
      // Perform any necessary actions when the sortColumn changes
      searchStudents();
    }

    function handleSortDirectionChange() {
      // Perform any necessary actions when the sortDirection changes
      searchStudents();
    }

    function editStudent(studentId) {
      // Реализуйте логику для редактирования студента с использованием studentId
      // Например, можно отправить запрос на сервер для получения данных студента и открыть форму редактирования
      alert("Изменить студента с ID " + studentId);
    }

    function deleteStudent(studentId) {
      // Реализуйте логику для удаления студента с использованием studentId
      // Например, можно отправить запрос на сервер для удаления записи из базы данных
      alert("Удалить студента с ID " + studentId);
    }
  </script>

</head>
<body>
<%
  // Обработка данных при отправке формы
  if (request.getParameter("action") != null) {
    if (request.getParameter("action").equals("searchStudents")) {
      PrintWriter writer = response.getWriter();
      try {
        String url = "jdbc:mysql://localhost:3306/students";
        String username = "root";
        String password = "root";

        Class.forName("com.mysql.jdbc.Driver").getDeclaredConstructor().newInstance();

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
          Statement statement = conn.createStatement();

          String searchQuery = request.getParameter("searchQuery");
          String filter = request.getParameter("filter");
          String sortColumn = request.getParameter("sortColumn");
          String sortDirection = request.getParameter("sortDirection");

          // Переменная для хранения SQL-запроса
          String sqlQuery;
          if ("social".equals(filter)) {
            sqlQuery = "SELECT * FROM students_univ WHERE scholarship = 'Социальная'";
          } else if ("high".equals(filter)) {
            sqlQuery = "SELECT * FROM students_univ WHERE scholarship = 'В повышенном размере' ";
          } else {
            // Default case: no filter selected, get all data
            sqlQuery = "SELECT * FROM students_univ " +
                    "WHERE firstName LIKE '%" + searchQuery + "%' OR " +
                    "lastName LIKE '%" + searchQuery + "%' OR " +
                    "middleName LIKE '%" + searchQuery + "%'";
          }

          // Add sorting to the SQL query
          if (sortColumn != null && sortDirection != null) {
            sqlQuery += " ORDER BY " + sortColumn + " " + sortDirection;
          }
          ResultSet resultSet = statement.executeQuery(sqlQuery);

          writer.println("<table class='table'>\n" +
                  "  <tr>\n" +
                  "    <th>ID</th>\n" +
                  "    <th>Фамилия</th>\n" +
                  "     <th>Имя</th>\n" +
                  "     <th>Отчество</th>\n" +
                  "     <th>Курс</th>\n" +
                  "     <th>Факультет</th>\n" +
                  "     <th>Форма обучения</th>\n" +
                  "     <th>Стипендия</th>\n" +
                  "     <th>Номер приказа</th>\n" +
                  "     <th>Дата приказа</th>\n" +
                  "     <th>Дата окончания выдачи по каждому из приказов</th>\n" +
                  "     <th>Окончание срока основания</th>\n" +
                  "     <th>Основание</th>\n" +
                  "  </tr>\n");

          while(resultSet.next()){
            int id = resultSet.getInt("id");
            String firstName = resultSet.getString("firstName");
            String lastName = resultSet.getString("lastName");
            String middleName = resultSet.getString("middleName");
            int course = resultSet.getInt("course");
            String faculty = resultSet.getString("faculty");
            String studyForm = resultSet.getString("studyForm");
            String scholarship = resultSet.getString("scholarship");
            int orderNumber = resultSet.getInt("orderNumber");
            String orderDate = resultSet.getString("orderDate");
            String issuanceEndDate = resultSet.getString("issuanceEndDate");
            String foundationEndDate = resultSet.getString("foundationEndDate");
            String foundationReason = resultSet.getString("foundationReason");

            writer.println("  <tr>\n" +
                    "    <td>" + id + " </td>\n" +
                    "    <td> " + lastName + " </td>" +
                    "<td> "+ firstName +" </td>" +
                    "<td> "+ middleName +" </td>" +
                    "<td> "+ course +" </td>" +
                    "<td> "+ faculty +" </td>" +
                    "<td> "+ studyForm +" </td>" +
                    "<td> "+ scholarship +" </td>" +
                    "<td> "+ orderNumber +" </td>" +
                    "<td> "+ orderDate +" </td>" +
                    "<td> "+ issuanceEndDate +" </td>" +
                    "<td> "+ foundationEndDate +" </td>" +
                    "<td> "+ foundationReason +" </td>" +
                    "<td>" +
                    "    <button onclick='editStudent(" + id + ")'>Изменить</button>" +
                    "</td>" +
                    "<td>" +
                    "    <button onclick='deleteStudent(" + id + ")'>Удалить</button>" +
                    "</td>" +
                    "</tr>\n");
          }
          writer.println("</table>");
        }


      } catch (Exception ex) {
        writer.println("Connection failed...");
        writer.println(ex);
      } finally {
        writer.close();
      }
    }
  }
%>

<h2>Добавить студента</h2>
<form id="addStudentForm" method="post" action="?action=addStudent">
  Имя: <input type="text" name="firstName" required><br>
  Фамилия: <input type="text" name="lastName" required><br>
  Отчество: <input type="text" name="middleName"><br>
  Курс: <input type="number" name="course" required><br>
  Факультет:
  <select name="faculty">
    <!-- Здесь добавьте опции для всех факультетов -->
    <option value="Биологический">Биологический</option>
    <option value="Востоковедения">Востоковедения</option>
    <option value="Физкультурный">Физкультурный</option>
    <option value="Социальный">Социальный</option>
    <option value="Исторический">Исторический</option>
    <option value="ФИЯ">ФИЯ</option>
    <option value="ФИиИТ">ФИиИТ</option>
    <option value="Культуры">Культуры</option>
    <option value="Математический">Математический</option>
    <option value="Психологии и философии">Психологии и философии</option>
    <option value="Физический">Физический</option>
    <option value="Филологический">Филологический</option>
    <option value="Химический">Химический</option>
    <option value="Экологии">Экологии</option>
    <option value="Экономики">Экономики</option>
    <option value="Юридический">Юридический</option>
    <!-- Добавьте остальные опции -->
  </select><br>
  Форма обучения:
  <input type="radio" name="studyForm" value="Бакалавриат" required> Бакалавриат
  <input type="radio" name="studyForm" value="Магистратура" required> Магистратура<br>
  Стипендия:
  <input type="radio" name="scholarship" value="Социальная"> Социальная
  <input type="radio" name="scholarship" value="В повышенном размере"> В повышенном размере<br>
  Номер приказа: <input type="number" name="orderNumber" required><br>
  Дата приказа: <input type="date" name="orderDate" required><br>
  Дата окончания выдачи: <input type="date" name="issuanceEndDate" required><br>
  Окончание срока основания: <input type="date" name="foundationEndDate" required><br>
  Основание:
  <select name="foundationReason">
    <option value="УСЗН">УСЗН</option>
    <option value="Инвалидность">Инвалидность</option>
    <option value="Постановление">Постановление</option>
  </select><br>
  <input type="submit" value="Добавить студента">
</form>

<hr>

<h2>Получить информацию из БД</h2>
<button onclick="showStudents()">Получить информацию</button>

<!-- Form for searching students with filter and sort -->
<form method="get" onsubmit="event.preventDefault(); searchStudents();">
  <label for="searchQuery">Поиск: </label>
  <input type="text" id="searchQuery" name="searchQuery" placeholder="Поиск по ФИО">

  <!-- Filter dropdown for selecting specific data -->
  <label for="filter">Фильтр: </label>
  <select id="filter" name="filter" onchange="handleFilterChange()">
    <option value="all">Все данные</option>
    <option value="social">Социальная стипендия</option>
    <option value="high">Студенты с повышенной стипендией</option>
    <!-- Add more filter options based on your requirements -->
  </select>

  <!-- Sort dropdown for selecting sorting column and direction -->
  <label for="sortColumn">Сортировать по: </label>
  <select id="sortColumn" name="sortColumn" onchange="handleSortColumnChange()">
    <option value="id">ID</option>
    <option value="firstName">Имени</option>
    <option value="lastName">Фамилии</option>
    <option value="course">Курсу</option>
    <option value="middleName">Отчеству</option>
    <option value="faculty">Факультету</option>
    <option value="studyForm">Форме обучения</option>
    <option value="scholarship">Стипендии</option>
    <option value="orderNumber">Номеру приказа</option>
    <option value="orderDate">Дата приказа</option>
    <option value="issuanceEndDate">Дата окончания выдачи по каждому из приказов</option>
    <option value="foundationEndDate">Окончание срока основания</option>
    <option value="foundationReason">Основание</option>

    <!-- Add more columns based on your database structure -->
  </select>

  <label for="sortDirection">Направление сортировки: </label>
  <select id="sortDirection" name="sortDirection" onchange="handleSortDirectionChange()">
    <option value="asc">По возрастанию</option>
    <option value="desc">По убыванию</option>
  </select>

  <input type="submit" value="Искать">
</form>


<!-- Вывод информации -->
<div id="output"></div>

</body>
</html>
 