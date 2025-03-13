<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 3/3/2025
  Time: 4:13 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page isELIgnored="false" %>
<html>

<head>
    <title>Class Detail</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.1/font/bootstrap-icons.min.css"
          rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
        }

        .sidebar {
            background-color: #1a1f36;
            min-height: 100vh;
        }

        .sidebar .nav-link {
            color: #8b92a8;
            padding: 0.8rem 1rem;
            margin: 0.2rem 0;
            border-radius: 6px;
        }

        .sidebar .nav-link:hover {
            background-color: #2d3548;
            color: #fff;
        }

        .header-bar {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 15px;
        }

        .header-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        .btn-primary,
        .btn-success,
        .btn-secondary {
            border-radius: 8px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .class-table {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
        }

        .class-table th,
        .class-table td {
            text-align: center;
            padding: 15px;
            border: none;
        }

        .class-table th {
            background-color: #f8f9fa;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .class-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .class-table tr:hover {
            background-color: #eef1f5;
        }

        /* Modal căn chỉnh */
        .modal-dialog {
            max-width: 45vw;
        }

        .modal-content {
            background-color: #2f3b52;
            border-radius: 12px;
            padding: 20px;
        }

        .modal-header {
            background-color: #2f3b52;
            color: white;
            border-bottom: none;
            padding: 15px;
            border-radius: 12px 12px 0 0;
        }

        .modal-header .btn-close {
            background-color: white;
            border-radius: 100%;
        }

        .modal-body {
            background-color: #2f3b52;
            color: #ffffff;
            border-radius: 10px;
        }

        /* Bảng trong modal */
        .modal-body table {
            background-color: transparent;
            color: white;
            width: 100%;
            border-radius: 8px;
        }

        .modal-body th {
            background-color: #324968;
            color: #ffffff;
            padding: 12px;
            border-radius: 5px;
        }

        /* Căn chỉnh bảng */
        .modal-body td {
            padding: 12px;
            vertical-align: middle;
            text-align: center;
        }

        /* Căn giữa các nút */
        .modal-body .d-flex {
            justify-content: center;
            gap: 10px;
        }

        .modal-body .btn-success,
        .modal-body .btn-danger {
            padding: 6px 12px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 6px;
            transition: all 0.3s ease-in-out;
        }

        .modal-body .btn-success:hover {
            background-color: #28a745;
            transform: scale(1.05);
        }

        .modal-body .btn-danger:hover {
            background-color: #dc3545;
            transform: scale(1.05);
        }

        .popup {
            background-color: #3e4a67;
            color: white;
            border: 1px solid #4d5b75;
            border-radius: 8px;
            padding: 0.8rem;
        }

        .popup:focus {
            background-color: #4a5b72;
            border-color: #007bff;
            color: white;
        }

        .student-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid #ddd;
            display: block;
            margin: auto;
        }
    </style>
</head>

<body>
<%
    String message = (String) session.getAttribute("message");
    session.removeAttribute("message");
