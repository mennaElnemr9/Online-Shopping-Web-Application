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
    public partial class vendor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void postProduct(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("postProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string product_name = name.Text;
            string color = color_txt.Text;
            string description = description_txt.Text;
            string category = category_txt.Text;
            decimal price = decimal.Parse(price_txt.Text);
            cmd.Parameters.Add(new SqlParameter("@vendorUsername", Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@color", color));
            cmd.Parameters.Add(new SqlParameter("@price", price));
            cmd.Parameters.Add(new SqlParameter("@product_description", description));
            cmd.Parameters.Add(new SqlParameter("@category", category));
            cmd.Parameters.Add(new SqlParameter("@product_name", product_name));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("Passed");
            }
            catch (Exception ex)
            {
                Response.Write("wrong vendor username");
            }
            finally
            {
                conn.Close();
            }
        }



        protected void goToVendorsProducts(object sender, EventArgs e)
        {
            Response.Redirect("productsForVendor.aspx", true);
        }

        protected void EditProduct(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("EditProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string product_name = name.Text;
            string color = color_txt.Text;
            string description = description_txt.Text;
            string category = category_txt.Text;
            int serial = Int32.Parse(serial_no_txt.Text);
            decimal price = decimal.Parse(price_txt.Text);
            cmd.Parameters.Add(new SqlParameter("@vendorname", Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@color", color));
            cmd.Parameters.Add(new SqlParameter("@price", price));
            cmd.Parameters.Add(new SqlParameter("@product_description", description));
            cmd.Parameters.Add(new SqlParameter("@category", category));
            cmd.Parameters.Add(new SqlParameter("@product_name", product_name));
            cmd.Parameters.Add(new SqlParameter("@serialnumber", serial));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("Passed");
            }
            catch (Exception ex)
            {
                Response.Write(ex);
                Response.Write("wrong serial number");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void AddOffer(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            int amount = Int32.Parse(offeramount.Text);
            DateTime expiry = DateTime.Parse(expirydate.Text);

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@offeramount", amount));
            cmd.Parameters.Add(new SqlParameter("@expiry_date", expiry));

            try
            {

                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("Done");
            }
            catch (Exception ex)
            {
                Response.Write("invalid expiry date or offer amount");

            }
            finally
            {
                conn.Close();
            }


        }

        protected void ApplyOffer(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("applyOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlCommand cmd1 = new SqlCommand("checkOfferonProduct", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            //To read the input from the user
            int id = Int32.Parse(offerid.Text);
            int serialno = Int32.Parse(serialnum.Text);

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@offerid", id));
            cmd.Parameters.Add(new SqlParameter("@serial", serialno));
            cmd.Parameters.Add(new SqlParameter("@vendorname", Session["username"]));

            cmd1.Parameters.Add(new SqlParameter("@serial", serialno));
            SqlParameter active = cmd1.Parameters.Add("@active", SqlDbType.Bit);
            active.Direction = ParameterDirection.Output;
            //Executing the SQLCommand
            conn.Open();
            try
            {
                cmd1.ExecuteNonQuery();

                if (active.Value.ToString().Equals("True"))
                {
                    Response.Write("an offer already exists on this product");
                }
                else
                {
                    try
                    {
                        cmd.ExecuteNonQuery();
                        Response.Write("Done");
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex);
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("invalid serial number or offer id ");
            }
            finally
            {
                conn.Close();
            }

        }

        protected void RemoveOffer(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("checkandremoveExpiredoffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            int id = Int32.Parse(removeid.Text);


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@offerid", id));


            //Save the output from the procedure
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("invalid offer id");
            }
            finally
            {

                conn.Close();
            }

            //Executing the SQLCommand
        }
    }
}