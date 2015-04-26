<Script language="JavaScript">
    function MyGetData()//OCX读卡成功后的回调函数
    {	//aname.value = GT2ICROCX.get_Name();//<-- 姓名--!>
        aname.value = GT2ICROCX.Name;//<-- 姓名--!>
        namel.value = GT2ICROCX.NameL;//<-- 姓名--!>
        sex.value = GT2ICROCX.Sex;//<-- 性别--!>
        sexl.value = GT2ICROCX.SexL;//<-- 性别--!>
        nation.value = GT2ICROCX.Nation;//<-- 民族--!>
        nationl.value = GT2ICROCX.NationL;//<-- 民族--!>
        born.value = GT2ICROCX.Born;//<-- 出生--!>
        bornl.value = GT2ICROCX.BornL;//<-- 出生--!>
        address.value = GT2ICROCX.Address;//<-- 地址--!>
        cardno.value = GT2ICROCX.CardNo;//<-- 卡号--!>
        police.value = GT2ICROCX.Police;//<-- 发证机关--!>
        activity.value = GT2ICROCX.Activity;//<-- 有效期--!>
        activitylfrom.value = GT2ICROCX.ActivityLFrom;//<-- 有效期--!>
        activitylto.value = GT2ICROCX.ActivityLTo;//<-- 有效期--!>
        photo.value = GT2ICROCX.GetPhotoBuffer();

        //jpgPhotoFace1.value = GT2ICROCX.GetFaceJpgBase64(0);//双面
        //jpgPhotoFace1.value = GT2ICROCX.GetFaceJpgBase64(1);//正面
        //jpgPhotoFace2.value = GT2ICROCX.GetFaceJpgBase64(2);//反面
    }

    function MyClearData()//OCX读卡失败后的回调函数
    {
        aname.value = "";
        namel.value = ""
        sex.value = "";
        sexl.value = "";
        nation.value = "";
        nationl.value = "";
        born.value = "";
        bornl.value = "";
        address.value = "";
        cardno.value = "";
        police.value = "";
        activity.value = "";
        activitylfrom.value = "";
        activitylto.value = "";
        photo.value = "";
        jpgPhotoFace1.value =  "";
        jpgPhotoFace2.value =  "";
    }

    function MyGetErrMsg()//OCX读卡消息回调函数
    {
        Status.value = GT2ICROCX.ErrMsg;
    }

    function StartRead()//开始读卡
    {
        GT2ICROCX.PhotoPath = "c:"

        GT2ICROCX.Start() //循环读卡

        //单次读卡(点击一次读一次)

        //if (GT2ICROCX.GetState() == 0){
        //	GT2ICROCX.ReadCard()
        //}
    }

    function print()//打印
    {
        GT2ICROCX.PrintFaceImage(0,30,10)//0 双面，1 正面，2 反面
    }


</Script>

<SCRIPT LANGUAGE=javascript FOR=GT2ICROCX EVENT=GetData>//设置回调函数
MyGetData()
</SCRIPT>

<SCRIPT LANGUAGE=javascript FOR=GT2ICROCX EVENT=GetErrMsg>//设置回调函数
MyGetErrMsg()
</SCRIPT>

<SCRIPT LANGUAGE=javascript FOR=GT2ICROCX EVENT=ClearData>//设置回调函数
MyClearData()
</SCRIPT>

<TITLE>测试</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
</HEAD>
<BODY style="BGCOLOR=#FFFFFF  LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0">
<TABLE WIDTH=768 BORDER=1 align="center" CELLPADDING=0 CELLSPACING=0 >
	<tr>
		<td height="60" align="center" colspan="2"><font size="4" face="黑体">二代身份证读卡器测试页面</font>
		</td>
	</tr>
	<tr>
		<td width="650" >
			<table width="650" border="0" cellpadding="0" cellspacing="0" >
				<tr>
					<td height="40" >
						Name：<input type=text name=aname size=20 maxlength=20>
						NameL：<input type=text name=namel size=20 maxlength=20>
					</td>
				</tr>
				<tr>
					<td height="40" >
						Sex：<input type=text name=sex size=5 maxlength=5>
						SexL：<input type=text name=sexl size=5 maxlength=5>
					</td>
				</tr>
				<tr>
					<td height="40" >
						Nation：<input type=text name=nation size=20 maxlength=20>
						NationL：<input type=text name=nationl size=20 maxlength=20>
					</td>
				</tr>
				<tr>
					<td height="40" >
						Born：<input type=text name=born size=20 maxlength=20>
						BornL：<input type=text name=bornl size=20 maxlength=20>
					</td>
				</tr>
				<tr>
					<td height="40" >
						Address：<input type=text name=address size=50 maxlength=50>
					</td>
				</tr>
				<tr>
					<td height="40" >
						CardNo：<input type=text name=cardno size=50 maxlength=50>
					</td>
				</tr>
				<tr>
					<td height="40" >
						Police：<input type=text name=police size=50 maxlength=50>
					</td>
				</tr>
				<tr>
					<td height="40" >
						Activity：<input type=text name=activity size=50 maxlength=50>
					</td>
				</tr>
				<tr>
					<td height="40" >
						ActivityLFrom：<input type=text name=activitylfrom size=50 maxlength=50>
					</td>
				</tr>
				<tr>
					<td height="40" >
						ActivityLTo：<input type=text name=activitylto size=50 maxlength=50>
					</td>
				</tr>
				<tr>
					<td height="40" >
						Photo：<input type=text name=photo size=50 maxlength=50>
					</td>
				</tr>

				<tr>
					<td height="40" >
						jpgPhotoFace1：<input type=text name=jpgPhotoFace1 size=50 maxlength=50>
					</td>
				</tr>

				<tr>
					<td height="40" >
						jpgPhotoFace2：<input type=text name=jpgPhotoFace2 size=50 maxlength=50>
					</td>
				</tr>
				<tr>
					<td height="40" >
						Status：<input type=text name=Status size=50 maxlength=50>
					</td>
				</tr>
			</table>
		</td>

		<td width="112" align="center">
			<OBJECT Name="GT2ICROCX" width="102" height="126"
			CLASSID="CLSID:220C3AD1-5E9D-4B06-870F-E34662E2DFEA"
			CODEBASE="IdrOcx.cab#version=1,0,1,2">
			</OBJECT>
			<input type="button" value="读卡" onClick="StartRead();">

			<input type="button" value="打印" onClick="print();">
		</td>

	</tr>

	<tr>
		<td   colspan=2 height="34" align="center" valign="middle" background="images/main_192.gif">
			<font color="#000000"><br>版权所有 &copy;2000-2006 深圳市国腾电子有限公司</font>
			</td>
	</tr>
	<tr>
		<td  colspan=2 height="25" align="center">&nbsp;
			Tel:(028)87825723&nbsp; &nbsp;
			Fax:(028)87825734 &nbsp; &nbsp;
			Email:<a href="mailto:szgoldtel@guoteng.com.cn" class="linkla">szgoldtel@guoteng.com.cn</a>
		</td>
	</tr>
</table>
</BODY>
</HTML>
