using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections;
using System.IO;
using System.Xml;
using System.Web;
/// <summary>
namespace TestArtSell
{
    public class CDA
    {
        Hashtable connTable = new Hashtable();
        SqlConnection myConnection = null;
        SqlCommand cmd = null;
        SqlDataAdapter adapter = null;
        DataSet ds = null;

        //HttpRequest Request = HttpContext.Current.Request;

        public CDA()
        {
            //I deleted the IP,User Id ,Password for security reason. 

            //Production
            //connTable.Add("SMFM", "Data Source = IP address; Initial Catalog = artsell8_master; User Id = user; Password =password; ");

            //Local 
            connTable.Add("SMFM", "Data Source = IP address; Initial Catalog = artsell8_master; User Id = user; Password =password; ");
        }
        public string RawConnectionStr()
        {
            //Use for Where HashTable Connection is not used => Audio.aspx,MISmstr.aspx
            //const string ConStr = "Data Source = DESKTOP - T3UHU88\\SHAHRIER; Initial Catalog = SMFM; User ID = USER_ID; Password = PASSWORD; ";
            const string ConStr = "Data Source = 103.48.119.185,61645; Initial Catalog = DB_Artsell; User Id = artsell; Password =$qF7t51i; ";

            return ConStr;
        }

        public SqlDataReader getList(string query, string dbName)
        {
            myConnection = new SqlConnection(connTable[dbName].ToString());
            SqlCommand cmd = new SqlCommand(query, myConnection);
            SqlDataReader dr;
            myConnection.Open();
            dr = cmd.ExecuteReader();
            cmd = null;
            return dr;

        }

        public string ExecuteNonQuery(string query, string dbName)
        {

            string rValue;
            myConnection = new SqlConnection(connTable[dbName].ToString());
            try
            {
                using (SqlConnection connection = new SqlConnection(connTable[dbName].ToString()))
                {
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        try
                        {
                            rValue = cmd.ExecuteNonQuery().ToString();
                        }
                        catch (Exception e)
                        {
                            //ErrorLog(e.Message.ToString(), query);
                            rValue = e.Message;
                            connection.Close();
                        }

                        if (rValue != "-1")
                            rValue = rValue;
                        else throw new Exception();
                    }
                }
            }
            catch (Exception ex)
            {
                //ErrorLog(ex.Message.ToString(), query);
                rValue = ex.Message;
            }

            return rValue;



        }

        public object getSingleValue(string query, string dbName)
        {
            //setting = ConfigurationManager.ConnectionStrings[dbName];
            myConnection = new SqlConnection(connTable[dbName].ToString());

            try
            {
                cmd = new SqlCommand(query, myConnection);
                myConnection.Open();
                object retValue = cmd.ExecuteScalar();
                return retValue;
            }
            catch (Exception ex)
            {

                //ErrorLog(ex.Message.ToString(), query);
                return (object)ex.Message.ToString();
            }
            finally
            {
                myConnection.Close();
                cmd = null;
                myConnection = null;
                query = null;
                dbName = null;
            }
        }

        public DataSet GetDataSet(string query, string dbName)
        {
            myConnection = new SqlConnection(connTable[dbName].ToString());

            ds = new DataSet();
            try
            {
                using (SqlConnection connection = new SqlConnection(connTable[dbName].ToString()))
                {
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {

                        adapter = new SqlDataAdapter();
                        cmd.CommandTimeout = 5000;
                        connection.Open();
                        adapter.SelectCommand = cmd;
                        try
                        {

                            adapter.Fill(ds);

                        }
                        catch (Exception e)
                        {
                            //ErrorLog(e.Message.ToString(), query);
                            ds = null;
                            connection.Close();
                        }
                        if (ds.Tables[0].Rows.Count == 0)
                        {
                            ds = null;
                        }
                    }
                }
            }
            catch (Exception e)
            {
                //ErrorLog(e.Message.ToString(), query);
                ds = null;
            }
            return ds;




        }
    }
}