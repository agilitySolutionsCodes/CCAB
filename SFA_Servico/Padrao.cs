using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SFA_Servico
{
    public class Padrao
    {
        public string ObterStringConexao()
        {
            return System.Configuration.ConfigurationSettings.AppSettings["STRING_CONEXAO"];
        }

        public string ObterTempoRepeticao()
        {
            return System.Configuration.ConfigurationSettings.AppSettings["TEMPO_REPETICAO"];
        }

        public string ObterNomePessoaEnvio()
        {
            return System.Configuration.ConfigurationSettings.AppSettings["NOME_PESSOA_ENVIO"];
        }

        public string ObterEmailPessoaEnvio()
        {
            return System.Configuration.ConfigurationSettings.AppSettings["EMAIL_PESSOA_ENVIO"];
        }
    }
}
