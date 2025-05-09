package controllers.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Setting;
import models.SettingType;
import models.User;
import models.dao.SettingDAO;
import models.dao.UserDAO;
import services.dataaccess.SettingService;
import services.dataaccess.UserService;

/**
 * @author Admin
 */
@WebServlet(name = "UserUpdateController", urlPatterns = {"/user_update"})
public class UserUpdateController extends HttpServlet {
    private final UserService userService = new UserService();
    private final SettingService settingService = new SettingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        // Lấy thông tin User cần cập nhật
        User oldUser = userService.findById(Integer.parseInt(id));

        // Lấy danh sách Role từ Setting
        List<Setting> settings = settingService.findAllByType(SettingType.Role);

        request.setAttribute("oldUser", oldUser);
        request.setAttribute("settings", settings); // Truyền danh sách Role sang JSP
        request.getRequestDispatcher("WEB-INF/Admin/UserManagement/userUpdate.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        int roleId = Integer.parseInt(request.getParameter("role"));

        // Tạo đối tượng User và set dữ liệu
        User user = new User();
        user.setId(id);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setRoleId(roleId);
        user.setModifiedAt(new java.util.Date(System.currentTimeMillis()));

        // Cập nhật thông tin người dùng
        userService.update(user);

        request.getSession().setAttribute("message", "User updated successfully");
        response.sendRedirect("user");
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
