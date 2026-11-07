<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="First_Project_MHND_X_Yazan.Login" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>تسجيل الدخول - نظام الدعم الفني</title>
    <!-- Bootstrap 5 RTL & FontAwesome -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.rtl.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <style>
        body {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 420px;
        }
        .brand-icon {
            width: 70px;
            height: 70px;
            background-color: #e0f2fe;
            color: #0284c7;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin: 0 auto 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card login-card p-4 bg-white">
            <div class="card-body">
                <div class="brand-icon">
                    <i class="fa-solid fa-headset"></i>
                </div>
                <h4 class="text-center fw-bold text-dark mb-1">نظام الدعم الفني</h4>
                <p class="text-center text-muted small mb-3">أدخل بيانات الاعتماد للمتابعة</p>

               
                <asp:Label ID="lblAlert" runat="server" Visible="false" CssClass="alert alert-danger d-block text-center py-2 mb-3 fw-semibold small"></asp:Label>

                
                <div class="mb-3">
                    <label class="form-label fw-semibold text-secondary">البريد الإلكتروني</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa-solid fa-envelope text-muted"></i></span>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="name@email.com"></asp:TextBox>
                    </div>
                </div>

               
                <div class="mb-3">
                    <label class="form-label fw-semibold text-secondary">كلمة المرور</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="fa-solid fa-lock text-muted"></i></span>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="••••••••"></asp:TextBox>
                    </div>
                </div>

               
                <div class="mb-4">
                    <label class="form-label fw-semibold text-secondary">الدخول بصلاحية</label>
                    <asp:DropDownList ID="ddlUserRole" runat="server" CssClass="form-select">
                        <asp:ListItem Text="موظف / مستخدم (User)" Value="User" />
                        <asp:ListItem Text="فني الدعم (Technician)" Value="Tech" />
                    </asp:DropDownList>
                </div>

              
                <asp:Button ID="btnLogin" runat="server" Text="تسجيل الدخول" CssClass="btn btn-primary w-100 py-2 fw-semibold" OnClick="btnLogin_Click" />
            </div>
        </div>
    </form>
</body>
</html>