%>
<%--    Dòng hiện thị thông báo--%>
<div id="toastMessage" class="toast align-items-center text-white bg-success border-0 position-fixed top-0 end-0"
     role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
        <div class="toast-body text-center">
            <%= message != null ? message : "" %>
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                aria-label="Close"></button>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-auto px-0 sidebar d-none d-md-block">
            <div class="d-flex flex-column p-3">
                <h5 class="text-white mb-4">AdminKit</h5>
                <nav class="nav flex-column">
                    <a class="nav-link" href="/home"><i class="bi bi-house"></i> Home</a>
                    <a class="nav-link" href="/class_teacher"><i class="bi bi-people me-2"></i> Class</a>
                </nav>
            </div>
        </div>
        <div class="col p-0">
            <div class="header-bar d-flex justify-content-between align-items-center px-4">
                <div class="d-flex align-items-center gap-3">
                    <div class="header-title">Class Detail</div>
                </div>
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-warning shadow-sm" data-bs-toggle="modal"
                            data-bs-target="#approveStudentModal">
                        <i class="bi bi-check-circle"></i> Approve
                    </button>
                    <a href="class_management/export" id="exportBtn" class="btn btn-success">
                        <i class="bi bi-download"></i> Export
                    </a>
                    <button type="button" class="btn btn-secondary shadow-sm" data-bs-toggle="modal"
                            data-bs-target="#importStudentModal">
                        <i class="bi bi-upload"></i> Import
                    </button>
                    <button type="button" class="btn btn-primary shadow-sm" data-bs-toggle="modal"
                            data-bs-target="#newStudentModal">
                        <i class="bi bi-plus-circle"></i> Add Student
                    </button>

                </div>
            </div>
            <div class="card border-0 m-4">
                <div class="card-body">
                    <h5 class="card-title">Student List</h5>
                    <table class="table class-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Avatar</th>
                            <th>Name</th>
                            <th>Email</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="student" items="${approvedStudents}">
                            <tr>
                                <td>${student.id}</td>
                                <td>
                                    <img src="${student.avatar != null ? student.avatar : 'https://chiemtaimobile.vn/images/companies/1/%E1%BA%A2nh%20Blog/avatar-facebook-dep/Anh-avatar-hoat-hinh-de-thuong-xinh-xan.jpg?1704788263223'}"
                                         alt="Avatar" class="student-img">
                                </td>
                                <td>${student.fullName}</td>
                                <td>${student.email}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Approve Student Modal -->
<!-- Approve Student Modal -->
<div class="modal fade" id="approveStudentModal" tabindex="-1"
     aria-labelledby="approveStudentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Approve Student Registrations</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table text-center">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="student" items="${pendingStudents}">
                        <tr id="studentRow-${student.id}">
                            <td>${student.fullName}</td>
                            <td>${student.email}</td>
                            <td class="d-flex justify-content-center">
                                <button class="btn btn-success me-2"
                                        onclick="updateStudentStatus(${student.id}, ${oldClassId}, 'approve')">
                                    Approve
                                </button>
                                <button class="btn btn-danger"
                                        onclick="updateStudentStatus(${student.id}, ${oldClassId}, 'reject')">
                                    Reject
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Student Modal -->
<div class="modal fade" id="newStudentModal" tabindex="-1" aria-labelledby="newStudentModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="newStudentModalLabel">Add Student</h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="class_student_detail" method="post">
                    <input type="hidden" name="classId" value="${oldClassId}">
                    <input type="hidden" name="action" value="addStudent">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control popup" id="email" name="email" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 py-2 rounded-3 shadow-sm mt-3">
                        Add
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Import Student Modal -->
<div class="modal fade" id="importStudentModal" tabindex="-1" aria-labelledby="importStudentModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="importStudentModalLabel">Import Students</h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="importForm" action="class_student_detail" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="classId" value="${oldClassId}">
                    <input type="hidden" name="action" value="importStudents">

                    <div class="mb-3">
                        <label for="excelFile" class="form-label">Upload Excel File</label>
                        <input type="file" class="form-control" id="excelFile" name="file" accept=".xls,.xlsx" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 rounded-3 shadow-sm mt-3"
                            onclick="document.getElementById('importForm').action = 'class_student_detail?action=importStudents&classId=${oldClassId}';">
                        Import
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
</body>
<script>
    function updateStudentStatus(studentId, classId, action) {
        $.ajax({
            url: "/approve_reject_student",
            type: "POST",
            data: {studentId: studentId, classId: classId, action: action},
            success: function (response) {
                if (response.success) {
                    if (action === 'approve') {
                        alert("Student approved successfully!");
                    } else {
                        alert("Student rejected successfully!");
                    }
                    $("#studentRow-" + studentId).fadeOut(); // Ẩn dòng sinh viên đã xử lý
                } else {
                    alert("Failed to process request.");
                }
            },
            error: function () {
                alert("Error processing request.");
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        let toastElement = document.getElementById("toastMessage");
        if (toastElement.innerText.trim() !== "") {
            let toast = new bootstrap.Toast(toastElement, {delay: 1500});
            toast.show();
        }
    });
</script>
</html>