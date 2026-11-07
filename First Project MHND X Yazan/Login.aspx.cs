using System;
using System.Web.UI;

namespace First_Project_MHND_X_Yazan
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblAlert.Text = "يرجى تعبئة الحقول المطلوبة للمتابعة";
                lblAlert.Visible = true;
                return;
            }

            lblAlert.Visible = false;

            string selectedRole = ddlUserRole.SelectedValue;
            Session["UserRole"] = selectedRole;
            Session["UserEmail"] = txtEmail.Text.Trim();

            if (selectedRole == "User")
            {
                Response.Redirect("~/CreateTicket.aspx");
            }
            else
            {
                Response.Redirect("~/TechDashboard.aspx");
            }
        }
    }
}