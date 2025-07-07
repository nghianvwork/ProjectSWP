<%-- 
    Document   : coach_list
    Created on : Jul 7, 2025, 2:26:05 PM
    Author     : sang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Model.Coach, Model.AreaCoach" %>
<%
    List<Coach> coaches = (List<Coach>)request.getAttribute("coaches");
    List<AreaCoach> areas = (List<AreaCoach>)request.getAttribute("areas");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý Huấn luyện viên</title>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #667eea;
                --secondary-color: #764ba2;
                --success-color: #48bb78;
                --danger-color: #f56565;
                --warning-color: #ed8936;
                --info-color: #4299e1;
                --light-bg: #f8fafc;
                --dark-text: #2d3748;
                --border-color: #e2e8f0;
                --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            }

            body {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .with-sidebar {
                margin-left: 280px;
                padding: 15px;
                background: var(--light-bg);
                min-height: 100vh;
                border-radius: 15px 0 0 15px;
                box-shadow: var(--shadow-lg);
            }

            .page-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 20px;
                border-radius: 15px;
                margin-bottom: 20px;
                box-shadow: var(--shadow);
            }

            .page-header h2 {
                margin: 0;
                font-weight: 700;
                font-size: 1.8rem;
            }

            .page-header p {
                margin: 5px 0 0 0;
                opacity: 0.9;
                font-size: 0.9rem;
            }

            .stats-card {
                background: white;
                border-radius: 12px;
                padding: 15px;
                margin-bottom: 20px;
                box-shadow: var(--shadow);
                border: 1px solid var(--border-color);
            }

            .stats-row {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }

            .stat-item {
                flex: 1;
                text-align: center;
                padding: 15px;
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                color: white;
                border-radius: 10px;
                box-shadow: var(--shadow);
            }

            .stat-number {
                font-size: 1.8rem;
                font-weight: 700;
                margin-bottom: 3px;
            }

            .stat-label {
                font-size: 0.8rem;
                opacity: 0.9;
            }

            .action-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                padding: 15px;
                background: white;
                border-radius: 12px;
                box-shadow: var(--shadow);
            }

            .search-box {
                position: relative;
                flex-grow: 1;
                max-width: 400px;
                margin-right: 20px;
            }

            .search-box input {
                padding: 8px 35px 8px 12px;
                border: 2px solid var(--border-color);
                border-radius: 20px;
                font-size: 13px;
                width: 100%;
                transition: all 0.3s ease;
            }

            .search-box input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .search-box i {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                color: #9ca3af;
            }

            .btn-modern {
                padding: 8px 18px;
                border-radius: 20px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.3px;
                transition: all 0.3s ease;
                border: none;
                box-shadow: var(--shadow);
                font-size: 13px;
            }

            .btn-modern:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-lg);
            }

            .btn-add {
                background: linear-gradient(135deg, var(--success-color), #38a169);
                color: white;
            }

            .table-container {
                background: white;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: var(--shadow);
                border: 1px solid var(--border-color);
            }

            .table {
                margin: 0;
                border-collapse: separate;
                border-spacing: 0;
            }

            .table thead th {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                padding: 20px 15px;
                border: none;
                font-size: 0.85rem;
            }

            .table tbody tr {
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background: rgba(102, 126, 234, 0.05);
                transform: scale(1.01);
            }

            .table tbody td {
                padding: 20px 15px;
                border-bottom: 1px solid var(--border-color);
                vertical-align: middle;
            }

            .coach-avatar {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid white;
                box-shadow: var(--shadow);
            }

            .status-badge {
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-active {
                background: linear-gradient(135deg, var(--success-color), #38a169);
                color: white;
            }

            .status-inactive {
                background: linear-gradient(135deg, #cbd5e0, #a0aec0);
                color: white;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
            }

            .btn-action {
                padding: 8px 12px;
                border-radius: 8px;
                border: none;
                font-size: 0.8rem;
                font-weight: 600;
                transition: all 0.3s ease;
                min-width: 70px;
            }

            .btn-edit {
                background: linear-gradient(135deg, var(--info-color), #3182ce);
                color: white;
            }

            .btn-delete {
                background: linear-gradient(135deg, var(--danger-color), #e53e3e);
                color: white;
            }

            .btn-action:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow);
            }

            .modal-content {
                border-radius: 20px;
                border: none;
                box-shadow: var(--shadow-lg);
            }

            .modal-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                border-radius: 20px 20px 0 0;
                padding: 25px;
            }

            .modal-title {
                font-weight: 700;
                font-size: 1.5rem;
            }

            .modal-body {
                padding: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-label {
                font-weight: 600;
                color: var(--dark-text);
                margin-bottom: 8px;
                display: block;
            }

            .form-control {
                border: 2px solid var(--border-color);
                border-radius: 12px;
                padding: 12px 15px;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .modal-footer {
                padding: 25px;
                border-top: 1px solid var(--border-color);
                background: var(--light-bg);
                border-radius: 0 0 20px 20px;
            }

            .coach-card {
                background: white;
                border-radius: 15px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: var(--shadow);
                border: 1px solid var(--border-color);
                transition: all 0.3s ease;
            }

            .coach-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-lg);
            }

            .specialty-tag {
                background: linear-gradient(135deg, #ffecd2, #fcb69f);
                color: var(--dark-text);
                padding: 4px 12px;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: 600;
                display: inline-block;
            }

            @media (max-width: 768px) {
                .with-sidebar {
                    margin-left: 0;
                    border-radius: 0;
                }
                
                .stats-row {
                    flex-direction: column;
                }
                
                .action-bar {
                    flex-direction: column;
                    gap: 15px;
                }
                
                .search-box {
                    max-width: 100%;
                    margin-right: 0;
                }
                
                .table-container {
                    overflow-x: auto;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="Sidebar.jsp"/>
        <div class="main-content with-sidebar">
            <!-- Page Header -->
            <div class="page-header">
                <h2><i class="fas fa-users-cog me-3"></i>Quản lý Huấn luyện viên</h2>
                <p>Quản lý thông tin và hoạt động của các huấn luyện viên</p>
            </div>

            <!-- Stats Cards -->
            <div class="stats-row">
                <div class="stat-item">
                    <div class="stat-number"><%=coaches.size()%></div>
                    <div class="stat-label">Tổng HLV</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=coaches.stream().mapToInt(c -> "active".equals(c.getStatus()) ? 1 : 0).sum()%></div>
                    <div class="stat-label">Đang hoạt động</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=areas.size()%></div>
                    <div class="stat-label">Khu vực</div>
                </div>
            </div>

            <!-- Action Bar -->
            <div class="action-bar">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Tìm kiếm huấn luyện viên..." onkeyup="searchCoaches()">
                    <i class="fas fa-search"></i>
                </div>
                <button class="btn btn-modern btn-add" data-bs-toggle="modal" data-bs-target="#addCoachModal">
                    <i class="fas fa-plus me-2"></i>Thêm huấn luyện viên
                </button>
            </div>

            <!-- Table -->
            <div class="table-container">
                <table class="table" id="coachTable">
                    <thead>
                        <tr>
                            <th><i class="fas fa-hashtag me-2"></i>ID</th>
                            <th><i class="fas fa-map-marker-alt me-2"></i>Khu vực</th>
                            <th><i class="fas fa-user me-2"></i>Họ tên</th>
                            <th><i class="fas fa-image me-2"></i>Ảnh</th>
                            <th><i class="fas fa-envelope me-2"></i>Email</th>
                            <th><i class="fas fa-phone me-2"></i>Điện thoại</th>
                            <th><i class="fas fa-star me-2"></i>Chuyên môn</th>
                            <th><i class="fas fa-info-circle me-2"></i>Mô tả</th>
                            <th><i class="fas fa-toggle-on me-2"></i>Trạng thái</th>
                            <th><i class="fas fa-cogs me-2"></i>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Coach c : coaches) { %>
                        <tr>
                            <td><strong>#<%=c.getCoachId()%></strong></td>
                            <td>
                                <% for (AreaCoach a : areas) {
                                    if (a.getAreaId() == c.getAreaId()) { %>
                                        <span class="specialty-tag"><%=a.getName()%></span>
                                    <% break; }
                                } %>
                            </td>
                            <td><strong><%=c.getFullname()%></strong></td>
                            <td>
                                <% if (c.getImageUrl() != null && !c.getImageUrl().trim().isEmpty()) { %>
                                <img src="<%=c.getImageUrl()%>" class="coach-avatar" alt="Avatar"/>
                                <% } else { %>
                                <div class="coach-avatar d-flex align-items-center justify-content-center" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; font-weight: bold;">
                                    <%=c.getFullname().substring(0, 1).toUpperCase()%>
                                </div>
                                <% } %>
                            </td>
                            <td><%=c.getEmail()%></td>
                            <td><%=c.getPhone()%></td>
                            <td><span class="specialty-tag"><%=c.getSpecialty()%></span></td>
                            <td>
                                <% if (c.getDescription() != null && c.getDescription().length() > 50) { %>
                                <span title="<%=c.getDescription()%>"><%=c.getDescription().substring(0, 50)%>...</span>
                                <% } else { %>
                                <%=c.getDescription()%>
                                <% } %>
                            </td>
                            <td>
                                <span class="status-badge status-<%=c.getStatus()%>">
                                    <%="active".equals(c.getStatus()) ? "Hoạt động" : "Ẩn"%>
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button type="button" class="btn btn-action btn-edit" 
                                            data-bs-toggle="modal" data-bs-target="#editCoachModal"
                                            onclick="fillEditForm('<%=c.getCoachId()%>', '<%=c.getAreaId()%>',
                                                        '<%=c.getFullname()%>', '<%=c.getEmail()%>',
                                                        '<%=c.getPhone()%>', '<%=c.getSpecialty()%>',
                                                        '<%=c.getImageUrl()%>', `<%=c.getDescription()%>`,
                                                        '<%=c.getStatus()%>')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form action="CoachDelete" method="get" style="display:inline;" 
                                          onsubmit="return confirm('Bạn có chắc chắn muốn xóa huấn luyện viên này?');">
                                        <input type="hidden" name="coach_id" value="<%=c.getCoachId()%>"/>
                                        <button class="btn btn-action btn-delete" type="submit">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Modal: Add Coach -->
            <div class="modal fade" id="addCoachModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fas fa-plus-circle me-2"></i>Thêm huấn luyện viên mới</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="CoachAdd" method="post" enctype="multipart/form-data">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Khu vực</label>
                                            <select name="area_id" class="form-control" required>
                                                <option value="">Chọn khu vực</option>
                                                <% for (AreaCoach a : areas) { %>
                                                <option value="<%=a.getAreaId()%>"><%=a.getName()%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Họ tên</label>
                                            <input type="text" name="fullname" class="form-control" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Email</label>
                                            <input type="email" name="email" class="form-control" required/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Điện thoại</label>
                                            <input type="text" name="phone" class="form-control" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Chuyên môn</label>
                                            <input type="text" name="specialty" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Ảnh đại diện</label>
                                            <input type="file" name="image_file" class="form-control" accept="image/*" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Mô tả</label>
                                    <textarea name="description" class="form-control" rows="4" placeholder="Nhập mô tả về huấn luyện viên..."></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-modern btn-add">
                                    <i class="fas fa-save me-2"></i>Thêm mới
                                </button>
                                <button type="button" class="btn btn-modern" style="background: #6c757d; color: white;" data-bs-dismiss="modal">
                                    <i class="fas fa-times me-2"></i>Đóng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Modal: Edit Coach -->
            <div class="modal fade" id="editCoachModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fas fa-edit me-2"></i>Cập nhật huấn luyện viên</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="CoachEdit" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="coach_id" id="edit_coach_id"/>
                            <input type="hidden" name="old_image_url" id="edit_old_image_url"/>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Khu vực</label>
                                            <select name="area_id" id="edit_area_id" class="form-control" required>
                                                <% for (AreaCoach a : areas) { %>
                                                <option value="<%=a.getAreaId()%>"><%=a.getName()%></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Họ tên</label>
                                            <input type="text" name="fullname" id="edit_fullname" class="form-control" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Email</label>
                                            <input type="email" name="email" id="edit_email" class="form-control" required/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Điện thoại</label>
                                            <input type="text" name="phone" id="edit_phone" class="form-control" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Chuyên môn</label>
                                            <input type="text" name="specialty" id="edit_specialty" class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Trạng thái</label>
                                            <select name="status" id="edit_status" class="form-control">
                                                <option value="active">Hoạt động</option>
                                                <option value="inactive">Ẩn</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Ảnh đại diện (chọn file mới nếu muốn thay đổi)</label>
                                    <input type="file" name="image_file" class="form-control" accept="image/*"/>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Mô tả</label>
                                    <textarea name="description" id="edit_description" class="form-control" rows="4"></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-modern" style="background: var(--info-color); color: white;">
                                    <i class="fas fa-save me-2"></i>Cập nhật
                                </button>
                                <button type="button" class="btn btn-modern" style="background: #6c757d; color: white;" data-bs-dismiss="modal">
                                    <i class="fas fa-times me-2"></i>Đóng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function fillEditForm(id, areaId, fullname, email, phone, specialty, imageUrl, description, status) {
                document.getElementById('edit_coach_id').value = id;
                document.getElementById('edit_area_id').value = areaId;
                document.getElementById('edit_fullname').value = fullname;
                document.getElementById('edit_email').value = email;
                document.getElementById('edit_phone').value = phone;
                document.getElementById('edit_specialty').value = specialty;
                document.getElementById('edit_old_image_url').value = imageUrl;
                document.getElementById('edit_description').value = description;
                document.getElementById('edit_status').value = status;
            }

            function searchCoaches() {
                const input = document.getElementById('searchInput');
                const filter = input.value.toUpperCase();
                const table = document.getElementById('coachTable');
                const rows = table.getElementsByTagName('tr');

                for (let i = 1; i < rows.length; i++) {
                    const row = rows[i];
                    const cells = row.getElementsByTagName('td');
                    let found = false;

                    for (let j = 0; j < cells.length; j++) {
                        const cell = cells[j];
                        if (cell) {
                            const text = cell.textContent || cell.innerText;
                            if (text.toUpperCase().indexOf(filter) > -1) {
                                found = true;
                                break;
                            }
                        }
                    }

                    if (found) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                }
            }

            // Add some interactive effects
            document.addEventListener('DOMContentLoaded', function() {
                // Animate cards on load
                const cards = document.querySelectorAll('.coach-card, .stats-card, .table-container');
                cards.forEach((card, index) => {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(20px)';
                    setTimeout(() => {
                        card.style.transition = 'all 0.6s ease';
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, index * 100);
                });

                // Add hover effects to buttons
                const buttons = document.querySelectorAll('.btn-modern');
                buttons.forEach(button => {
                    button.addEventListener('mouseenter', function() {
                        this.style.transform = 'translateY(-2px)';
                    });
                    button.addEventListener('mouseleave', function() {
                        this.style.transform = 'translateY(0)';
                    });
                });
            });
        </script>       
    </body>
</html>