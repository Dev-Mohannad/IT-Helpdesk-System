<%@ Page Title="بوابة فني الدعم الميداني" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TechDashboard.aspx.cs" Inherits="First_Project_MHND_X_Yazan.TechDashboard" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .badge-pending { background-color: #6c757d; color: #fff; }
        .badge-inprogress { background-color: #0dcaf0; color: #000; }
        .badge-completed { background-color: #198754; color: #fff; }
        .badge-rejected { background-color: #dc3545; color: #fff; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        
       
        <asp:Label ID="lblAlert" runat="server" Visible="false" CssClass="alert d-block mb-3 py-2 text-center fw-semibold"></asp:Label>

        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm p-3 border-start border-primary border-4 bg-white">
                    <span class="text-muted small fw-semibold">إجمالي البلاغات</span>
                    <h3 class="fw-bold text-primary my-1"><asp:Literal ID="litTotalCount" runat="server" Text="0"></asp:Literal></h3>
                    <small class="text-muted"><i class="fa-solid fa-list-check me-1"></i> جميع الطلبات</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm p-3 border-start border-secondary border-4 bg-white">
                    <span class="text-muted small fw-semibold">طلبات جديدة</span>
                    <h3 class="fw-bold text-secondary my-1"><asp:Literal ID="litNewCount" runat="server" Text="0"></asp:Literal></h3>
                    <small class="text-muted"><i class="fa-solid fa-inbox me-1"></i> بانتظار اتخاذ إجراء</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm p-3 border-start border-info border-4 bg-white">
                    <span class="text-muted small fw-semibold">قيد المعالجة (مقبولة)</span>
                    <h3 class="fw-bold text-info my-1"><asp:Literal ID="litProgressCount" runat="server" Text="0"></asp:Literal></h3>
                    <small class="text-muted"><i class="fa-solid fa-screwdriver-wrench me-1"></i> جاري إصلاحها</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm p-3 border-start border-success border-4 bg-white">
                    <span class="text-muted small fw-semibold">تم الانتهاء</span>
                    <h3 class="fw-bold text-success my-1"><asp:Literal ID="litCompletedCount" runat="server" Text="0"></asp:Literal></h3>
                    <small class="text-success"><i class="fa-solid fa-circle-check me-1"></i> أجهزة تم إصلاحها</small>
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm bg-white">
            <div class="card-header bg-white py-3 border-bottom d-flex flex-wrap justify-content-between align-items-center gap-2">
                <h5 class="card-title m-0 text-dark fw-bold">
                    <i class="fa-solid fa-clipboard-list me-2 text-primary"></i> قائمة طلبات صيانة الأجهزة
                </h5>
                <div class="d-flex align-items-center gap-1">
                    <asp:Button ID="btnExportExcel" runat="server" Text="Excel 📥" CssClass="btn btn-outline-success btn-sm fw-semibold" OnClick="btnExportExcel_Click" />
                    <asp:Button ID="btnExportWord" runat="server" Text="Word 📄" CssClass="btn btn-outline-primary btn-sm fw-semibold" OnClick="btnExportWord_Click" />
                </div>
            </div>

            <div class="card-body border-bottom bg-light py-2">
                <div class="row g-2 align-items-center">
                    <div class="col-md-4">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm" placeholder="ابحث باسم صاحب الجهاز أو عنوان العطل..."></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterStatus_SelectedIndexChanged">
                            <asp:ListItem Text="-- كل الحالات --" Value="" />
                            <asp:ListItem Text="جديد" Value="جديد" />
                            <asp:ListItem Text="قيد المعالجة" Value="قيد المعالجة" />
                            <asp:ListItem Text="مكتمل" Value="مكتمل" />
                            <asp:ListItem Text="مرفوض" Value="مرفوض" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-auto">
                        <asp:Button ID="btnSearch" runat="server" Text="بحث" CssClass="btn btn-primary btn-sm px-3" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnReset" runat="server" Text="إلغاء التصفية" CssClass="btn btn-secondary btn-sm px-3" OnClick="btnReset_Click" />
                    </div>
                </div>
            </div>

            <div class="card-body table-responsive p-0">
                <asp:GridView ID="gvTickets" runat="server" CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="False" GridLines="None" EmptyDataText="لا توجد بلاغات مسجلة حالياً."
                    DataKeyNames="TicketId" OnRowCommand="gvTickets_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="TicketId" HeaderText="#" ItemStyle-CssClass="fw-bold text-center text-muted" HeaderStyle-CssClass="text-center" />
                        <asp:BoundField DataField="RequesterName" HeaderText="صاحب الطلب" />
                        <asp:BoundField DataField="Category" HeaderText="نوع الجهاز / القسم" />
                        <asp:BoundField DataField="TicketSubject" HeaderText="وصف العطل" ItemStyle-Font-Bold="true" />
                        
                        <asp:TemplateField HeaderText="الأولوية">
                            <ItemTemplate>
                                <span class='<%# Eval("Priority").ToString() == "Urgent" ? "badge bg-danger" : (Eval("Priority").ToString() == "Medium" ? "badge bg-warning text-dark" : "badge bg-secondary") %>'>
                                    <%# Eval("Priority") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="الحالة الحالية">
                            <ItemTemplate>
                                <span class='badge <%# GetStatusBadgeClass(Eval("Status").ToString()) %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="خيارات الفني (اتخاذ إجراء)" ItemStyle-Width="320px">
                            <ItemTemplate>
                             

                                <asp:LinkButton ID="btnAccept" runat="server" CssClass="btn btn-sm btn-outline-primary me-1"
                                    CommandName="AcceptTicket" CommandArgument='<%# Eval("TicketId") %>'
                                    Visible='<%# Eval("Status").ToString() == "جديد" %>'>
                                    <i class="fa-solid fa-play me-1"></i> قبول (قيد المعالجة)
                                </asp:LinkButton>

                               
                                <asp:LinkButton ID="btnComplete" runat="server" CssClass="btn btn-sm btn-success text-white me-1"
                                    CommandName="CompleteTicket" CommandArgument='<%# Eval("TicketId") %>'
                                    Visible='<%# Eval("Status").ToString() == "قيد المعالجة" %>'>
                                    <i class="fa-solid fa-check-double me-1"></i> تم الانتهاء
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnReject" runat="server" CssClass="btn btn-sm btn-outline-danger me-1"
                                    CommandName="RejectTicket" CommandArgument='<%# Eval("TicketId") %>'
                                    Visible='<%# Eval("Status").ToString() == "جديد" || Eval("Status").ToString() == "قيد المعالجة" %>'
                                    OnClientClick="return confirm('هل تريد بالتأكيد رفض هذا الطلب؟');">
                                    <i class="fa-solid fa-ban me-1"></i> رفض
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-outline-secondary"
                                    CommandName="DeleteTicket" CommandArgument='<%# Eval("TicketId") %>'
                                    OnClientClick="return confirm('هل أنت متأكد من حذف هذا السجل نهائياً؟');" title="حذف">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="table-light" />
                </asp:GridView>
            </div>
        </div>

    </div>
</asp:Content>