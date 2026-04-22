package com.clothingshop.styleera.controller;

import com.clothingshop.styleera.service.EmailService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/contact")
public class ContactController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("successOnce") != null) {
            request.setAttribute("success", true);
            session.removeAttribute("successOnce");
        }
        request.getRequestDispatcher("/views/pages/contact.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mess = request.getParameter("message");

        boolean valid = true;
        String nameRegex = "^[a-zA-ZÀ-ỹ\\s]+$";
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("nameError", "Vui lòng nhập tên");
            valid = false;
        } else if (!name.matches(nameRegex)) {
            request.setAttribute("nameError", "Lỗi, Vui lòng nhập tên chỉ được chứa chữ cái!");
            valid = false;
        }

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("emailError", "Vui lòng nhập email");
            valid = false;
        } else if (!email.matches(emailRegex)) {
            request.setAttribute(
                    "emailError",
                    "Email không hợp lệ! Vui lòng nhập đúng định dạng (vd: example@gmail.com)"
            );
            valid = false;
        }

        if (mess == null || mess.trim().length() < 10) {
            request.setAttribute("messageError",
                    "Nội dung tin nhắn phải có ít nhất 10 ký tự!");
            valid = false;
        }

        if (!valid) {
            request.getRequestDispatcher("/contact")
                    .forward(request, response);
            return;
        }

        // Gửi email qua lớp EmailService xử lý
        try {
            String subject = "StyleEra - Liên hệ từ Khách hàng";
            String content = String.format(
                    "<h3>Thông tin liên hệ</h3>"
                            + "<p><b>Tên khách hàng:</b> %s</p>"
                            + "<p><b>Nội dung:</b></p>"
                            + "<p>%s</p>",
                    name, mess
            );

            EmailService.sendEmail(email, subject, content);

            request.getSession().setAttribute("successOnce", true);

            response.sendRedirect(request.getContextPath() + "/contact");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute(
                    "messageError",
                    "Không thể gửi email. Vui lòng thử lại sau!"
            );
            request.getRequestDispatcher("/contact")
                    .forward(request, response);
        }
    }
}