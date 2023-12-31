package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

            // Fetch all new data from edit form
            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");
            Part part = request.getPart("image");
            String newFileName = part.getSubmittedFileName();

            // Get user from session & update user object present in session
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldFileName = user.getProfile(); // it will be used while deleting file

            System.out.println("old file name " + oldFileName);
            System.out.println("new file name " + newFileName);
            System.out.println("new file name is empty " + newFileName.isEmpty());

            if (newFileName.equals("")) {
                // if file not given then use default image
                user.setProfile(oldFileName);
            } else {

                // Get new file path
                String newPath = request.getSession().getServletContext().getRealPath("/") + "pics" + File.separator + newFileName;

                // delete old file
                String oldFilePath = request.getSession().getServletContext().getRealPath("/") + "pics" + File.separator + oldFileName;
                Helper.deleteFile(oldFilePath);

                Helper.saveFile(part.getInputStream(), newPath);

                // if file given then update image
                user.setProfile(newFileName);

                System.out.println("old path " + oldFilePath);
                System.out.println("new path " + newPath);

            }

            // Update Database
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());

            if (userDao.updateUser(user)) {
                out.println("Updated to database");
                out.println("Profile Updated...");
                Message msg = new Message("Profile Updated...", "success", "alert-success");
                s.setAttribute("msg", msg);

            } else {
                out.println("Profile Not Updated...");
                Message msg = new Message("Something went wrong... Not updated to database", "error", "alert-danger");
                s.setAttribute("msg", msg);
            }

            response.sendRedirect("profile.jsp");

            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
