using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for CronogramaSafraContaOrdem
/// </summary>
public class CronogramaSafraContaOrdem
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public CronogramaSafraContaOrdem()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
	}

    #region Métodos

    public string Incluir(int cdCronogramaSafraSEQ, int cdCooperativaSEQ, int cdIndicadorContaOrdem, string wkCooperativaContaOrdem, int cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            //Consistências
            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }            

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaContaOrdem");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_CooperativaContaOrdem";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCooperativaContaOrdemSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaContaOrdemSEQ"].Value = (object)DBNull.Value;            

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;
                        
            loSqlCommand.Parameters.Add("@cdIndicadorContaOrdem", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorContaOrdem"].Value = cdIndicadorContaOrdem.Equals(0) ? (object)DBNull.Value : cdIndicadorContaOrdem;
                        
            loSqlCommand.Parameters.Add("@wkCooperativaContaOrdem", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCooperativaContaOrdem"].Value = string.IsNullOrEmpty(wkCooperativaContaOrdem) ? (object)DBNull.Value : wkCooperativaContaOrdem;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCooperativaContaOrdem");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(int cdCooperativaContaOrdemSEQ, int cdIndicadorContaOrdem, string wkCooperativaContaOrdem, int cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            //Consistências
            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaContaOrdem");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_CooperativaContaOrdem";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCooperativaContaOrdemSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaContaOrdemSEQ"].Value = cdCooperativaContaOrdemSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaContaOrdemSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = (object)DBNull.Value;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = (object)DBNull.Value;
                        
            loSqlCommand.Parameters.Add("@cdIndicadorContaOrdem", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorContaOrdem"].Value = cdIndicadorContaOrdem.Equals(0) ? (object)DBNull.Value : cdIndicadorContaOrdem;

            loSqlCommand.Parameters.Add("@wkCooperativaContaOrdem", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCooperativaContaOrdem"].Value = string.IsNullOrEmpty(wkCooperativaContaOrdem) ? (object)DBNull.Value : wkCooperativaContaOrdem;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraVencimento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }
    
    public DataTable ObterLista(Int64 cdCronogramaSafraSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaContaOrdem", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;


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

    public DataTable Obter(Int64 cdCooperativaContaOrdemSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaContaOrdem", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaContaOrdemSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaContaOrdemSEQ"].Value = cdCooperativaContaOrdemSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaContaOrdemSEQ;


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

    public int ObterTipoProduto(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaContaOrdem", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        if (!loDataTable.Rows.Count.Equals(0))
        {
            return Convert.ToInt32(loDataTable.Rows[0]["cdTipoProduto"]);
        }
        else
        {
            return 0;
        }

        
    }

    public string Excluir(Int64 cdCronogramaSafraVencimentoSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;
   

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCronogramaSafraContaOrdem");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_CronogramaSafraContaOrdem";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCooperativaContaOrdemSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaContaOrdemSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraContaOrdem");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public bool Existe(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaContaOrdemExiste", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;


        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        return Convert.ToBoolean(loDataTable.Rows[0][0]);       
        
    }

    public bool ExisteCarga(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaContaOrdemExisteCarga", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;


        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        return Convert.ToBoolean(loDataTable.Rows[0][0]);

    }

    public bool ExistePedido(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaContaOrdemPedidoExiste", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;


        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        return Convert.ToBoolean(loDataTable.Rows[0][0]);       
        
    }

    

    #endregion Métodos
}
