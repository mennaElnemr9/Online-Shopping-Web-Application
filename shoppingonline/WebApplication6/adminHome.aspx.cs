using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class adminHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void activatevend(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("activateVendors", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            string Vuser = vendoruser.Text;
            cmd.Parameters.Add(new SqlParameter("@admin_username", Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@vendor_username", Vuser));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("passed");
            }
            catch (Exception ex)
            {
                Response.Write("vendor username not found");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void ReviewOrders(object sender, EventArgs e)
        {
            Response.Redirect("OrdersForAdmin.aspx", true);

        }

        protected void updateToInprocess(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("updateOrderStatusInProcess", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            int order = Int32.Parse(orderno.Text);
            cmd.Parameters.Add(new SqlParameter("@order_no", order));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("passed");
            }
            catch (Exception ex)
            {
                Response.Write("order no. doesnot exist");
            }
            finally
            {
                conn.Close();
            }
        }



        protected void addTodaysdealonProduct(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("addTodaysDealOnProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            int deal_id = Int32.Parse(dealid.Text);
            cmd.Parameters.Add(new SqlParameter("@deal_id", deal_id));
            int serial_no = Int32.Parse(serialno.Text);
            cmd.Parameters.Add(new SqlParameter("@serial_no", serial_no));
            SqlCommand cmd2 = new SqlCommand("checkTodaysDealOnProduct", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@serial_no", serial_no));
            SqlParameter active = cmd2.Parameters.Add("@activeDeal", SqlDbType.Bit);
            active.Direction = ParameterDirection.Output;
            try
            {
                conn.Open();
                cmd2.ExecuteNonQuery();
                if (active.Value.ToString().Equals("1"))
                    Response.Write("there already exists an active today's deal");
                else
                {
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex);
                Response.Write("invalid serial number or deal id");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void CreateTodaysDeal(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("createTodaysDeal", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            int deal_amount = Int32.Parse(dealamount.Text);
            cmd.Parameters.Add(new SqlParameter("@deal_amount", deal_amount));
            cmd.Parameters.Add(new SqlParameter("@admin_username", Session["username"]));
            DateTime expiry_date = DateTime.Parse(expirydate.Text);
            cmd.Parameters.Add(new SqlParameter("@expiry_date", expiry_date));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("passed");
            }
            catch (Exception ex)
            {
                Response.Write("error occured");
            }
            finally
            {
                conn.Close();
            }


        }

        protected void removeTodaysDeal(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("removeExpiredDeal", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            int deal_id = Int32.Parse(dealidrem.Text);
            cmd.Parameters.Add(new SqlParameter("@deal_id", deal_id));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("passed");
            }
            catch (Exception ex)
            {
                Response.Write(ex);
                Response.Write("no such deal id");
            }
            finally
            {
                conn.Close();
            }
        } 
    }
}