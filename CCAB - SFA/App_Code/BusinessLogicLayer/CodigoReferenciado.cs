using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for CodigoReferenciado
/// </summary>
public class CodigoReferenciado
{

    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares


    public CodigoReferenciado()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }


    #region Métodos

    public DataTable ObterLista(string dsDominioCodigoReferenciado)
    {

        try
        {

            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CodigoReferenciado", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@dsDominioCodigoReferenciado", SqlDbType.VarChar, 70);
            loSqlDataAdapter.SelectCommand.Parameters["@dsDominioCodigoReferenciado"].Value = dsDominioCodigoReferenciado;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable Obter(string dsDominioCodigoReferenciado, int vrDominioCodigoReferenciado)
    {

        try
        {

            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_CodigoReferenciado", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@dsDominioCodigoReferenciado", SqlDbType.VarChar, 70);
            loSqlDataAdapter.SelectCommand.Parameters["@dsDominioCodigoReferenciado"].Value = dsDominioCodigoReferenciado;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@vrDominioCodigoReferenciado", SqlDbType.Int);
            loSqlDataAdapter.SelectCommand.Parameters["@vrDominioCodigoReferenciado"].Value = vrDominioCodigoReferenciado;


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    #endregion Métodos
}
