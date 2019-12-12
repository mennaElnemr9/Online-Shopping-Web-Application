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
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LogIn(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string user = username.Text;
            string pass = password.Text;
            cmd.Parameters.Add(new SqlParameter("@username", user));
            cmd.Parameters.Add(new SqlParameter("@password", pass));
            Session["username"] = user;
            //Save the output from the procedure
            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;
            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;
            conn.Open();
            cmd.ExecuteNonQuery();
            
            if (success.Value.ToString().Equals("0"))
                Response.Write("wrong username or password");
            else
            {
                if (type.Value.ToString().Equals("0"))
                    Response.Redirect("customerHome.aspx", true);
                // use the type to redirect to the page wanted
                if (type.Value.ToString().Equals("1"))
                {
                    SqlCommand cmd1 = new SqlCommand("activatedV", conn);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    
                    cmd1.Parameters.Add(new SqlParameter("@user", Session["username"]));
                    SqlParameter exists = cmd1.Parameters.Add("@active", SqlDbType.Int);
                    exists.Direction = ParameterDirection.Output;
                    cmd1.ExecuteNonQuery();
                    conn.Close();
                    try
                    {
                        if (exists.Value.ToString().Equals("0"))
                            Response.Write("sorry, you are not activated yet :(");
                        else
                            Response.Redirect("vendor.aspx", true);
                    }
                    catch(Exception ex)
                    {
                        Response.Write(ex);
                        Response.Write("sorry, you are not activated yet :(");

                    }
                }

                // use the type to redirect to the page wanted
                if (type.Value.ToString().Equals("2"))
                    Response.Redirect("adminHome.aspx", true);
                // use the type to redirect to the page wanted
            }
        }


        protected void goToRegister(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx", true);


        }
    }
}