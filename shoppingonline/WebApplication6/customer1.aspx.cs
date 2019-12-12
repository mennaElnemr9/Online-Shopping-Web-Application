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
    public partial class customer1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void createWishList(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user

            string name = wishname.Text;

            // CHECK IF SAME USERNAME OF SESSION
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@name", name));

            //Save the output from the procedure


            //Executing the SQLCommand
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Write("success");
            }
            catch (Exception)
            {

                Response.Write("name of wishlist already exists");
            }
            finally
            {
                conn.Close();
            }

        }
    }
}