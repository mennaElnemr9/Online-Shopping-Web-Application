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
    public partial class productsForCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("ShowProductsByPrice", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {

                int serial = (rdr.GetInt32(rdr.GetOrdinal("serial_no")));
                string product_name = rdr.GetString(rdr.GetOrdinal("product_name"));
                string category = rdr.GetString(rdr.GetOrdinal("category"));
                string product_description = rdr.GetString(rdr.GetOrdinal("product_description"));
                decimal price = rdr.GetDecimal(rdr.GetOrdinal("price"));
                decimal final_price = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                string color = rdr.GetString(rdr.GetOrdinal("color"));
                Boolean available = rdr.GetBoolean(rdr.GetOrdinal("available"));
                string vendor_username = rdr.GetString(rdr.GetOrdinal("vendor_username"));



                //Create a new label and add it to the HTML form
                Label lbl_serial = new Label();
                lbl_serial.Text = "serial no. is " + serial + "  ";
                form1.Controls.Add(lbl_serial);
                Label lbl_product_name = new Label();
                lbl_product_name.Text = "product name " + product_name + "  ";
                form1.Controls.Add(lbl_product_name);
                Label lbl_category = new Label();
                lbl_category.Text = "category is " + category + "  ";
                form1.Controls.Add(lbl_category);
                Label lbl_product_description = new Label();
                lbl_product_description.Text = "description " + product_description + "  ";
                form1.Controls.Add(lbl_product_description);
                Label lbl_price = new Label();
                lbl_price.Text = "price is " + price + "  ";
                form1.Controls.Add(lbl_price);
                Label lbl_final_price = new Label();
                lbl_final_price.Text = "final_price " + final_price + "  ";
                form1.Controls.Add(lbl_final_price);
                Label lbl_color = new Label();
                lbl_color.Text = "color is " + color + "  ";
                form1.Controls.Add(lbl_color);


                Label lbl_vendor_username = new Label();
                lbl_vendor_username.Text = "vendor_username " + vendor_username + "  <br /> <br />";
                form1.Controls.Add(lbl_vendor_username);


            }
        }
        protected void goToHome(object sender, EventArgs e)
        {
            Response.Redirect("customerHome.aspx", true);

        }
    }
}