package controllers;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Subject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", "/getSubjects", "/searchSubjects", "/admin"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        System.out.println(path);

        switch (path) {
            case "/home":
                request.getRequestDispatcher("WEB-INF/Web/index.jsp").forward(request, response);
                break;

            case "/getSubjects":
                getSubjects(request, response);
                break;

            case "/searchSubjects":
                searchSubject(request, response);
                break;

            case "/admin":
                request.getRequestDispatcher("WEB-INF/Admin/homeadmin.jsp").forward(request, response);
                break;

        }
    }

    private void getSubjects(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Mock subject data (replace with database call)
        List<Subject> subjects = WebManager.getInstance().getSubjectDAO().findAll();

        // Convert to JSON
        String json = new Gson().toJson(subjects);

        // Send JSON response
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }

    private void searchSubject(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("query");
        List<Subject> subjects = WebManager.getInstance().getSubjectDAO().searchSubjects(keyword, 5); // Limit to 5 results

        Gson gson = new Gson();
        String json = gson.toJson(subjects);
        response.getWriter().write(json);
    }
}
