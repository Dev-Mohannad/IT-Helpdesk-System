<%@ Page Title="لوحة الإدارة العامة" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="First_Project_MHND_X_Yazan.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        
        <!-- كروت مؤشرات الأداء للإدارة -->
        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="card main-card bg-white p-3 text-center border-bottom border-primary border-3">
                    <span class="text-muted small fw-semibold">إجمالي التذاكر</span>
                    <h2 class="fw-bold text-dark mt-2 mb-0">24</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card main-card bg-white p-3 text-center border-bottom border-warning border-3">
                    <span class="text-muted small fw-semibold">قيد الانتظار</span>
                    <h2 class="fw-bold text-warning mt-2 mb-0">6</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card main-card bg-white p-3 text-center border-bottom border-success border-3">
                    <span class="text-muted small fw-semibold">تم إنجازها</span>
                    <h2 class="fw-bold text-success mt-2 mb-0">18</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card main-card bg-white p-3 text-center border-bottom border-info border-3">
                    <span class="text-muted small fw-semibold">فنيين الصيانة النشطين</span>
                    <h2 class="fw-bold text-info mt-2 mb-0">4</h2>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- إدارة وتصنيف أقسام الصيانة (Categories CRUD) -->
            <div class="col-md-5">
                <div class="card main-card bg-white h-100">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h6 class="card-title m-0 fw-bold text-primary">
                            <i class="fa-solid fa-folder-plus me-2"></i> إضافة قسم / تصنيف صيانة جديد
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">اسم القسم / نوع العطل</label>
                            <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder="مثال: شاشات وكاميرات مراقبة"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">الفني المسؤول الافتراضي</label>
                            <asp:DropDownList ID="ddlTechAssign" runat="server" CssClass="form-select">
                                <asp:ListItem Text="فهد الحربي (قسم الشبكات)" />
                                <asp:ListItem Text="سلطان الدوسري (قسم العتاد)" />
                                <asp:ListItem Text="مشعل القحطاني (قسم البرمجيات)" />
                            </asp:DropDownList>
                        </div>
                        <asp:Button ID="btnAddCategory" runat="server" Text="إضافة التصنيف" CssClass="btn btn-primary w-100 fw-semibold" />
                    </div>
                </div>
            </div>

            <!-- قائمة التصنيفات الحالية -->
            <div class="col-md-7">
                <div class="card main-card bg-white h-100">
                    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h6 class="card-title m-0 fw-bold text-dark">
                            <i class="fa-solid fa-list me-2"></i> تصنيفات الصيانة المعتمدة في النظام
                        </h6>
                    </div>
                    <div class="card-body table-responsive p-0">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>اسم التصنيف</th>
                                    <th>المسؤول</th>
                                    <th>إجراء</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td class="fw-bold">أجهزة ومعدات حاسوبية</td>
                                    <td>سلطان الدوسري</td>
                                    <td><button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i></button></td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td class="fw-bold">مشاكل الشبكة والإنترنت</td>
                                    <td>فهد الحربي</td>
                                    <td><button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i></button></td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td class="fw-bold">أنظمة وبرمجيات</td>
                                    <td>مشعل القحطاني</td>
                                    <td><button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i></button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>