using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Usuario
/// </summary>
public class Usuario
{
    #region Propriedades

    public Int64 cdUsuario { get; set; }
    public string nmUsuario { get; set; }
    public int cdPerfilUsuario { get; set; }
    public string dsPerfilUsuario { get; set; }
    public int cdIndicadorTipoAcessoPessoa { get; set; }
    public int cdIndicadorPessoa { get; set; }
    public string dsLoginPessoa { get; set; }

    #endregion Propriedades
    
    public Usuario()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}
