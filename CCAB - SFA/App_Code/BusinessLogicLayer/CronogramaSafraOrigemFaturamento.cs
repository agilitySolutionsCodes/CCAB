using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for CronogramaSafraOrigemFaturamento
/// </summary>
public class CronogramaSafraOrigemFaturamento
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public CronogramaSafraOrigemFaturamento()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
	}

    #region Métodos

    public string Incluir(int cdCronogramaSafraSEQ, int cdCooperativaSEQ, int cdOrigemFaturamentoSEQ, int cdIndicadorSituacaoOrigemFaturamento, string wkCooperativaOrigemFaturamento, int cdUsuarioUltimaAlteracao)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaOrigemFaturamento");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_CooperativaOrigemFaturamento";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCooperativaOrigemFaturamentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaOrigemFaturamentoSEQ"].Value = (object)DBNull.Value;            

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;
                        
            loSqlCommand.Parameters.Add("@cdOrigemFaturamentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdOrigemFaturamentoSEQ"].Value = cdOrigemFaturamentoSEQ.Equals(0) ? (object)DBNull.Value : cdOrigemFaturamentoSEQ;
                        
            loSqlCommand.Parameters.Add("@wkCooperativaOrigemFaturamento", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCooperativaOrigemFaturamento"].Value = string.IsNullOrEmpty(wkCooperativaOrigemFaturamento) ? (object)DBNull.Value : wkCooperativaOrigemFaturamento;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdIndicadorSituacaoOrigemFaturamento", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorSituacaoOrigemFaturamento"].Value = cdIndicadorSituacaoOrigemFaturamento;
            
            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCooperativaOrigemFaturamento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(int cdCooperativaOrigemFaturamentoSEQ, int cdOrigemFaturamentoSEQ, string wkCooperativaOrigemFaturamento, int cdUsuarioUltimaAlteracao, int cdIndicadorSituacaoOrigemFaturamento)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaOrigemFaturamento");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_CooperativaOrigemFaturamento";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCooperativaOrigemFaturamentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaOrigemFaturamentoSEQ"].Value = cdCooperativaOrigemFaturamentoSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaOrigemFaturamentoSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = (object)DBNull.Value;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = (object)DBNull.Value;
                        
            loSqlCommand.Parameters.Add("@cdOrigemFaturamentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdOrigemFaturamentoSEQ"].Value = (object)DBNull.Value;

            loSqlCommand.Parameters.Add("@wkCooperativaOrigemFaturamento", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCooperativaOrigemFaturamento"].Value = string.IsNullOrEmpty(wkCooperativaOrigemFaturamento) ? (object)DBNull.Value : wkCooperativaOrigemFaturamento;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdIndicadorSituacaoOrigemFaturamento", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorSituacaoOrigemFaturamento"].Value = cdIndicadorSituacaoOrigemFaturamento;
                        
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
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaOrigemFaturamento", loSqlConnection);

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

    public DataTable ObterLista(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaOrigemFaturamento", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;


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

    public DataTable Obter(Int64 cdCooperativaOrigemFaturamentoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaOrigemFaturamento", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaOrigemFaturamentoSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaOrigemFaturamentoSEQ"].Value = cdCooperativaOrigemFaturamentoSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaOrigemFaturamentoSEQ;


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
            loSqlTransaction = loSqlConnection.BeginTransaction("TrOrigemFaturamento");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_CronogramaSafraOrigemFaturamento";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCooperativaOrigemFaturamentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaOrigemFaturamentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrOrigemFaturamento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public bool Existe(int cdCronogramaSafraSEQ, int cdCooperativaSEQ, int cdOrigemFaturamentoSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaOrigemFaturamentoExiste", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdOrigemFaturamentoSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdOrigemFaturamentoSEQ"].Value = cdOrigemFaturamentoSEQ.Equals(0) ? (object)DBNull.Value : cdOrigemFaturamentoSEQ;


        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        return Convert.ToBoolean(loDataTable.Rows[0][0]);       
        
    }

    public bool ExistePedido(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaOrigemFaturamentoPedidoExiste", loSqlConnection);

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

    

    #endregion Métodos
}
