package controller.manager;

import Model.Equipments;
import DAO.EquipmentsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddService", urlPatterns = {"/AddService"})
public class AddEquipments extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));

        // Có thể thêm lấy từ form nếu cần
        String quantity = "Chưa kiểm tra"; // Mặc định nếu không có input từ người dùng

        if (EquipmentsDAO.isDuplicateService(name)) {
            response.sendRedirect("service.jsp?status=duplicate");
            return;
        }

        Equipments s = new Equipments(0, name, price, quantity); 
        try {
            EquipmentsDAO.addService(s);
            response.sendRedirect("service.jsp?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("service.jsp?status=fail");
        }
    }

    @Override
    public String getServletInfo() {
        return "Add new equipment service";
    }
}
