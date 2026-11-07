using demoTurki1988.App_Code;
using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace First_Project_MHND_X_Yazan
{
    public partial class TechDashboard : Page
    {
        CRUD myCrud;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                myCrud = new CRUD();
                if (!IsPostBack)
                {
                    LoadTickets();
                    UpdateStatistics();
                }
            }
            catch
            {
                // تفادي توقف الصفحة في حال كانت قاعدة البيانات غير متصلة مؤقتاً
            }
        }

        // جلب التذاكر مع البحث والتصفية
        private void LoadTickets()
        {
            if (myCrud == null) return;

            string sql = "SELECT TicketId, RequesterName, Category, TicketSubject, Priority, Status FROM Tickets WHERE 1=1";

            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                string cleanSearch = txtSearch.Text.Trim().Replace("'", "''");
                sql += $" AND (RequesterName LIKE '%{cleanSearch}%' OR TicketSubject LIKE '%{cleanSearch}%')";
            }

            if (!string.IsNullOrWhiteSpace(ddlFilterStatus.SelectedValue))
            {
                sql += $" AND Status = N'{ddlFilterStatus.SelectedValue}'";
            }

            sql += " ORDER BY TicketId DESC";

            DataTable dt = myCrud.getDT(sql);
            gvTickets.DataSource = dt;
            gvTickets.DataBind();
        }

        // تحديث إحصائيات الكروت بالأعلى
        private void UpdateStatistics()
        {
            if (myCrud == null) return;

            DataTable dtAll = myCrud.getDT("SELECT Status FROM Tickets");
            if (dtAll != null)
            {
                int total = dtAll.Rows.Count;
                int countNew = 0;
                int countProgress = 0;
                int countCompleted = 0;

                foreach (DataRow row in dtAll.Rows)
                {
                    string status = row["Status"].ToString();
                    if (status == "جديد") countNew++;
                    else if (status == "قيد المعالجة") countProgress++;
                    else if (status == "مكتمل") countCompleted++;
                }

                litTotalCount.Text = total.ToString();
                litNewCount.Text = countNew.ToString();
                litProgressCount.Text = countProgress.ToString();
                litCompletedCount.Text = countCompleted.ToString();
            }
        }

        // معالجة الضغط على الخيارات (قبول، تم الانتهاء، رفض، حذف)
        protected void gvTickets_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandArgument == null || string.IsNullOrEmpty(e.CommandArgument.ToString())) return;

            int ticketId = Convert.ToInt32(e.CommandArgument);

            // 1. خيار قبول الطلب (تحويله إلى قيد المعالجة)
            if (e.CommandName == "AcceptTicket")
            {
                string sql = $"UPDATE Tickets SET Status = N'قيد المعالجة' WHERE TicketId = {ticketId}";
                int rows = myCrud.InsertUpdateDelete(sql);
                if (rows > 0)
                {
                    ShowAlert($"تم قبول الطلب رقم #{ticketId} وتحويله إلى (قيد المعالجة).", true);
                    ReloadData();
                }
            }
            // 2. خيار تم الانتهاء من الصيانة
            else if (e.CommandName == "CompleteTicket")
            {
                string sql = $"UPDATE Tickets SET Status = N'مكتمل' WHERE TicketId = {ticketId}";
                int rows = myCrud.InsertUpdateDelete(sql);
                if (rows > 0)
                {
                    ShowAlert($"تم إغلاق البلاغ رقم #{ticketId} كـ (تم الانتهاء بنجاح).", true);
                    ReloadData();
                }
            }
            // 3. خيار رفض الطلب
            else if (e.CommandName == "RejectTicket")
            {
                string sql = $"UPDATE Tickets SET Status = N'مرفوض' WHERE TicketId = {ticketId}";
                int rows = myCrud.InsertUpdateDelete(sql);
                if (rows > 0)
                {
                    ShowAlert($"تم رفض الطلب رقم #{ticketId}.", false);
                    ReloadData();
                }
            }
            // 4. خيار الحذف
            else if (e.CommandName == "DeleteTicket")
            {
                string sql = $"DELETE FROM Tickets WHERE TicketId = {ticketId}";
                int rows = myCrud.InsertUpdateDelete(sql);
                if (rows > 0)
                {
                    ShowAlert($"تم حذف سجل الطلب رقم #{ticketId} بنجاح.", true);
                    ReloadData();
                }
            }
        }

        private void ReloadData()
        {
            LoadTickets();
            UpdateStatistics();
        }

        // تنسيق لون شارة الحالة
        public string GetStatusBadgeClass(string status)
        {
            switch (status)
            {
                case "مكتمل":
                    return "bg-success text-white";
                case "قيد المعالجة":
                    return "bg-info text-dark";
                case "مرفوض":
                    return "bg-danger text-white";
                default:
                    return "bg-secondary text-white";
            }
        }

        // تصفية حسب الحالة
        protected void ddlFilterStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTickets();
        }

        // زر البحث
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadTickets();
        }

        // إلغاء التصفية والبحث
        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilterStatus.SelectedIndex = 0;
            LoadTickets();
        }

        // تصدير Excel
        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            ExportGrid("application/vnd.ms-excel", "Maintenance_Orders.xls");
        }

        // تصدير Word
        protected void btnExportWord_Click(object sender, EventArgs e)
        {
            ExportGrid("application/vnd.ms-word", "Maintenance_Orders.doc");
        }

        private void ExportGrid(string contentType, string fileName)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName);
            Response.Charset = "UTF-8";
            Response.ContentType = contentType;
            Response.ContentEncoding = System.Text.Encoding.UTF8;

            // حقن علامة BOM ليتعرف Excel تلقائياً على الترميز العربي
            Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble());

            using (System.IO.StringWriter sw = new System.IO.StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    if (gvTickets.Columns.Count > 6)
                    {
                        gvTickets.Columns[6].Visible = false; // إخفاء عمود الأزرار عند التصدير
                    }

                    hw.Write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />");
                    hw.Write("<div dir=\"rtl\">");

                    gvTickets.RenderControl(hw);

                    hw.Write("</div>");

                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();
                }
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
        }

        private void ShowAlert(string msg, bool isSuccess)
        {
            lblAlert.Text = msg;
            lblAlert.CssClass = isSuccess ? "alert alert-success d-block py-2 mb-3" : "alert alert-danger d-block py-2 mb-3";
            lblAlert.Visible = true;
        }
    }
}