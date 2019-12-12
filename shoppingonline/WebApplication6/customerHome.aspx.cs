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
    public partial class customerHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ViewProducts(object sender, EventArgs e)
        {
            Response.Redirect("productsForCustomer.aspx", true);

        }

        protected void createWishList(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string name = wishname.Text;
            cmd.Parameters.Add(new SqlParameter("@name", name));
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("passed");
            }
            catch (Exception ex)
            {
                Response.Write("name of wishlist already exists");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void AddToWishList(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("AddToWishList", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string name = wishnameaddrem.Text;
            int product_no = Int32.Parse(productno.Text);
            cmd.Parameters.Add(new SqlParameter("@wishlistname", name));
            cmd.Parameters.Add(new SqlParameter("@serial", product_no));
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("Passed");
            }
            catch (Exception ex)
            {
                Response.Write("wrong serial_no or wishlist name or customer name");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void removeFromWishList(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("removeFromWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string name = wishnameaddrem.Text;
            string product_no = productno.Text;
            cmd.Parameters.Add(new SqlParameter("@wishlistname", name));
            cmd.Parameters.Add(new SqlParameter("@serial", product_no));
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("Passed");
            }
            catch (Exception ex)
            {
                Response.Write("wrong serial_no or wishlist name or customer name");
            }
            finally
            {
                conn.Close();
            }

        }

        protected void AddCreditCard(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string credit_no = creditno.Text;
            string expiry_date = exdate.Text;
            string cvv = ccvv.Text;
            cmd.Parameters.Add(new SqlParameter("@creditcardnumber", credit_no));
            cmd.Parameters.Add(new SqlParameter("@cvv", cvv));
            cmd.Parameters.Add(new SqlParameter("@expirydate", expiry_date));
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("Passed");
            }
            catch (Exception ex)
            {
               
                Response.Write("invalid credit card");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void AddToCart(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("addToCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string product_no = proincart.Text;
            cmd.Parameters.Add(new SqlParameter("@serial", product_no));
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            SqlCommand cmd2 = new SqlCommand("checkpro", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@serialno", product_no));
            SqlParameter exists = cmd2.Parameters.Add("@exists", SqlDbType.Int);
            exists.Direction = ParameterDirection.Output;
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                cmd2.ExecuteNonQuery();
                if (exists.Value.ToString().Equals("1"))
                    Response.Write("Passed");
                else
                    Response.Write("not available");
            }
            catch (Exception ex)
            {
                Response.Write("wrong serial_no ");

            }
            finally
            {
                conn.Close();
            }
        }

        protected void removeFromCart(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("removefromCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            int product_no = Int32.Parse(proincart.Text);

            cmd.Parameters.Add(new SqlParameter("@serial", product_no));

            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("Passed");
            }
            catch (Exception ex)
            {
                Response.Write("wrong serial_no or wishlist name or customer name");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void addTelephone(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string mobile_number = telephone.Text;

            cmd.Parameters.Add(new SqlParameter("@mobile_number", mobile_number));

            cmd.Parameters.Add(new SqlParameter("@username", Session["username"]));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("Passed");
            }
            catch (Exception ex)
            {
                Response.Write("mobile number already exists");
            }
            finally
            {
                conn.Close();
            }

        }

        protected void makeOrder(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("makeOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            SqlCommand cmd2 = new SqlCommand("latestOrder", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            SqlParameter id = cmd2.Parameters.Add("@orderid", SqlDbType.Int);
            id.Direction = ParameterDirection.Output;

            SqlCommand cmd3 = new SqlCommand("calculatepriceOrder", conn);
            cmd3.CommandType = CommandType.StoredProcedure;
            cmd3.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            SqlParameter price = cmd3.Parameters.Add("@sum", SqlDbType.Decimal);
            price.Direction = ParameterDirection.Output;


            try
            {
                conn.Open();
                cmd3.ExecuteNonQuery();
                cmd.ExecuteNonQuery();
                cmd2.ExecuteNonQuery();
                Response.Write(""+ price.Value.ToString());
                Response.Write("order id is " + id.Value.ToString() + " and the total price is " + price.Value.ToString()); 


            }
            catch (Exception ex)
            {

                Response.Write("empty cart");
                Response.Write(ex);
            }
            finally
            {
                conn.Close();
            }
        }
        protected void DiffPaymentMethods(object sender, EventArgs e)
        {//Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("specifyamount", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            int ordrid = Int32.Parse(orderid.Text);
            Decimal cashh = Decimal.Parse(cash.Text);
            Decimal creditt = Decimal.Parse(credit.Text);

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@orderID", ordrid));
            cmd.Parameters.Add(new SqlParameter("@cash", cashh));
            cmd.Parameters.Add(new SqlParameter("@credit", creditt));
            //Save the output from the procedure

            //Executing the SQLCommand
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                Response.Write("Done");
            }
            catch (Exception ex)
            {
                Response.Write("invalid orderId");
            }
            finally
            {

                conn.Close();
            }

        }
        protected void PayWithCreditCard(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("ChooseCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            int orderid = Int32.Parse(orderid2.Text);
            string creditcard = creditcardnum.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@orderid", orderid));
            cmd.Parameters.Add(new SqlParameter("@creditcard", creditcard));
            SqlParameter ou = cmd.Parameters.Add("@out", SqlDbType.Decimal);
            ou.Direction = ParameterDirection.Output;
            //Save the output from the procedure


            //Executing the SQLCommand
            conn.Open();
            try
            { cmd.ExecuteNonQuery();
                if (ou.Value.ToString().Equals("1"))
                Response.Write("Done ha eh tany?");
                else
                {
                    Response.Write("msh nafe3 ha eh tany?");
                }
            }
            catch (Exception ex)
            {
                Response.Write("invalid order id or creditcard number");
            }
            finally
            {

                conn.Close();
            }


        }

        protected void CancelOrder(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("cancelorder", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            int orderid = Int32.Parse(orderid3.Text);


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@orderid", orderid));


            //Save the output from the procedure


            //Executing the SQLCommand
            conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                Response.Write("Done");
            }
            catch (Exception ex)
            {
                Response.Write("invalid order id");
            }
            finally
            {
                conn.Close();
            }

        }
    }
}