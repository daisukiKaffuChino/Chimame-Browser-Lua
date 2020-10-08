--可供修改的设置↓
--收藏夹数据存储地址(可换为外部存储)
fav_ads="/data/data/"..activity.getPackageName().."/FavoritesData.lua" --文件名
--返回上级目录的项目的内容
fav_lastFolderItem=".."
--界面标题的颜色(默认蓝色)
fav_titleColor=转0x(primaryc)
--文件夹图标
fav_folderIcon="res/twotone_folder_special_black_24dp.png"
--收藏的图标
fav_favIcon="res/twotone_explore_black_24dp.png"
--文件夹栏的字体颜色(默认灰色)
fav_folderTextColor=0xFF404040
--收藏栏的字体颜色(默认灰色)
fav_favTextColor=0xFF404040
--非标题的字体大小
fav_textSize="16sp"
--对话框按钮颜色(默认蓝色)
fav_btnColor=转0x(secondaryc)


function 加载网页(a)
webView.loadUrl(a) 
end

--序列化
function slz(obj)
  local lua = ""
  local t = type(obj)
  if t == "number" then
    lua = lua .. obj
   elseif t == "boolean" then
    lua = lua .. tostring(obj)
   elseif t == "string" then
    lua = lua .. string.format("%q", obj)
   elseif t == "table" or t=="function" then
    lua = lua .. "{\n"
    for k, v in pairs(obj) do
      lua = lua .. "[" .. slz(k) .. "]=" .. slz(v) .. ",\n"
    end
    local metatable = getmetatable(obj)
    if metatable ~= nil and type(metatable.__index) == "table" then
      for k, v in pairs(metatable.__index) do
        lua = lua .. "[" .. slz(k) .. "]=" .. slz(v) .. ",\n"
      end
    end
    lua = lua .. "}"
   elseif t == "nil" then
    return nil
   else
    error("can not serialize a " .. t .. " type.")
  end
  return lua
end

--反序列化
function rslz(lua)
  local t = type(lua)
  if t == "nil" or lua == "" then
    return {}
   elseif t == "number" or t == "string" or t == "boolean" then
    lua = tostring(lua)
   else
    error("can not unserialize a " .. t .. " type.")
  end
  lua = "return " .. lua
  local func = loadstring(lua)
  if func == nil then
    return nil
  end
  return func()
end

--读取文件
function readData(fromAddress)
  import "java.io.File"
  File(fromAddress).createNewFile()
  local strData=io.open(fromAddress):read("*a")
  local data=rslz(strData)
  return data
end

--储存文件
function saveData(data,toAddress)
  local strData=slz(data)
  file=io.open(toAddress,"w+")
  io.output(file)
  io.write(strData)
  io.flush()
  io.close(file)
end

--读取收藏文件
function readFav()
  favList=readData(fav_ads)
end

--储存收藏文件
function saveFav()
  saveData(favList,fav_ads)
end

--判定项目是否为文件夹
function isFavFolder(isFolderList)
  if isFolderList["url"]==nil then
    return true
   else
    return false
  end
end

--列表排序，上移
function moveUpItem(movelist,b)
  local upItem=movelist[b]
  table.remove(movelist,b)
  table.insert(movelist,b-1,upItem)
end

--列表排序，下移
function moveDownItem(movelist,b)
  local downItem=movelist[b]
  table.remove(movelist,b)
  table.insert(movelist,b+1,downItem)
end

--根据索引返回表
function selectList(indexTable)
  local newList=favList
  for i=1,#indexTable do
    newList=newList[indexTable[i]]
    if type(newList)~="table" then
      break
    end
  end
  return newList
end

