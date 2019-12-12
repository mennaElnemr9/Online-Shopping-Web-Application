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
    public partial class OrdersForAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("reviewOrders", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                decimal cash_amount = 0;
                decimal credit_amount = 0; string payment_type = ""; int remaining_days = 0;
                int time_limit = 0;
                int delivery_id = 0;

                string creditCard_number = "";
                string GiftCardCodeUsed = "";
                decimal total_amount = 0;


                int order_no = (rdr.GetInt32(rdr.GetOrdinal("order_no")));
                try
                {
                 total_amount = rdr.GetDecimal(rdr.GetOrdinal("total_amount"));

                }catch(Exception ex)
                {
                    total_amount = 0;
                }
                try
                {
                    cash_amount = rdr.GetDecimal(rdr.GetOrdinal("cash_amount"));
                }
                catch(Exception ex)
                {
                    cash_amount= 0;
                }
                try
                {
                    credit_amount = rdr.GetDecimal(rdr.GetOrdinal("credit_amount"));
                }
                catch(Exception ex)
                {
                    credit_amount = 0;
                }
                DateTime order_date = rdr.GetDateTime(rdr.GetOrdinal("order_date"));
                try
                {
                 payment_type = rdr.GetString(rdr.GetOrdinal("payment_type"));
                }
                catch(Exception ex)
                {
                    payment_type = "no payment method";
                }
                try
                {
                    remaining_days = (rdr.GetInt32(rdr.GetOrdinal("remaining_days")));
                }
                catch (Exception ex)
                {
                    remaining_days = 0;
                }
                try
                {

                  time_limit = (rdr.GetInt32(rdr.GetOrdinal("time_limit")));
                }
                catch (Exception ex)
                {
                    time_limit = 0;
                }
                try
                {
                    delivery_id = (rdr.GetInt32(rdr.GetOrdinal("delivery_id")));
                }
                catch (Exception ex)
                {
                    delivery_id = 0;
                }
                try
                {
                    creditCard_number = rdr.GetString(rdr.GetOrdinal("creditCard_number"));
                }
                catch (Exception ex)
                {

                   creditCard_number = "no credit card num";
                }
                try
                {

                    GiftCardCodeUsed = rdr.GetString(rdr.GetOrdinal("GiftCardCodeUsed"));
                }
                catch (Exception ex)
                {

                    GiftCardCodeUsed = "no gift card used";
                }
                string order_status = rdr.GetString(rdr.GetOrdinal("order_status"));
           
                string customer_name = rdr.GetString(rdr.GetOrdinal("customer_name"));
                




                //Create a new label and add it to the HTML form
                Label lbl_order_no = new Label();
                lbl_order_no.Text = "order no. is " + order_no + "  ";
                form1.Controls.Add(lbl_order_no);
                Label lbl_total_amount = new Label();
                lbl_total_amount.Text = "total amount is " + total_amount + "  ";
                form1.Controls.Add(lbl_total_amount);
                Label lbl_cash_amount = new Label();
                lbl_cash_amount.Text = "cash_amount is " + cash_amount + "  ";
                form1.Controls.Add(lbl_cash_amount);
                Label lbl_credit_amount = new Label();
                lbl_credit_amount.Text = "credit_amount is  " + credit_amount + "  ";
                form1.Controls.Add(lbl_credit_amount);
                Label lbl_order_date = new Label();
                lbl_order_date.Text = "order_date is " + order_date + "  ";
                form1.Controls.Add(lbl_order_date);
                Label lbl_payment_type = new Label();
                lbl_payment_type.Text = "payment_type " + payment_type + "  ";
                form1.Controls.Add(lbl_payment_type);
                Label lbl_order_status = new Label();
                lbl_order_status.Text = "order_status is " + order_status + "  ";
                form1.Controls.Add(lbl_order_status);
                Label lbl_remaining_days = new Label();
                lbl_remaining_days.Text = "remaining_days is " + remaining_days + "  ";
                form1.Controls.Add(lbl_remaining_days);
                Label lbl_time_limit = new Label();
                lbl_time_limit.Text = "time_limit is " + time_limit + "  ";
                form1.Controls.Add(lbl_time_limit);
                Label lbl_customer_name = new Label();
                lbl_customer_name.Text = "customer_name is " + customer_name + "  ";
                form1.Controls.Add(lbl_customer_name);
                Label lbl_delivery_id = new Label();
                lbl_delivery_id.Text = "delivery_id is " + delivery_id + "  ";
                form1.Controls.Add(lbl_delivery_id);
                Label lbl_creditCard_number = new Label();
                lbl_creditCard_number.Text = "creditCard_number is " + creditCard_number + "  ";
                form1.Controls.Add(lbl_creditCard_number);
                Label lbl_GiftCardCodeUsed = new Label();
                lbl_GiftCardCodeUsed.Text = "GiftCardCodeUsed is " + GiftCardCodeUsed + "  <br /> <br />";
                form1.Controls.Add(lbl_GiftCardCodeUsed);


            }
        }
        protected void goToAdminHome(object sender, EventArgs e)
        {
            Response.Redirect("adminHome.aspx");
        }
    }
}