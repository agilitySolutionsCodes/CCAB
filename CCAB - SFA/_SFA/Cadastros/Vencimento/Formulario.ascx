<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Formulario.ascx.cs" Inherits="_SFA_Vencimento_Formulario" %>
<!-- Cabeçalho Formulário -->

<script type="text/javascript" src="../../../scripts/JScript.js"></script>


<!-- Preparação da PopUp Modal que exibirá o Formulário (Permite que o formulário seja arrastado pela tela) -->
<asp:Button runat="server" ID="btShowPanel1" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btShowPanel1"
    PopupControlID="Panel1" PopupDragHandleControlID="Panel1DragHandle" BackgroundCssClass="modalBackground" />
    
<div class="pageSection">
    <asp:Panel runat="Server" ID="Panel1DragHandle" CssClass="drag">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="tbTitulo_bordaEsquerda">
                    &nbsp;
                </td>
                <td class="tbTitulo_BG">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="180" class="tbTitulo_NomeTela" align="left">
                                <asp:Label runat="server" SkinID="normal" ID="lbOperacao" />
                            </td>
                            <td width="*">
                                <asp:Image ID="Image2" runat="server" Width="18" Height="36" ImageAlign="Right" ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                            </td>
                            <td width="335" class="tbTitulo_NomeTela" align="left">
                                <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="tbTitulo_bordaDireita">
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
</div>
<!-- Área de Mensagens -->
<div>
    <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
        ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
        runat="server" />
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>
<!-- Formulário -->
<div>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="cdCronogramaSafraVencimentoSEQ" CellPadding="5"
        AutoGenerateRows="false" Width="100%" GridLines="None">
        
        <EditItemTemplate>
            <div class="pageSection">
                <asp:HiddenField ID="cdCronogramaSafraSEQ" runat="server" />
                <asp:HiddenField ID="cdCronogramaSafraVencimentoSEQ" runat="server" Value='<%# Bind("cdCronogramaSafraVencimentoSEQ") %>' />
                <asp:HiddenField ID="cdUsuarioUltimaAlteracao" runat="server" />
                
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbCadastro_Mestra">
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Nome da Safra:
                        </td>
                        <td class="tdCamposFormularios" colspan="4">
                            <asp:Label ID="dsCronogramaSafra" runat="server" 
                                SkinID="data" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Tipo de Vencimento:
                        </td>
                        <td colspan="4">
                            <asp:UpdatePanel ID="UpdateVencimento" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td style="vertical-align: middle; text-align:left" class="fonteTbCadastro">
                                                <asp:RadioButtonList runat="server" ID="RadioButtonList1" AutoPostBack="true" 
                                                    OnSelectedIndexChanged="RadioButtonListSelectedIndexChanged"
                                                    DataValueField="vrDominioCodigoReferenciado" OnPreRender="RadioButtonListInit"
                                                    DataTextField="wkDominioCodigoReferenciado" RepeatDirection="Horizontal"  
                                                    DataSourceID="ObjectDataSource1" CssClass="fonteTbCadastro" />
                                                    <asp:HiddenField ID="cdTipoCronogramaSafraVencimento" runat="server" Value='<%# Bind("cdTipoCronogramaSafraVencimento") %>' />
                                            </td>
                                            <td>
                                                <asp:Panel ID="Panel9" runat="server" Visible="false">
                                                    <conv:TextBox Type="Date" ID="dtCronogramaSafraVencimento" 
                                                        runat="server" ValidationGroup="Form"
                                                        CssClass="campoTexto" Text='<%# Bind("dtCronogramaSafraVencimento", "{0:dd/MM/yyyy}") %>' />
                                                    <asp:Label ID="Label2" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                                                    <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator2" runat="server" 
                                                        Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                                        ErrorMessage="Data de Vencimento é campo obrigatório"
                                                        ControlToValidate="dtCronogramaSafraVencimento" />
                                                    <asp:CompareValidator Display="None" id="CompareValidator2" runat="server" ValidationGroup="Form" 
                                                        Operator="DataTypeCheck" Type="Date" Text="*" ForeColor="#f6f6f6" EnableClientScript="true" 
                                                        ErrorMessage="Data de Vencimento informada não é válida" 
                                                        ControlToValidate="dtCronogramaSafraVencimento" />
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                    </table> 
                                </ContentTemplate>
                            </asp:UpdatePanel> 
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            % Correção Preço:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="4" ID="pcCorrecaoPrecoTipoCulturaVencimento" runat="server" ValidationGroup="Form"  
                                Columns="8" MaxLength="8" CssClass="campoTexto" Text='<%# Bind("pcCorrecaoPrecoTipoCulturaVencimento", "{0:##0.0000}") %>' />
                        </td>
                        <td>
                            <%-- <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator1" runat="server" ErrorMessage="% Correção Preço deve ser digitado mesmo sendo zero"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="pcCorrecaoPrecoTipoCulturaVencimento" /> --%>
                            <asp:CompareValidator Display="None" ID="CompareValidator1" runat="server" ErrorMessage="O valor máximo para [% Correção Preço] é 999,9999" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="pcCorrecaoPrecoTipoCulturaVencimento" ValueToCompare="999,9999" SetFocusOnError="true" Type="Double" Operator="LessThanEqual" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            &nbsp;
                        </td>
                        <td class="tdCamposFormularios">
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>

                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            % Desconto Pontualidade:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="4" ID="pcDescontoPontualidade" runat="server" ValidationGroup="Form"  
                                Columns="8" MaxLength="8" CssClass="campoTexto" Text='<%# Bind("pcDescontoPontualidade", "{0:##0.0000}") %>' />
                        </td>
                        <td>
                            <%-- <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator1" runat="server" ErrorMessage="% Correção Preço deve ser digitado mesmo sendo zero"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="pcCorrecaoPrecoTipoCulturaVencimento" /> --%>
                            <asp:CompareValidator Display="None" ID="CompareValidator3" runat="server" ErrorMessage="O valor máximo para [% Desconto Pontualidade] é 100,0000" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="pcDescontoPontualidade" ValueToCompare="100,0000" SetFocusOnError="true" Type="Double" Operator="LessThanEqual" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            &nbsp;
                        </td>
                        <td class="tdCamposFormularios">
                            &nbsp;
                        </td>
                        <td>
                        </td>
                    </tr>

                    
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Observação:
                        </td>
                        <td class="tdCamposFormularios" colspan="4">
                            <conv:TextBox Type="Text" ID="wkCronogramaSafraVencimento" runat="server" ValidationGroup="Form"
                                Columns="50" Rows="5" TextMode="MultiLine" onkeyup="blocTexto(this, 255)" CssClass="campoTexto" Text='<%# Bind("wkCronogramaSafraVencimento") %>' />
                        </td>
                        <td></td>
                    </tr>
                </table>
                
                <br />
                
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbCadastro_Mestra">
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            % Parcela 1:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="2" ID="pcParcela1CronogramaSafraVencimento" runat="server" ValidationGroup="Form"  
                                Columns="8" MaxLength="8" CssClass="campoTexto" Text='<%# Bind("pcParcela1CronogramaSafraVencimento", "{0:##0.00}") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Vencimento Parcela 1:*
                        </td>
                        <td class="tdCamposFormularios">
						    <asp:TextBox id="dtParcela1CronogramaSafraVencimento" runat="server" 
                                MaxLength="10" Height="15" 
                                Width="80px" CssClass="campoTexto" onkeypress="MascararData(this);" 
                                onblur="MascararData(this);"
                                Text='<%# Bind("dtParcela1CronogramaSafraVencimento", "{0:dd/MM/yyyy}") %>'></asp:TextBox>

                        </td>
                        <td>
                        </td>
                    </tr>  
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            % Parcela 2:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="2" ID="pcParcela2CronogramaSafraVencimento" runat="server" ValidationGroup="Form"  
                                Columns="8" MaxLength="8" CssClass="campoTexto" Text='<%# Bind("pcParcela2CronogramaSafraVencimento", "{0:##0.00}") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Vencimento Parcela 2:
                        </td>
                        <td class="tdCamposFormularios">
						    <asp:TextBox id="dtParcela2CronogramaSafraVencimento" runat="server" 
                                MaxLength="10" Height="15" 
                                Width="80px" CssClass="campoTexto" onkeypress="MascararData(this);" 
                                onblur="MascararData(this);"
                                Text='<%# Bind("dtParcela2CronogramaSafraVencimento", "{0:dd/MM/yyyy}") %>'></asp:TextBox>

                        </td>
                        <td>
                        </td>
                    </tr>  
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            % Parcela 3:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="2" ID="pcParcela3CronogramaSafraVencimento" runat="server" ValidationGroup="Form"  
                                Columns="8" MaxLength="8" CssClass="campoTexto" Text='<%# Bind("pcParcela3CronogramaSafraVencimento", "{0:##0.00}") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Vencimento Parcela 3:
                        </td>
                        <td class="tdCamposFormularios">
						    <asp:TextBox id="dtParcela3CronogramaSafraVencimento" runat="server" 
                                MaxLength="10" Height="15" 
                                Width="80px" CssClass="campoTexto" onkeypress="MascararData(this);" 
                                onblur="MascararData(this);"
                                Text='<%# Bind("dtParcela3CronogramaSafraVencimento", "{0:dd/MM/yyyy}") %>'></asp:TextBox>

                        </td>
                        <td>
                        </td>
                    </tr>  
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            % Parcela 4:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="2" ID="pcParcela4CronogramaSafraVencimento" runat="server" ValidationGroup="Form"  
                                Columns="8" MaxLength="8" CssClass="campoTexto" Text='<%# Bind("pcParcela4CronogramaSafraVencimento", "{0:##0.00}") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Vencimento Parcela 4:
                        </td>
                        <td class="tdCamposFormularios">
						    <asp:TextBox id="dtParcela4CronogramaSafraVencimento" runat="server" 
                                MaxLength="10" Height="15" 
                                Width="80px" CssClass="campoTexto" onkeypress="MascararData(this);" 
                                onblur="MascararData(this);"
                                Text='<%# Bind("dtParcela4CronogramaSafraVencimento", "{0:dd/MM/yyyy}") %>'></asp:TextBox>

                        </td>
                        <td>
                        </td>
                    </tr>  
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            % Parcela 5:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="2" ID="pcParcela5CronogramaSafraVencimento" runat="server" ValidationGroup="Form"  
                                Columns="8" MaxLength="8" CssClass="campoTexto" Text='<%# Bind("pcParcela5CronogramaSafraVencimento", "{0:##0.00}") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Vencimento Parcela 5:
                        </td>
                        <td class="tdCamposFormularios">
						    <asp:TextBox id="dtParcela5CronogramaSafraVencimento" runat="server" 
                                MaxLength="10" Height="15" 
                                Width="80px" CssClass="campoTexto" onkeypress="MascararData(this);" 
                                onblur="MascararData(this);"
                                Text='<%# Bind("dtParcela5CronogramaSafraVencimento", "{0:dd/MM/yyyy}") %>'></asp:TextBox>

                        </td>
                        <td>
                        </td>
                    </tr>  
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            % Parcela 6:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Numeric" DecimalPlaces="2" ID="pcParcela6CronogramaSafraVencimento" runat="server" ValidationGroup="Form"  
                                Columns="8" MaxLength="8" CssClass="campoTexto" Text='<%# Bind("pcParcela6CronogramaSafraVencimento", "{0:##0.00}") %>' />
                        </td>
                        <td>
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Vencimento Parcela 6:
                        </td>
                        <td class="tdCamposFormularios">
						    <asp:TextBox id="dtParcela6CronogramaSafraVencimento" runat="server" 
                                MaxLength="10" Height="15" 
                                Width="80px" CssClass="campoTexto" onkeypress="MascararData(this);" 
                                onblur="MascararData(this);"
                                Text='<%# Bind("dtParcela6CronogramaSafraVencimento", "{0:dd/MM/yyyy}") %>'></asp:TextBox>

                        </td>
                        <td>
                        </td>
                    </tr>  
                    
                    
                    
                </table>
                
                
            </div>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                <SelectParameters>
                    <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORTIPOVENCIMENTO" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </EditItemTemplate>          
    </asp:FormView>
    <div style="text-align: right;">
        <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
            CausesValidation="true" OnCommand="btAction_OnClick" />
        <asp:Button runat="server" ID="btCancel" CommandName="Cancel" CssClass="button" Text="cancelar" 
            CausesValidation="false" OnCommand="btCancel_OnClick" />
    </div>

</div>