--索引数组关系比较
function isSameIndexs(indexs1,indexs2,num)
  if #indexs1==#indexs2 then
    local s=true
    for i=1,#indexs1 do
      s=s and (indexs1[i]==indexs2[i])
      if s==false then
        break
      end
    end
    return s
   elseif #indexs1<=#indexs2-1 then
    local t=true
    for i=1,#indexs1 do
      t=t and (indexs1[i]==indexs2[i])
      if t==false then
        break
      end
    end
    if num>indexs2[#indexs1+1] then
      t=false
    end
    if t==true then
      return "debug"
     else return false
    end
   else
    return false
  end
end

--拷贝数组
function cpyIndexs(index_a)
  local index_b={}
  for i=1,#index_a do
    table.insert(index_b,index_a[i])
  end
  return index_b
end

--配置图标和文字颜色
function chooseFavIcon(csiList,n)
  local icon=""
  if isFavFolder(csiList[n])==false then
    icon=fav_favIcon
   else
    icon=fav_folderIcon
  end
  return icon
end
function chooseFavColor(cscList,n)
  local clr=""
  if isFavFolder(cscList[n])==false then
    clr=fav_favTextColor
   else
    clr=fav_folderTextColor
  end
  return clr
end

--设置对话框样式
function setDlBtnColor(dl)
  dl.getButton(dl.BUTTON_POSITIVE).setTextColor(fav_btnColor)
  dl.getButton(dl.BUTTON_NEGATIVE).setTextColor(fav_btnColor)
  dl.getButton(dl.BUTTON_NEUTRAL).setTextColor(fav_btnColor)
end

--展示收藏夹
function showFav(favIndexs)
  import "android.widget.LinearLayout"
  import "android.widget.TextView"
  import "android.widget.ListView"
  import "android.app.AlertDialog"
  readFav()
  local listIndexs=favIndexs
  if listIndexs==nil then
    listIndexs={}
  end
  local nowList=selectList(listIndexs)
  fav_lv=ListView(activity).setDividerHeight(0)
  space1=TextView(activity)
  --fav_title=TextView(activity).setText("收藏夹").setTextSize(20)
  fav_path=TextView(activity).setGravity(1)
  FavLayout=LinearLayout(activity).setOrientation(1).addView(fav_path).addView(fav_lv)
  fav_dl=AlertDialog.Builder(activity)
  .setTitle("收藏夹")
  .setView(FavLayout)
  .setPositiveButton("取消",nil)
  .setNegativeButton("添加收藏",function()
    addFav(listIndexs)
  end)
  .setNeutralButton("新建文件夹",function()
    createFavFolder(listIndexs)
  end)
  .create()
  local dl =fav_dl.show()
    local pw=fav_dl.getWindow()
    .setGravity(Gravity.BOTTOM)
    弹窗圆角(pw,转0x(backgroundc))
    local lp=pw.getAttributes()
    lp.width=this.width
    pw.setAttributes(lp)
    pw.setDimAmount(0.35)
  fav_dl.show()
  setDlBtnColor(fav_dl)
  --获取文件夹路径
  function getFavPath(pathIndexs)
    local path=""
    if #pathIndexs~=0 then
      local pathNowIndex={}
      for i=1,#pathIndexs do
        table.insert(pathNowIndex,pathIndexs[i])
        path=path.."/"..selectList(pathNowIndex)["title"]
      end
    end
    return path
  end
  --项目布局
  favItem={
    LinearLayout,
    layout_width="match_parent",
    orientation="horizontal",
    paddingLeft="16dp",
    paddingRight="16dp",
    paddingTop="4dp",
    paddingBottom="4dp",
    {
      ImageView,
      id="fav_img",
      --adjustViewBounds="true",
      maxHeight="48dp",
      colorFilter=primaryc;
      maxWidth="48dp",
      layout_width="wrap_content",
      layout_height="match_parent",
      layout_marginBottom="6dp",
    },
    {
      TextView,
      id="fav_text",
      textSize=fav_textSize,
      layout_marginLeft="16dp",
      textColor=textc;
      Typeface=字体("product");
      layout_width="match_parent",
      layout_height="match_parent",
    },
  }
  --设置适配器
  function setFavItem(itemIndexs)
    readFav()
    fav_path.text=getFavPath(itemIndexs)
    local dataList=selectList(itemIndexs)
    local itemList={}
    for i=1,#dataList do
      table.insert(itemList,{
        fav_text={
          text=dataList[i]["title"],
          textColor=chooseFavColor(dataList,i),
        },
        fav_img={
          src=chooseFavIcon(dataList,i),
        },
      })
    end
    if #itemIndexs~=0 then
      table.insert(itemList,1,{
        fav_text={
          text=fav_lastFolderItem,
          textColor=fav_folderTextColor,
        },
        fav_img={
          src=fav_folderIcon,
        },
      })
    end
    fav_adp=LuaAdapter(activity,itemList,favItem)
    fav_lv.Adapter=fav_adp
  end
  --显示当前列表
  setFavItem(listIndexs)
  --列表点击事件
  fav_lv.onItemClick=function(l,v,p,s)
    local content=tostring(v.Tag.fav_text.text)
    --修正b
    local b=p+1
    if #listIndexs~=0 then
      b=p
    end
    --返回上级目录
    if content==fav_lastFolderItem then
      local indexNum=#listIndexs
      table.remove(listIndexs,indexNum)
      nowList=selectList(listIndexs)
      setFavItem(listIndexs)
      --进入子目录
     elseif isFavFolder(nowList[b])==true then
      local indexNum=#listIndexs
      listIndexs[indexNum+1]=b
      nowList=nowList[b]
      setFavItem(listIndexs)
      --直接加载网页
     elseif isFavFolder(nowList[b])==false then
      加载网页(nowList[b]["url"])
      fav_dl.hide()
    end
  end
  --列表长按事件
  fav_lv.onItemLongClick=function(l,v,p,s)
    local content=tostring(v.Tag.fav_text.text)
    local b=p+1
    if #listIndexs~=0 then
      b=p
    end
    if content~=fav_lastFolderItem then
      favPopWin(listIndexs,b)
    end
    return true
  end
end

--收藏编辑框布局
function editFavLayout(favTitle,favUrl)
  EditFavLayout={
    LinearLayout,
    orientation="1",
    Focusable=true,
    FocusableInTouchMode=true,
    {
        MEditText
        {
          textSize="14sp",
          id="ed_fav1";
          hint="填写标题";
          textColor=textc;
          HintTextColor=stextc;
          --SingleLine=true;
          layout_width="-1";
          layout_height="-2";
          text=favTitle,
        };
        layout_margin="24dp";
        --layout_marginTop="16dp";
        layout_marginBottom="0";
      };
    
    --[[
    {
        EditText,
        id="ed_fav1",
        text=favTitle,
        layout_marginTop="5dp",
        layout_width="80%w",
        layout_gravity="center",
      },
    --]]
  
    {
        MEditText
        {
          textSize="14sp",
          id="ed_fav2";
          hint="填写链接";
          textColor=textc;
          HintTextColor=stextc;
          --SingleLine=true;
          layout_width="-1";
          layout_height="-2";
          text=favUrl,
        };
        layout_margin="24dp";
        --layout_marginTop="16dp";
        layout_marginBottom="0";
      };
  }
end

--文件夹编辑框布局
function editFavFolderLayout(folderName)
  EditFavFolderLayout={
    LinearLayout,
    orientation="1",
    Focusable=true,
    FocusableInTouchMode=true,
  
    {
        MEditText
        {
          textSize="14sp",
          id="favFolder1";
          hint="文件夹名称";
          textColor=textc;
          HintTextColor=stextc;
          --SingleLine=true;
          layout_width="-1";
          layout_height="-2";
          text=folderName,
        };
        layout_margin="24dp";
        --layout_marginTop="16dp";
        layout_marginBottom="0";
      };
  }
end

--显示收藏编辑框
function showEditFav(editIndexs,b)
  editList=selectList(editIndexs)
  --收藏编辑
  if isFavFolder(editList[b])==false then
    local favTitle=editList[b]["title"]
    local favUrl=editList[b]["url"]
    editFavLayout(favTitle,favUrl)
    ed_fav_dl=AlertDialog.Builder(activity)
    .setTitle("编辑收藏")
    .setView(loadlayout(EditFavLayout))
    .setPositiveButton("确认",DialogInterface.OnClickListener{
      onClick=function()
        if (ed_fav1.text=="" or ed_fav2.text=="") then
          提示("请填写完整")
         else
          editList[b]["title"]=ed_fav1.text
          editList[b]["url"]=ed_fav2.text
          saveFav()
          提示("修改成功")
          ed_fav_dl.dismiss()
          setFavItem(editIndexs)
        end
      end})
    .setNegativeButton("取消",DialogInterface.OnClickListener{
      onClick=function()
      end})
    .setNeutralButton("删除",DialogInterface.OnClickListener{
      onClick=function()
        local ddl=AlertDialog.Builder(activity)
        .setMessage("确定要删除吗？")
        .setPositiveButton("确定",function()
          table.remove(editList,b)
          saveFav()
          提示("删除成功")
          ed_fav_dl.dismiss()
          setFavItem(editIndexs)
        end)
        .setNegativeButton("取消",nil)
        .create()
        .show()
        setDlBtnColor(ddl)
      end})
    .create()
    local dl =ed_fav_dl.show()
    local pw=ed_fav_dl.getWindow()
    .setGravity(Gravity.BOTTOM)
    弹窗圆角(pw,转0x(backgroundc))
    local lp=pw.getAttributes()
    lp.width=this.width
    pw.setAttributes(lp)
    pw.setDimAmount(0.35)
    ed_fav_dl.show()
    setDlBtnColor(ed_fav_dl)
   else
    --文件夹编辑
    local folderName=editList[b]["title"]
    editFavFolderLayout(folderName)
    ed_favFolder_dl=AlertDialog.Builder(activity)
    .setTitle("修改文件夹")
    .setView(loadlayout(EditFavFolderLayout))
    .setPositiveButton("保存",DialogInterface.OnClickListener{
      onClick=function()
        if (favFolder1.text=="") then
          提示("请填写完整")
         else
          editList[b]["title"]=favFolder1.text
          saveFav()
          提示("修改成功")
          setFavItem(editIndexs)
        end
      end})
    .setNegativeButton("取消",DialogInterface.OnClickListener{
      onClick=function()
      end})
    .setNeutralButton("删除",DialogInterface.OnClickListener{
      onClick=function()
        local ddl=AlertDialog.Builder(activity)
        .setMessage("确定要删除吗？")
        .setPositiveButton("确定",function()
          table.remove(editList,b)
          saveFav()
          提示("删除成功")
          setFavItem(editIndexs)
        end)
        .setNegativeButton("取消",nil)
        .create()
        .show()
        setDlBtnColor(ddl)
      end})
    .create()
    local dl =ed_favFolder_dl.show()
    local pw=ed_favFolder_dl.getWindow()
    .setGravity(Gravity.BOTTOM)
    弹窗圆角(pw,转0x(backgroundc))
    local lp=pw.getAttributes()
    lp.width=this.width
    pw.setAttributes(lp)
    pw.setDimAmount(0.35)
    ed_favFolder_dl.show()
    setDlBtnColor(ed_favFolder_dl)
  end
end

--新建文件夹
function createFavFolder(createIndexs)
  local folderName="新建文件夹"
  editFavFolderLayout(folderName)
  new_favFolder_dl=AlertDialog.Builder(activity)
  .setTitle("新建文件夹")
  .setView(loadlayout(EditFavFolderLayout))
  .setPositiveButton("保存",DialogInterface.OnClickListener{
    onClick=function()
      if (favFolder1.text=="") then
        提示("请填写完整")
        new_favFolder_dl.dismiss()
        showFav(createIndexs)
       else
        local newFolder={}
        newFolder["title"]=favFolder1.text
        table.insert(selectList(createIndexs),1,newFolder)
        saveFav()
        提示("创建成功")
        new_favFolder_dl.dismiss()
        showFav(createIndexs)
      end
    end})
  .setNegativeButton("取消",DialogInterface.OnClickListener{
    onClick=function()
      new_favFolder_dl.dismiss()
      showFav(createIndexs)
    end})
  .create()
  local dl =new_favFolder_dl.show()
    local pw=new_favFolder_dl.getWindow()
    .setGravity(Gravity.BOTTOM)
    弹窗圆角(pw,转0x(backgroundc))
    local lp=pw.getAttributes()
    lp.width=this.width
    pw.setAttributes(lp)
    pw.setDimAmount(0.35)  
  new_favFolder_dl.show()
  setDlBtnColor(new_favFolder_dl)
end

--长按弹窗
function favPopWin(popIndexs,popNum)
  local hod=popNum
  local popList=selectList(popIndexs)
  local win1="向上移动"
  local win2="编辑"
  local win3="剪切"
  local win4="向下移动"
  local wina={win1,win3,win2,win4}
  local winb={win3,win2,win4}
  local winc={win1,win2,win3}
  local wind={win3,win2}
  if #popList==1 then
    win=wind
   elseif hod==1 then
    win=winb
   elseif hod==#popList then
    win=winc
   else
    win=wina
  end
  local PopWinLayout={
    LinearLayout,
    orientation="vertical",
    {
      ListView,
      id="pop_win_lv",
      items=win,
      layout_width="fill_parent",
      layout_height="wrap_content",
      DividerHeight=0
    },
  }
  local pop_win_dl=AlertDialog.Builder(activity)
  .setView(loadlayout(PopWinLayout))
  .create()
  local dl =pop_win_dl.show()
    local pw=pop_win_dl.getWindow()
    .setGravity(Gravity.BOTTOM)
    弹窗圆角(pw,转0x(backgroundc))
    local lp=pw.getAttributes()
    lp.width=this.width
    pw.setAttributes(lp)
    pw.setDimAmount(0.35)  
  pop_win_dl.show()
  pop_win_lv.onItemClick=function(l,v,c,b)
    if win[b]==win1 then
      moveUpItem(popList,hod)
      saveFav()
      setFavItem(popIndexs)
     elseif win[b]==win2 then
      showEditFav(popIndexs,hod)
     elseif win[b]==win3 then
      moveFavToFolder(popIndexs,hod)
     elseif win[b]==win4 then
      moveDownItem(popList,hod)
      saveFav()
      setFavItem(popIndexs)
    end
    pop_win_dl.dismiss()
  end
end

--移动至文件夹
function moveFavToFolder(moveIndexs,moveNum)
  import "android.widget.LinearLayout"
  import "android.widget.TextView"
  import "android.widget.ListView"
  import "android.app.AlertDialog"
  readFav()
  local listIndexs2=cpyIndexs(moveIndexs)
  local nowList2=selectList(listIndexs2)
  fav2_lv=ListView(activity).setFastScrollEnabled(true)
  space2=TextView(activity)
  fav2_title=TextView(activity).setText("选择目录").setTextSize(30).setTextColor(fav_titleColor).setGravity(1)
  fav2_path=TextView(activity).setGravity(1)
  Fav2Layout=LinearLayout(activity).setOrientation(1).addView(fav2_path).addView(fav2_lv)
  fav2_dl=AlertDialog.Builder(activity)
  .setView(Fav2Layout)
  .setTitle("选择目录")
  .setPositiveButton("选择",function()
    if isSameIndexs(moveIndexs,listIndexs2,moveNum)=="debug" then
      local nlistIndexs2=cpyIndexs(listIndexs2)
      nlistIndexs2[#moveIndexs+1]=listIndexs2[#moveIndexs+1]-1
      local cpyItem=selectList(moveIndexs)[moveNum]
      table.remove(selectList(moveIndexs),moveNum)
      table.insert(selectList(nlistIndexs2),1,cpyItem)
      saveFav()
      fav_dl.dismiss()
      showFav(nlistIndexs2)
     else
      local cpyItem=selectList(moveIndexs)[moveNum]
      table.remove(selectList(moveIndexs),moveNum)
      table.insert(selectList(listIndexs2),1,cpyItem)
      saveFav()
      fav_dl.dismiss()
      showFav(listIndexs2)
    end
    提示("转移成功")
  end)
  .setNegativeButton("取消",nil)
  .create()
  local dl =fav2_dl.show()
    local pw=fav2_dl.getWindow()
    .setGravity(Gravity.BOTTOM)
    弹窗圆角(pw,转0x(backgroundc))
    local lp=pw.getAttributes()
    lp.width=this.width
    pw.setAttributes(lp)
    pw.setDimAmount(0.35)  
  fav2_dl.show()
  setDlBtnColor(fav2_dl)
  function setFavItem2(itemIndexs)
    readFav()
    fav2_path.text=getFavPath(itemIndexs)
    local dataList=selectList(itemIndexs)
    local itemList={}
    for i=1,#dataList do
      table.insert(itemList,{
        fav_text={
          text=dataList[i]["title"],
          textColor=chooseFavColor(dataList,i),
        },
        fav_img={
          src=chooseFavIcon(dataList,i),
        },
      })
    end
    if #itemIndexs~=0 then
      table.insert(itemList,1,{
        fav_text={
          text=fav_lastFolderItem,
          textColor=fav_folderTextColor,
        },
        fav_img={
          src=fav_folderIcon,
        },
      })
    end
    fav2_adp=LuaAdapter(activity,itemList,favItem)
    fav2_lv.Adapter=fav2_adp
  end
  setFavItem2(listIndexs2)
  --列表点击事件
  fav2_lv.onItemClick=function(l,v,p,s)
    local content=tostring(v.Tag.fav_text.Text)
    local b=p+1
    if #listIndexs2~=0 then
      b=p
    end
    if content==fav_lastFolderItem then
      local indexNum=#listIndexs2
      table.remove(listIndexs2,indexNum)
      nowList2=selectList(listIndexs2)
      setFavItem2(listIndexs2)
     elseif isFavFolder(nowList2[b])==true then
      local indexNum=#listIndexs2
      if isSameIndexs(moveIndexs,listIndexs2,moveNum)==true and moveNum==b then
        提示("不可以选定自身目录")
       else
        listIndexs2[indexNum+1]=b
        nowList2=nowList2[b]
        setFavItem2(listIndexs2)
      end
     elseif isFavFolder(nowList2[b])==false then
      提示("无法打开该目录")
    end
  end
end

--添加收藏
function addFav(adIndexs)
  readFav()
  local addIndexs=adIndexs
  if addIndexs==nil then
    addIndexs={}
  end
  local addList=selectList(addIndexs)
  function haveSameFav(samelist)
    local s=false
    for k,v in ipairs(samelist) do
      if isFavFolder(v)==false then
        s=s or v["url"]==webView.getUrl()
       else
        s=s or haveSameFav(v)
      end
      if s==true then
        break
      end
    end
    return s
  end
  if haveSameFav(favList)==true then
    提示("该网页已在收藏夹")
   else
    local favTitle=webView.getTitle()
    local favUrl=webView.getUrl()
    editFavLayout(favTitle,favUrl)
    add_fav_dl=AlertDialog.Builder(activity)
    .setTitle("添加收藏")
    .setView(loadlayout(EditFavLayout))
    .setPositiveButton("添加",DialogInterface.OnClickListener{
      onClick=function()
        if (ed_fav1.text=="" or ed_fav2.text=="") then
          提示("请填写完整")
         else
          table.insert(addList,1,{})
          addList[1]["title"]=ed_fav1.text
          addList[1]["url"]=ed_fav2.text
          saveFav()
          提示("已收藏")
        end
      end})
    .setNegativeButton("取消",DialogInterface.OnClickListener{
      onClick=function() end})
    .create()
    local dl =add_fav_dl.show()
    local pw=add_fav_dl.getWindow()
    .setGravity(Gravity.BOTTOM)
    弹窗圆角(pw,转0x(backgroundc))
    local lp=pw.getAttributes()
    lp.width=this.width
    pw.setAttributes(lp)
    pw.setDimAmount(0.35)
    add_fav_dl.show()
    setDlBtnColor(add_fav_dl)
  end
end




