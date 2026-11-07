using System;
using System.Configuration;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Web.UI;

namespace First_Project_MHND_X_Yazan
{
    public partial class CreateTicket : Page
    {
        CRUD myCrud;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                myCrud = new CRUD();
            }
            catch (Exception ex)
            {
                lblStatusMessage.Text = "تنبيه في الاتصال بقاعدة البيانات: " + ex.Message;
                lblStatusMessage.CssClass = "alert alert-warning d-block mb-3 py-2 text-center";
                lblStatusMessage.Visible = true;
            }
        }

        protected void btnSubmitTicket_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtRequesterName.Text) ||
                string.IsNullOrWhiteSpace(txtRequesterEmail.Text) ||
                string.IsNullOrWhiteSpace(ddlCategory.SelectedValue) ||
                string.IsNullOrWhiteSpace(txtTicketSubject.Text))
            {
                lblStatusMessage.Text = "يرجى تعبئة الحقول المطلوبة للمتابعة!";
                lblStatusMessage.CssClass = "alert alert-danger d-block mb-3 py-2 text-center fw-semibold";
                lblStatusMessage.Visible = true;
                return;
            }

            try
            {
                if (myCrud == null) myCrud = new CRUD();

                string name = txtRequesterName.Text.Trim().Replace("'", "''");
                string email = txtRequesterEmail.Text.Trim().Replace("'", "''");
                string categoryText = ddlCategory.SelectedValue.Replace("'", "''");
                string priority = rblPriority.SelectedValue;
                string subject = txtTicketSubject.Text.Trim().Replace("'", "''");
                string status = "جديد";

                int userId = 1;
                string checkUserSql = $"SELECT UserId FROM Users WHERE Email = N'{email}'";
                DataTable dtUser = myCrud.getDT(checkUserSql);

                if (dtUser != null && dtUser.Rows.Count > 0)
                {
                    userId = Convert.ToInt32(dtUser.Rows[0]["UserId"]);
                }
                else
                {
                    string insertUserSql = $"INSERT INTO Users (FullName, Email, Role) VALUES (N'{name}', N'{email}', 'User'); SELECT SCOPE_IDENTITY();";
                    DataTable dtNewUser = myCrud.getDT(insertUserSql);
                    if (dtNewUser != null && dtNewUser.Rows.Count > 0 && dtNewUser.Rows[0][0] != DBNull.Value)
                    {
                        userId = Convert.ToInt32(dtNewUser.Rows[0][0]);
                    }
                }

                int categoryId = 1;
                string checkCatSql = $"SELECT CategoryId FROM Categories WHERE CategoryName = N'{categoryText}'";
                DataTable dtCat = myCrud.getDT(checkCatSql);

                if (dtCat != null && dtCat.Rows.Count > 0)
                {
                    categoryId = Convert.ToInt32(dtCat.Rows[0]["CategoryId"]);
                }
                else
                {
                    string insertCatSql = $"INSERT INTO Categories (CategoryName) VALUES (N'{categoryText}'); SELECT SCOPE_IDENTITY();";
                    DataTable dtNewCat = myCrud.getDT(insertCatSql);
                    if (dtNewCat != null && dtNewCat.Rows.Count > 0 && dtNewCat.Rows[0][0] != DBNull.Value)
                    {
                        categoryId = Convert.ToInt32(dtNewCat.Rows[0][0]);
                    }
                }

                string sql = $"INSERT INTO Tickets (UserId, CategoryId, RequesterName, RequesterEmail, Category, TicketSubject, Priority, Status, CreatedAt) " +
                             $"VALUES ({userId}, {categoryId}, N'{name}', N'{email}', N'{categoryText}', N'{subject}', N'{priority}', N'{status}', GETDATE())";

                int result = myCrud.InsertUpdateDelete(sql);

                if (result > 0)
                {
                   
                    try
                    {
                        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls;

                        string senderEmail = ConfigurationManager.AppSettings["emailFrom"];
                        string smtpUser = ConfigurationManager.AppSettings["emailUserName"];
                        string smtpPass = ConfigurationManager.AppSettings["emailPassword"];
                        string host = ConfigurationManager.AppSettings["HostsmtpAddress"];
                        int port = int.Parse(ConfigurationManager.AppSettings["PortNumber"]);

                        using (MailMessage mail = new MailMessage())
                        {
                            mail.From = new MailAddress(senderEmail, "نظام الدعم الفني والصيانة");
                            mail.To.Clear();
                            mail.To.Add(email);

                            mail.Subject = "تأكيد استلام طلب دعم فني: " + subject;
                            mail.Body = $@"مرحباً بك {name}،

تم استلام طلب الصيانة الخاص بك بنجاح، وتأكيد تسجيله في النظام.

- عنوان المشكلة: {subject}
- تصنيف البلاغ: {categoryText}
- مستوى الأولوية: {priority}
- حالة الطلب: جديد

شكراً لتواصلك مع نظام تذاكر الدعم الفني والصيانة.";
                            mail.IsBodyHtml = false;

                            using (SmtpClient smtp = new SmtpClient(host, port))
                            {
                                smtp.UseDefaultCredentials = false;
                                smtp.Credentials = new NetworkCredential(smtpUser, smtpPass);
                                smtp.EnableSsl = true;
                                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;

                                smtp.Send(mail);
                            }
                        }

                        lblStatusMessage.Text = $"تم إرسال وحفظ الطلب بنجاح، ووصلت رسالة التأكيد إلى بريدك ({email})! ✉️";
                        lblStatusMessage.CssClass = "alert alert-success d-block mb-3 py-2 text-center fw-semibold";
                    }
                    catch (Exception mailEx)
                    {
                        lblStatusMessage.Text = "تم حفظ الطلب في قاعدة البيانات، ولكن تعذر إرسال الإيميل بسبب: " + mailEx.Message;
                        lblStatusMessage.CssClass = "alert alert-warning d-block mb-3 py-2 text-center fw-semibold";
                    }

                    lblStatusMessage.Visible = true;
                    ClearControls();
                }
                else
                {
                    lblStatusMessage.Text = "تعذر حفظ الطلب في قاعدة البيانات، يرجى المحاولة لاحقاً.";
                    lblStatusMessage.CssClass = "alert alert-danger d-block mb-3 py-2 text-center fw-semibold";
                    lblStatusMessage.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblStatusMessage.Text = "خطأ: " + ex.Message;
                lblStatusMessage.CssClass = "alert alert-danger d-block mb-3 py-2 text-center fw-semibold";
                lblStatusMessage.Visible = true;
            }
        }

        protected void btnResetForm_Click(object sender, EventArgs e)
        {
            ClearControls();
            lblStatusMessage.Visible = false;
        }

        private void ClearControls()
        {
            txtRequesterName.Text = "";
            txtRequesterEmail.Text = "";
            ddlCategory.SelectedIndex = 0;
            rblPriority.SelectedIndex = 0;
            if (cblAffectedItems != null) cblAffectedItems.ClearSelection();
            txtTicketSubject.Text = "";
           
        }
    }
}