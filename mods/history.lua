recordname = {}
recordurl = {}
save=false
Historyrecordname = ''
Historyrecordurl = ''

function 初始化历史记录数据(userdata1,userdata2)
  if (userdata2==nil)then
    userdata2=''
  end
  Historyrecordname = userdata2..'name'
  Historyrecordurl = userdata2..'url'
  save=userdata1
  if (save==true)then
    loadrecord(recordname,recordurl)
  else
    cleanrecord()
  end
end

function cleanrecord()
  this.getSharedPreferences(Historyrecordname,0).edit().clear().commit()
  this.getSharedPreferences(Historyrecordurl,0).edit().clear().commit()
end

function addrecord1(table1,table2,num)
  for i=1,num do
    table.remove(table1,1)
    table.remove(table2,1)
  end
  table1[#table1+1]=webView.getTitle()
  table2[#table2+1]=webView.getUrl()
end

function addrecord2(table1,table2)
  table1[#table1+1]=webView.getTitle()
  table2[#table2+1]=webView.getUrl()
end

function saverecord(table1,table2)
  if (save==true)then
    cleanrecord()
    for i,v in ipairs(table1)do
      this.getSharedPreferences(Historyrecordname,0).edit().putString(tostring(i),table1[i]).apply()
      this.getSharedPreferences(Historyrecordurl,0).edit().putString(tostring(i),table2[i]).apply()
    end
  end
end

function addrecord(num)
  if (num==nil)then
    addrecord(recordname,recordurl)
  else
    if (#recordname>=num)then
      local k=#recordname-num+1
      addrecord1(recordname,recordurl,k)
    else
      addrecord2(recordname,recordurl)
    end
  end
  saverecord(recordname,recordurl)
end

function loadrecord(table1,table2)
  for d in each(this.getSharedPreferences(Historyrecordname,0).getAll().entrySet()) do
    table1[tonumber(d.getKey())]=d.getValue()
  end
  for d in each(this.getSharedPreferences(Historyrecordurl,0).getAll().entrySet()) do
    table2[tonumber(d.getKey())]=d.getValue()
  end
end

function 反向数据(add)
  local acc={}
  for i,v in ipairs(add)do
    acc[#add+1-i]=v
  end
  for i,v in ipairs(acc)do
    add[i]=v
  end
end

function 展示历史记录()
  if (save==true)then
    loadrecord(recordname,recordurl)
  end
  local recordn=recordname
  local recordu=recordurl
  local h2='5dp'
  local w1='0dp'
  反向数据(recordn)
  反向数据(recordu)
  if (#recordn~=0)then
    h2='2dp'
    w1='400dp'
  end
  local oldviewlayout={
    LinearLayout,
    id='caa',
    orientation='1',
    gravity='left',
    clickable=true,
    focusable=true,
    background=backgroundc,
    style='?android:attr/buttonBarButtonStyle',
    layout_width='wrap_content',
    layout_height='wrap_content',
    {
      TextView,
      text='',
      gravity='left',
      layout_width='wrap_content',
      background='#000000',
      layout_height='2dp',},
    {
      ListView,
      id='oldview',
      layout_width='match_parent',
      layout_height='wrap_content',
    },
  }
  local historyrecord=AlertDialog.Builder(activity)
  .setTitle("历史")
  .setView(loadlayout(oldviewlayout))
  .create()
  local item={
    GridLayout,
    layout_width='match_parent',
    rowCount="1",
    columnCount="2",
    {
      ImageView,
      src='res/history.png',
      layout_gravity='center',
      colorFilter=secondaryc,
      adjustViewBounds='true',
      maxHeight='25dp',
      maxWidth='25dp',
      layout_width='wrap_content',
      layout_height='match_parent',
      layout_column='0',
    },
    {
      TextView,
      id='text',
      textColor=textc,
      textSize='15sp',
      layout_margin='12dp',
      layout_column='1',
      layout_width='match_parent'
    },
  }
  local data={}
  for n=1,#recordn do
    table.insert(data,{
      text={
        Text=recordn[n], 
      }, 
    })
  end
  local adp=LuaAdapter(activity,data,item)
  oldview.Adapter=adp
  caa.setOnClickListener(View.OnClickListener {onClick = function(s)
    end
  })
  historyrecord.show()
  oldview.onItemClick=function(l,v,c,b)
    加载网页(recordu[b])
    historyrecord.dismiss()
    return true
  end
end

function 添加历史记录(num)
  if (save==true)then
    loadrecord(recordname,recordurl)
  end
  local url=webView.getUrl()
  for i,v in ipairs(recordurl)do
    if (v==url)then
      table.remove(recordname,i)
      table.remove(recordurl,i)
      break
    end
  end
  addrecord(num)
end

function 清除历史记录(name)
  local Historyname = name..'name'
  local Historyurl = name..'url'
  this.getSharedPreferences(Historyname,0).edit().clear().commit()
  this.getSharedPreferences(Historyurl,0).edit().clear().commit()
  recordname={}
  recordurl={}
end