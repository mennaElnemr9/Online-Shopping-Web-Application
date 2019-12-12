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
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void cRegister(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("customerRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string user = username.Text;
            string pass = password.Text;
            string email = emailtext.Text;

            try
            {
                cmd.Parameters.Add(new SqlParameter("@username", user));
                cmd.Parameters.Add(new SqlParameter("@first_name", ""));
                cmd.Parameters.Add(new SqlParameter("@last_name", ""));
                cmd.Parameters.Add(new SqlParameter("@password", pass));
                cmd.Parameters.Add(new SqlParameter("@email", email));

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Write("Passed");
            }
            catch (Exception ex)
            {
                Response.Write("username already exists:S");
                conn.Close();

            }


        }

        protected void vRegister(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("vendorRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string user = username.Text;
            string pass = password.Text;
            string email = emailtext.Text;

            try
            {
                cmd.Parameters.Add(new SqlParameter("@username", user));
                cmd.Parameters.Add(new SqlParameter("@password", pass));
                cmd.Parameters.Add(new SqlParameter("@first_name", ""));
                cmd.Parameters.Add(new SqlParameter("@last_name", ""));
                cmd.Parameters.Add(new SqlParameter("@email", email));
                cmd.Parameters.Add(new SqlParameter("@company_name", ""));
                cmd.Parameters.Add(new SqlParameter("@bank_acc_no",""));
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Write("Passed");

            }
            catch (Exception ex)
            {
                Response.Write(ex);
                conn.Close();
                Response.Write("username already exists try another one :S");
            }
        }

        protected void goToLogin(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx", true);
        }
    }
}