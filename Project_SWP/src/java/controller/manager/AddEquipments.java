package controller.manager;

import Model.Equipments;
import DAO.EquipmentsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

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
            List<Equipments> equipments = EquipmentsDAO.getAllEquipments();
            request.setAttribute("equipments", equipments);
            request.setAttribute("status", "duplicate");
            request.getRequestDispatcher("EquipmentsView.jsp").forward(request, response);
            return;
        }

        Equipments s = new Equipments(0, name, price, 0);
        try {
            EquipmentsDAO.addService(s);

            // Load lại danh sách thiết bị
            List<Equipments> equipments = EquipmentsDAO.getAllEquipments();
            request.setAttribute("equipments", equipments);
            request.setAttribute("status", "success");

            request.getRequestDispatcher("EquipmentsView.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();

            List<Equipments> equipments = EquipmentsDAO.getAllEquipments();
            request.setAttribute("equipments", equipments);
            request.setAttribute("status", "fail");

            request.getRequestDispatcher("EquipmentsView.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Add new equipment service";
    }
}
