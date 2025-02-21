package controllers.user;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import services.StringEncoder;
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
@WebServlet(name = "UserListController", urlPatterns = {"/user"})
public class UserListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //request.setCharacterEncoding("UTF-8");  // hỗ trọ tiếng việt
        UserDAO userDAO = new UserDAO();
        SettingDAO settingDAO = new SettingDAO();
        List<User> users = userDAO.findAll();
        List<Setting> settings = settingDAO.findAllByRole();


        // Tạo map để lưu roleId và title tương ứng
        Map<Integer, String> roleMap = new HashMap<>();

        for (User user : users) {
            if (!roleMap.containsKey(user.getRoleId())) {
                Setting role = settingDAO.findById(user.getRoleId());
                if (role != null) {
                    roleMap.put(user.getRoleId(), role.getTitle());
                } else {
                    roleMap.put(user.getRoleId(), "Unknown");
                }
            }
        }

        String action = request.getParameter("action");

        if (action == null) {
            request.setAttribute("users", users);
            request.setAttribute("roleMap", roleMap);
            request.setAttribute("settings", settings);
            request.getRequestDispatcher("WEB-INF/Admin/UserManagement/listuser.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        int roleId = Integer.parseInt(request.getParameter("role"));
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        boolean emailExists = userDAO.isEmailExists(email);
        boolean usernameExists = userDAO.isUsernameExists(username);


        // Tạo đối tượng User mới
        User user = new User();
        user.setEmail(email);
        user.setUsername(username);
        user.setFullName(fullname);
        user.setRoleId(roleId);
        user.setStatus(UserStatus.NotVerified); // Mặc định là Active
        user.setCreatedAt(new Date(System.currentTimeMillis())); // Thêm thời gian tạo
        user.setPasswordHash(StringEncoder.encodePassword(password));


        userDAO.create(user);

        request.getSession().setAttribute("message", "User created successfully");
        // Chuyển hướng lại về trang danh sách người dùng
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
