<%@ Page Title="رفع طلب دعم فني جديد" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateTicket.aspx.cs" Inherits="First_Project_MHND_X_Yazan.CreateTicket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .custom-control-list label {
            margin-right: 8px;
            margin-left: 20px;
            cursor: pointer;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">

       
        <asp:Label ID="lblStatusMessage" runat="server" Visible="false" CssClass="alert d-block mb-3 py-2 text-center fw-semibold"></asp:Label>

        <div class="card main-card bg-white shadow-sm border-0">
            <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="card-title m-0 text-primary fw-bold">
                    <i class="fa-solid fa-ticket me-2"></i> نموذج تسجيل تذكرة صيانة / دعم فني
                </h5>
                <span class="text-muted small">* جميع الحقول المميزة بعلامة مطلوبة</span>
            </div>
            
            <div class="card-body p-4">
                <div class="row g-3">
                    
                  
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">اسم مقدم الطلب <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtRequesterName" runat="server" CssClass="form-control" placeholder="أدخل اسمك الثلاثي"></asp:TextBox>
                    </div>

                 
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">البريد الإلكتروني <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtRequesterEmail" runat="server" CssClass="form-control" placeholder="user@example.com"></asp:TextBox>
                    </div>

                  
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">قسم أو نوع البلاغ <span class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                            <asp:ListItem Text="-- اختر تصنيف المشكلة --" Value="" />
                            <asp:ListItem Text="أجهزة ومعدات حاسوبية (Hardware)" Value="Hardware" />
                            <asp:ListItem Text="مشاكل الشبكة والإنترنت (Network)" Value="Network" />
                            <asp:ListItem Text="أنظمة وبرمجيات (Software)" Value="Software" />
                            <asp:ListItem Text="طابعات وماسحات ضوئية (Printers)" Value="Printers" />
                        </asp:DropDownList>
                    </div>

                   
                    <div class="col-md-6">
                        <label class="form-label fw-semibold d-block">مستوى الأولوية <span class="text-danger">*</span></label>
                        <asp:RadioButtonList ID="rblPriority" runat="server" RepeatDirection="Horizontal" CssClass="custom-control-list pt-2">
                            <asp:ListItem Text="عادي (Low)" Value="Low" Selected="True" />
                            <asp:ListItem Text="متوسط (Medium)" Value="Medium" />
                            <asp:ListItem Text="عاجل جداً (Urgent)" Value="Urgent" />
                        </asp:RadioButtonList>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-semibold d-block">الملحقات أو الخدمات المتأثرة بالعطل</label>
                        <asp:CheckBoxList ID="cblAffectedItems" runat="server" RepeatDirection="Horizontal" CssClass="custom-control-list pt-1">
                            <asp:ListItem Text="شاشة العرض (Monitor)" Value="Monitor" />
                            <asp:ListItem Text="الفأرة / لوحة المفاتيح" Value="InputDevices" />
                            <asp:ListItem Text="كابلات التوصيل / الطاقة" Value="Cables" />
                            <asp:ListItem Text="الوصول للإنترنت" Value="InternetAccess" />
                        </asp:CheckBoxList>
                    </div>

                    
                    <div class="col-12">
                        <label class="form-label fw-semibold">عنوان البلاغ <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtTicketSubject" runat="server" CssClass="form-control" placeholder="مثال: الشاشة لا تعمل وتصدر صوتاً مستمراً"></asp:TextBox>
                    </div>


                    <div class="col-12 text-end pt-3 border-top">
                        <asp:Button ID="btnSubmitTicket" runat="server" Text="إرسال الطلب الآن 🚀" CssClass="btn btn-primary px-4 fw-semibold me-2" OnClick="btnSubmitTicket_Click" />
                        <asp:Button ID="btnResetForm" runat="server" Text="تفريغ الحقول" CssClass="btn btn-secondary px-3" CausesValidation="false" OnClick="btnResetForm_Click" />
                    </div>

                </div>
            </div>
        </div>

    </div>
</asp:Content>