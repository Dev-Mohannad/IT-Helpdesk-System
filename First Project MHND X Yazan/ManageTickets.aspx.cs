using demoTurki1988.App_Code;
using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace First_Project_MHND_X_Yazan
{
    public partial class ManageTickets : Page
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
                }
            }
            catch (Exception ex)
            {
                ShowAlert("تنبيه في الاتصال بقاعدة البيانات: " + ex.Message, false);
            }
        }

        private void LoadTickets(string searchTerm = "")
        {
            if (myCrud == null) myCrud = new CRUD();

            string sql;
            if (string.IsNullOrWhiteSpace(searchTerm))
            {
                sql = "SELECT TicketId, RequesterName, Category, TicketSubject, Priority, Status FROM Tickets ORDER BY TicketId DESC";
            }
            else
            {
                string cleanSearch = searchTerm.Replace("'", "''");
                sql = $"SELECT TicketId, RequesterName, Category, TicketSubject, Priority, Status FROM Tickets WHERE RequesterName LIKE '%{cleanSearch}%' OR TicketSubject LIKE '%{cleanSearch}%' ORDER BY TicketId DESC";
            }

            try
            {
                DataTable dt = myCrud.getDT(sql);
                gvTickets.DataSource = dt;
                gvTickets.DataBind();
            }
            catch
            {
               
            }
        }

        protected void gvTickets_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (myCrud == null) myCrud = new CRUD();
            int ticketId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "DeleteTicket")
            {
                string sql = "DELETE FROM Tickets WHERE TicketId = " + ticketId;
                int rows = myCrud.InsertUpdateDelete(sql);
                if (rows > 0)
                {
                    ShowAlert("تم حذف تذكرة الصيانة بنجاح.", true);
                    LoadTickets();
                }
            }
            else if (e.CommandName == "CompleteTicket")
            {
                string sql = "UPDATE Tickets SET Status = N'مكتمل' WHERE TicketId = " + ticketId;
                int rows = myCrud.InsertUpdateDelete(sql);
                if (rows > 0)
                {
                    ShowAlert("تم تحديث حالة الطلب إلى (مكتمل) بنجاح.", true);
                    LoadTickets();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadTickets(txtSearch.Text);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadTickets();
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            ExportGrid("application/vnd.ms-excel", "Tickets_Report.xls");
        }

        protected void btnExportWord_Click(object sender, EventArgs e)
        {
            ExportGrid("application/vnd.ms-word", "Tickets_Report.doc");
        }

        protected void btnExportPdf_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "PrintScript", "window.print();", true);
        }

        private void ExportGrid(string contentType, string fileName)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName);
            Response.Charset = "UTF-8";
            Response.ContentType = contentType;
            Response.ContentEncoding = System.Text.Encoding.UTF8;

         
            Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble());

            using (System.IO.StringWriter sw = new System.IO.StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    
                    if (gvTickets.Columns.Count > 6)
                    {
                        gvTickets.Columns[6].Visible = false;
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