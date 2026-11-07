<%@ Page Title="من نحن - فريق العمل" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="First_Project_MHND_X_Yazan.AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-3">
       
        <div class="card main-card bg-white p-4 mb-4 text-center">
            <h2 class="fw-bold text-dark mb-2">Project Developers <br /> <br /> Project 1</h2>
            <h3 class="text-muted m-0">ASP.NET Web Forms & SQL Server</h3>
        </div>

     
        <div class="row g-4 justify-content-center">
           
            <div class="col-md-5">
                <div class="card main-card bg-white p-4 text-center h-100 border-top border-primary border-4 shadow-sm">
                    <h4 class="fw-bold text-dark mb-2">مهند تركي الحربي</h4>
                    <p class="text-muted mb-3">التخصص: تقنية البرمجة وتطوير الويب</p>
                    <div class="text-muted small pt-3 border-top">
                        <strong>رقم الملف:</strong> 14303
                    </div>
                </div>
            </div>

         
            <div class="col-md-5">
                <div class="card main-card bg-white p-4 text-center h-100 border-top border-info border-4 shadow-sm">
                    <h4 class="fw-bold text-dark mb-2">يزن عبدالله مصيليخ</h4>
                    <p class="text-muted mb-3">التخصص: تقنية البرمجة وتطوير الويب</p>
                    <div class="text-muted small pt-3 border-top">
                        <strong>رقم الملف:</strong> 14304
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>