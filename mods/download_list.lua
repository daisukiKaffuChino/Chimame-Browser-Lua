function 下载内容()
  fav_btnColor=转0x(secondaryc)
  layout={
    LinearLayout;
    layout_height="fill";
    orientation="vertical";
    layout_width="fill";
    background=backgroundc;
    {
      LinearLayout;
      layout_height="5dp";
      layout_width="fill";
      background=backgroundc;
    },
    {
      LinearLayout;
      layout_height="wrap";
      layout_width="fill";
      orientation="horizontal";
      gravity="center|left";
      {
        TextView;
        textSize="11sp";
        text="保存路径:/storage/emulated/0/Download/";
        layout_marginLeft="24dp";
        textColor=stextc;
        Typeface=字体("product");
      };
    },

    {
      ListView;
      layout_height="fill";
      id="文件list";
      layout_width="fill";
      DividerHeight=0;
    };
  };
  maindl=AlertDialog.Builder(this)
  .setTitle("下载内容")
  .setView(loadlayout(layout))
  .setPositiveButton("关闭",function(v)
  end)
  .create()
  local dl =maindl.show()
  local pw=maindl.getWindow()
  .setGravity(Gravity.BOTTOM)
  弹窗圆角(pw,转0x(backgroundc))
  local lp=pw.getAttributes()
  lp.width=this.width
  pw.setAttributes(lp)
  pw.setDimAmount(0.35)
  maindl.show()
  setDlBtnColor(maindl)
  itemcc={
    LinearLayout;
    layout_width="fill";
    orientation="vertical";
    background=backgroundc;
    {
      LinearLayout;
      layout_width="fill";
      layout_height="wrap";
      orientation="vertical";
      {
        LinearLayout;
        layout_width="fill";
        layout_height="wrap";
        orientation="horizontal";
        {
          ImageView;
          layout_width="6%h";
          layout_gravity="center";
          id="icon";
          padding="4dp";
          layout_marginLeft="4%w";
          layout_height="6%h";
        };
        {
          TextView;
          text="name";
          id="name";
          layout_height="wrap";
          textColor=textc;
          layout_marginRight="5dp";
          layout_gravity="center";
          Typeface=字体("product");
        };
      };
      {
        LinearLayout;
        layout_width="fill";
        orientation="horizontal";
        layout_height="4%h";
        {
          TextView;
          layout_width="80%w";
          layout_gravity="left";
          id="xx";
          text="1969 96 97";
          layout_marginLeft="6%w";
          textColor=stextc;
          Typeface=字体("product");
        };
      };
    };
  }
  import "com.androlua.LuaUtil"
  function getMD5(path)
    return tostring(LuaUtil.getFileMD5(tostring(path)))
  end
  function GetFilelastTime(path)
    f = File(path);
    cal = Calendar.getInstance();
    time = f.lastModified()
    cal.setTimeInMillis(time);
    return cal.getTime().toLocaleString()
  end
  function GetFileSize(path)
    import "java.io.File"
    import "android.text.format.Formatter"
    size=File(tostring(path)).length()
    Sizes=Formatter.formatFileSize(activity, size)
    return Sizes
  end
  adpp=LuaAdapter(activity,itemcc)
  function show(f)
    dir=f
    adpp.clear()
    ls=luajava.astable(f.listFiles() or String{})
    table.sort(ls,function(a,b)
      return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
    end)
    for n=1,#ls do
      if ls[n].isDirectory() then
        adpp.add{icon="res/dir.png",name=ls[n].Name,xx=GetFilelastTime(tostring(ls[n]))}
      end
    end
    for n=1,#ls do
      if ls[n].isDirectory() then
       else
        adpp.add{icon="res/file.png",name=ls[n].Name,xx=GetFilelastTime(tostring(ls[n])).."  "..GetFileSize(tostring(ls[n]))}
      end
    end
  end
  文件list.Adapter=adpp
  import "java.io.File"
  thread(function()
    require "import"
    import "java.io.File"
    下载目录="/storage/emulated/0/Download/"
    call("show",File(下载目录))
  end)
  function OpenFile(path,文件类型)
    import "android.webkit.MimeTypeMap"
    import "android.content.Intent"
    import "android.net.Uri"
    import "java.io.File"
    FileName=tostring(File(path).Name)
    ExtensionName=FileName:match("%.(.+)")
    if 文件类型 then
      intent = Intent();
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      intent.setAction(Intent.ACTION_VIEW);
      intent.setDataAndType(Uri.fromFile(File(path)), 文件类型);
      activity.startActivity(intent);
     else
      提示("找不到可以用来打开此文件的程序")
    end
  end
  function 取文件后缀(filename)
    dot = String(filename).lastIndexOf('.');
    if ((dot >-1) and (dot < (#filename - 1))) then
      return String(filename).substring(dot + 1);
    end
    return "";
  end
  文件list.onItemClick=function(l,v,p,i)
    local path = tostring(ls[i])
    pop=PopupMenu(activity,v)
    menu=pop.Menu
    menu.add("打开").onMenuItemClick=function(a)
      local path = tostring(ls[i])
      local Type查询 = [[
<tdclass>.doc</td>
<td>application/msword</td>
<tdclass>.apk</td>
<td>application/vnd.android.package-archive</td>
<tdclass>.ipa</td>
<td>application/vnd.iphone</td>
<tdclass>.txt</td>
<td>text/plain</td>
<tdclass>.pdf</td>
<td>application/pdf</td>
<tdclass>.m4a</td>
<td>audio/mp4a-latm</td>
<tdclass>.mp3</td>
<td>audio/x-mpeg</td>
<tdclass>.flac</td>
<td>audio/x-mpeg</td>
<tdclass>.ape</td>
<td>audio/x-mpeg</td>
<tdclass>.mp4</td>
<td>video/mp4</td>
<tdclass>.ppt</td>
<td>application/vnd.ms-powerpoint</td>
<tdclass>.pptx</td>
<td>application/vnd.openxmlformats-officedocument.presentationml.presentation</td>
<tdclass>.rar</td>
<td>application/x-rar-compressed</td>
<tdclass>.rmvb</td>
<td>audio/x-pn-realaudio</td>
<tdclass>.swf</td>
<td>application/x-shockwave-flash</td>
<tdclass>.zip</td>
<td>application/zip</td>
<tdclass>.3gp</td>
<td>video/3gpp</td>
<tdclass>.docx</td>
<td>application/vnd.openxmlformats-officedocument.wordprocessingml.document</td>
<tdclass>.dwg</td>
<td>application/x-autocad</td>
<tdclass>.jpg</td>
<td>image/jpeg</td>
<tdclass>.jpeg</td>
<td>image/jpeg</td>
<tdclass>.png</td>
<td>image/png</td>
]]
      local 文件扩展名 = string.lower("."..取文件后缀(path))
      local 文件名位置 = string.find(Type查询, 文件扩展名)
      if 文件名位置 == -1 then
        return "application/octet-stream"
      end
      local mat = string.format("<tdclass>%s</td>\n<td>(.-)</td>", 文件扩展名)
      local 文件类型=string.match(Type查询,mat)
      OpenFile(path,文件类型)
    end
    menu.add("重命名").onMenuItemClick=function(a)
      oldname=tostring(File(path).Name)
      layout2={
        LinearLayout;
        layout_height="wrap";
        layout_width="85%w";
        background=backgroundc;
        orientation="vertical";
        {
          LinearLayout;
          layout_height="5dp";
          layout_width="fill";
          background=backgroundc;
        },
        {
          LinearLayout;
          layout_height="28dp";
          layout_width="fill";
          orientation="horizontal";
          Focusable=false,
          gravity="center|left";
          {
            TextView;
            textSize="13sp";
            text="原文件名："..oldname;
            layout_height="wrap";
            layout_width="80%w";
            Typeface=字体("product");
            gravity="center";
            layout_marginLeft="24dp";
          };
        },
        {
          LinearLayout;
          layout_height="wrap";
          layout_width="fill";
          Focusable=true,
          gravity="center",
          FocusableInTouchMode=true,
             {
      MEditText
      {
        textSize="14sp",
        id="new";
        hint="新文件名(注意后缀)";
        textColor=textc;
        HintTextColor=stextc;
        --SingleLine=true;
        layout_width="-1";
        layout_height="-2";
        --   text=source[id].js.text;
      };
      layout_margin="24dp";
      --layout_marginTop="16dp";
      layout_marginTop="16dp";
    };
        };
      }
      cmmdl=AlertDialog.Builder(this)
      .setTitle("重命名")
      .setView(loadlayout(layout2))
      .setPositiveButton("确定",function(v)
        newname=new.Text
        if new.Text~="" then
          import "java.io.File"
          newname="/storage/emulated/0/Download/"..new.text
          os.rename (path, newname)
          thread(function()
            require "import"
            import "java.io.File"
            Thread.sleep(100)
            call("show",File("/storage/emulated/0/Download/"))
          end)
         else
          提示("未输入")
        end
      end)
      .setNegativeButton("关闭",function(v)
      end)
      .create()
      local dl =cmmdl.show()
      local pw=cmmdl.getWindow()
      .setGravity(Gravity.BOTTOM)
      弹窗圆角(pw,转0x(backgroundc))
      local lp=pw.getAttributes()
      lp.width=this.width
      pw.setAttributes(lp)
      pw.setDimAmount(0.35)
      cmmdl.show()
      setDlBtnColor(cmmdl)
    end
    menu.add("删除文件").onMenuItemClick=function(a)
      local 文件名称=tostring(File(path).Name)


      scdl=AlertDialog.Builder(this)
      .setTitle("删除文件")
      .setMessage("确认要删除吗？源文件也将被一并删除。")
      .setPositiveButton("确定",{onClick=function(v)
          os.execute("rm -r "..path)
          提示("已删除")
          adpp.remove(p)
          adpp.notifyDataSetChanged()
        end})
      --.setNeutralButton("中立",nil)
      .setNegativeButton("我手滑了",nil)
      .create()
      local dl =scdl.show()
      local pw=scdl.getWindow()
      .setGravity(Gravity.BOTTOM)
      弹窗圆角(pw,转0x(backgroundc))
      local lp=pw.getAttributes()
      lp.width=this.width
      pw.setAttributes(lp)
      pw.setDimAmount(0.35)
      scdl.show()
      setDlBtnColor(scdl)



    end
    pop.show()
  end
end