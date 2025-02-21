package controllers.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Setting;
import models.User;
import models.UserStatus;
import models.dao.SettingDAO;
import models.dao.UserDAO;

/**
 * @author Admin
 */
@WebServlet(name = "UserFilterController", urlPatterns = {"/user/search"})
public class UserFilterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String contentSearch = request.getParameter("search_fullname");
        String roleFilter = request.getParameter("roleFilter");
        UserDAO userDAO = new UserDAO();
        SettingDAO settingDAO = new SettingDAO();

        List<User> list = userDAO.searchUsers(contentSearch, roleFilter != null && !roleFilter.isEmpty() ? Integer.parseInt(roleFilter) : null);

        Map<Integer, String> roleMap = new HashMap<>();

        for (User user : list) {
            if (!roleMap.containsKey(user.getRoleId())) {
                Setting role = settingDAO.findById(user.getRoleId());
                if (role != null) {
                    roleMap.put(user.getRoleId(), role.getTitle());
                } else {
                    roleMap.put(user.getRoleId(), "Unknown");
                }
            }
        }

        PrintWriter out = response.getWriter();

        for (User o : list) {
            String statusClass = "warning"; // Mặc định là NotVerified
            if (o.getStatus() != null) {
                UserStatus status = o.getStatus();
                if (status == UserStatus.Active) {
                    statusClass = "success";
                } else if (status == UserStatus.Deactivated) {
                    statusClass = "danger";
                }
            }
            out.println("<tr>\n" +
                    "                            <td>" + o.getId() + "</td>\n" +
                    "                            <td>" + o.getFullName() + "</td>\n" +
                    "                            <td>" + o.getUsername() + "</td>\n" +
                    "                            <td>" + o.getEmail() + "</td>\n" +
                    "                            <td>" + roleMap.get(o.getRoleId()) + "</td>\n" +
                    "                            <td><span class='badge bg-" + statusClass + "'>" + o.getStatus() + "</span></td>\n" +
                    "                            <td>\n" +
                    "                                <a href=\"user_update?id="+o.getId()+"\" class=\"btn btn-sm btn-outline-secondary\">\n" +
                    "                                    <i class=\"bi bi-three-dots-vertical\"></i>\n" +
                    "                                </a>\n" +
                    "                            </td>\n" +
                    "                        </tr>");
        }


    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
