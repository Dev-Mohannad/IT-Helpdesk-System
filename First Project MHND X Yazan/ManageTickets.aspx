<%@ Page Title="إدارة ومتابعة طلبات الصيانة" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageTickets.aspx.cs" Inherits="First_Project_MHND_X_Yazan.ManageTickets" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        
 
        <asp:Label ID="lblAlert" runat="server" Visible="false" CssClass="alert d-block mb-3 py-2 text-center"></asp:Label>

        <div class="card main-card bg-white">
            <div class="card-header bg-white py-3 border-bottom d-flex flex-wrap justify-content-between align-items-center gap-2">
                <h5 class="card-title m-0 text-dark fw-bold">
                    <i class="fa-solid fa-list-check me-2 text-primary"></i> سجل تذاكر الصيانة والدعم الفني
                </h5>
                
                
                <div class="d-flex align-items-center gap-1">
                    <asp:Button ID="btnExportExcel" runat="server" Text="Excel 📥" CssClass="btn btn-outline-success btn-sm fw-semibold" OnClick="btnExportExcel_Click" />
                    <asp:Button ID="btnExportWord" runat="server" Text="Word 📄" CssClass="btn btn-outline-primary btn-sm fw-semibold" OnClick="btnExportWord_Click" />
                    <asp:Button ID="btnExportPdf" runat="server" Text="PDF 🖨️" CssClass="btn btn-outline-danger btn-sm fw-semibold" OnClick="btnExportPdf_Click" />
                </div>
            </div>

            <!-- شريط البحث السريع -->
            <div class="card-body border-bottom bg-light py-2">
                <div class="row g-2 align-items-center">
                    <div class="col-md-5">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm" placeholder="بحث باسم مقدم الطلب أو عنوان البلاغ..."></asp:TextBox>
                    </div>
                    <div class="col-auto">
                        <asp:Button ID="btnSearch" runat="server" Text="بحث" CssClass="btn btn-primary btn-sm px-3" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnReset" runat="server" Text="إلغاء البحث" CssClass="btn btn-secondary btn-sm px-3" OnClick="btnReset_Click" />
                    </div>
                </div>
            </div>

            <!-- جدول استعراض البيانات (GridView) -->
            <div class="card-body table-responsive p-0">
                <asp:GridView ID="gvTickets" runat="server" CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="False" GridLines="None" EmptyDataText="لا توجد تذاكر مسجلة حالياً."
                    DataKeyNames="TicketId" OnRowCommand="gvTickets_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="TicketId" HeaderText="#" ItemStyle-CssClass="fw-bold text-center text-muted" HeaderStyle-CssClass="text-center" />
                        <asp:BoundField DataField="RequesterName" HeaderText="مقدم الطلب" />
                        <asp:BoundField DataField="Category" HeaderText="القسم / التصنيف" />
                        <asp:BoundField DataField="TicketSubject" HeaderText="عنوان المشكلة" ItemStyle-Font-Bold="true" />
                        
                        <asp:TemplateField HeaderText="الأولوية">
                            <ItemTemplate>
                                <span class='<%# Eval("Priority").ToString() == "Urgent" ? "badge bg-danger" : (Eval("Priority").ToString() == "Medium" ? "badge bg-warning text-dark" : "badge bg-secondary") %>'>
                                    <%# Eval("Priority") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="الحالة">
                            <ItemTemplate>
                                <span class='<%# Eval("Status").ToString() == "مكتمل" ? "badge bg-success" : (Eval("Status").ToString() == "قيد المعالجة" ? "badge bg-info text-dark" : "badge bg-warning text-dark") %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="الإجراءات" ItemStyle-Width="160px">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnToggleStatus" runat="server" CssClass="btn btn-sm btn-outline-success me-1"
                                    CommandName="CompleteTicket" CommandArgument='<%# Eval("TicketId") %>' title="تغيير الحالة لمكتمل">
                                    <i class="fa-solid fa-check"></i>
                                </asp:LinkButton>
                                
                                <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-outline-danger"
                                    CommandName="DeleteTicket" CommandArgument='<%# Eval("TicketId") %>'
                                    OnClientClick="return confirm('هل أنت متأكد من رغبتك في حذف هذا الطلب؟');">
                                    <i class="fa-solid fa-trash"></i> حذف
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