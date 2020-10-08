require "import"
import "android.net.*"
import "android.content.*"
import "android.content.res.*"
import "android.graphics.drawable.*"
import "android.view.animation.*"
import "android.view.animation.Animation$AnimationListener"
import "android.graphics.*"
import "android.graphics.drawable.*"
import "android.view.WindowManager"
import "android.view.inputmethod.InputMethodManager"
import "android.view.KeyEvent"
import "android.webkit.WebView"
import "android.text.format.Formatter"
import "com.lua.*"
import "mods.control_function"
import "mods.history"
import "mods.ViewBitmapCapture"



function dpTopx(sdp)
  import "android.util.TypedValue"
  dm=this.getResources().getDisplayMetrics()
  types={px=0,dp=1,sp=2,pt=3,["in"]=4,mm=5}
  n,ty=sdp:match("^(%-?[%.%d]+)(%a%a)$")
  return TypedValue.applyDimension(types[ty],tonumber(n),dm)
end

function 转波纹(e)
  import 'android.content.res.ColorStateList'
  return (activity.Resources.getDrawable(activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless})
  .getResourceId(0,0)).setColor(ColorStateList(int[0].class{int{}},int{e}))
  .setColor(ColorStateList(int[0].class{int{}},int{e})))
end

function mSettings(view)
  view.getSettings().setDisplayZoomControls(false); --隐藏自带的右下角缩放控件
  view.getSettings().setSupportZoom(true); --支持网页缩放
  view.getSettings().setDomStorageEnabled(true); --dom储存数据
  view.getSettings().setDatabaseEnabled(true); --数据库
  view.getSettings().setAppCacheEnabled(true); --启用缓存
  view.getSettings().setUseWideViewPort(true);
  view.getSettings().setAllowFileAccess(true);--允许访问文件
  view.getSettings().setBuiltInZoomControls(true); --支持缩放
  view.getSettings().setLoadWithOverviewMode(true);
  view.getSettings().setLoadsImagesAutomatically(true);--图片自动加载
  view.getSettings().setSaveFormData(true); --保存表单数据，就是输入框的内容，但并不是全部输入框都会储存
  view.getSettings().setAllowContentAccess(true); --允许访问内容
  view.getSettings().setJavaScriptEnabled(true); --支持js脚本
  view.getSettings().supportMultipleWindows() --设置多窗口
  view.getSettings().setUseWideViewPort(true) --图片自适应
  view.setLayerType(View.LAYER_TYPE_HARDWARE,nil);--硬件加速
  view.getSettings().setPluginsEnabled(true)--支持插件
  view.getSettings().setCacheMode(view.getSettings().LOAD_NO_CACHE);--设置缓存加载方式
  view.getSettings().setLayoutAlgorithm(view.getSettings().LayoutAlgorithm.SINGLE_COLUMN)--支持重新布局
  view.getSettings().setGeolocationEnabled(true);--启用地理定位
  view.getSettings().setUseWideViewPort(true)--调整图片自适应
  view.getSettings().setJavaScriptCanOpenWindowsAutomatically(true); --//支持通过JS打开新窗口
  
  if activity.getSharedData("ua")==nil then
  view.getSettings().setUserAgentString(nil);
  else
  view.getSettings().setUserAgentString(activity.getSharedData("ua"));
  end
  
  view.removeView(view.getChildAt(0))--删除自带进度条
end

function showChoose()--显示布局


  WebViewlistPop=PopupWindow(activity)
  WebViewlistPop.setContentView(loadlayout("layout/dialoglist_layout"))
  WebViewlistPop.setWidth(-1)
  WebViewlistPop.setHeight(WindowManager.LayoutParams.MATCH_PARENT)
  WebViewlistPop.setOutsideTouchable(true)
  WebViewlistPop.setBackgroundDrawable(nil)
  WebViewlistPop.showAtLocation(view,Gravity.BOTTOM,0,0)

  function WebViewlistPopDismiss()
    listPopIn2.setBackgroundColor(0)
    listPopIn.setBackgroundColor(0)
    Translate_down=TranslateAnimation(0, 0, 0, dpTopx("160dp"))
    Translate_down.setDuration(200)
    listPopIn.startAnimation(Translate_down)
    Translate_down.setAnimationListener(AnimationListener{
      onAnimationEnd=function()
        WebViewlistPop.dismiss()
      end
    })
  end

  --开始动画
  Translate_up_down=TranslateAnimation(0, 0, dpTopx("160dp"), 0)
  Translate_up_down.setDuration(200)
  listPopIn.startAnimation(Translate_up_down)


  list.setAdapter(adp)--设置适配器

  local drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(0xFFFFFFFF)
  drawable.setCornerRadii({30,30,30,30,0,0,0,0})
  list.setBackgroundDrawable(drawable)

  list.onItemClick=function(l,v,p,i)
    for k,v in pairs(weblist) do--切换窗口
      if k==(p+1) then
        v.setVisibility(0)
       else
        v.setVisibility(8)
      end
    end
    WebViewlistPopDismiss()
  end
  list.onItemLongClick=function(l,v,p,i)
    if #weblist>1 then--当打开超过1个控件时，切换为为离这个控件最近的一个(向下)
      for k,v in pairs(weblist) do
        if k==p then
          v.setVisibility(0)
          webView=v--设置WebView
         else
          v.setVisibility(8)
        end
      end
    end
    提示("已删除 "..v.Tag.title.Text)
    --这里开始销毁WebView
    removeWebView(i)
    adp.notifyDataSetChanged()
    if adp.getCount()<1 then--没有标签页就new一个新的
      webview()--如果没有了标签页
    end
  end
end

function changeurltext(web,text)
  if web==visibilityweb[1] then--是否为当前显示的控件
    editext.setText(text)
  end
end

function changepar(web,text)
  if web==visibilityweb[1] then--是否为当前显示的控件
    if pbar.getVisibility()==8 then
      pbar.setVisibility(0)
    end
    if web.getProgress()>90 then
      pbar.setVisibility(8)
      visibilityweb[2]=false
     else
      pbar.incrementProgressBy(web.getProgress()-pbar.getProgress())
    end

  end
end
function getmWebChromeClient()
  import "com.lua.*"
  return LuaWebChrome(LuaWebChrome.IWebChrine{
    onCreateWindow=function(view,os,os2,os3)
      提示(view,os)
    end,
    onProgressChanged=function(v,p)

    end,
    onReceivedIcon=function(view,bmp)
      weblist2[weblist3[view.id]].icon={src=bmp}
    end,
    onReceivedTitle=function(view,text)
      if #view.getTitle()>1 then
        weblist2[weblist3[view.id]].title=view.getTitle()
        if view.getTitle()=="网页无法打开" then
          changeurltext(view,"啊哦,网页跑丢了_(:з」∠)_")
         else
          changeurltext(view,view.getTitle())
        end
       else
        changeurltext(view,view.getUrl())
      end
      sethistory(view.getTitle(),view.getUrl())
    end,
    onShowFileChooser=function(v,fic)
      uploadMessageAboveL=fic
      local intet = Intent(Intent.ACTION_GET_CONTENT);
      intet.addCategory(Intent.CATEGORY_OPENABLE);
      intet.setType("*/*");
      activity.startActivityForResult(Intent.createChooser(intet, "File Chooser"), 1);
      return true;
    end
  })
end

function getmWebViewClient()
  return {
    shouldOverrideUrlLoading=function(view,url)
      if view==visibilityweb[1] then
        visibilityweb[2]=true

      end
      changepar(view,0)
      changeurltext(view,url)
      if url:sub(1,4):find("http") or url:sub(1,4):find("www") then
        weblist2[weblist3[view.id]].title=url--更改url,下面的不写了
        adp.notifyDataSetChanged()
       else
        view.stopLoading()
        --  网页后退()--拦截打开app行为
      end
    end,

    onReceivedError=function(view,var2,var3,var4)
      weblist2[weblist3[view.id]].title="网页加载失败"
      adp.notifyDataSetChanged()
      pbar.setProgress(0)
      pbar.setVisibility(8)

    end,
    onLoadResource=function(view,url)
      添加历史记录(5000)
      changepar(view,p)
    end,
    onPageFinished=function(view,url)--这个回调非常坑
      webView.setDownloadListener{onDownloadStart=function(url,userAgent,contentDisposition,mimetype,contentLength)
          
          import "android.webkit.URLUtil"
          local 文件名=URLUtil.guessFileName(url, contentDisposition, mimeType);
          local 下载链接=url
          local 文件类型=mimetype
          local 文件大小=Formatter.formatFileSize(this, contentLength)
          三按钮对话框("下载确认",
          "文件名："..文件名.."\n文件类型："..文件类型.."\n文件大小："..文件大小.."\n下载链接："..下载链接,
          "下载",
          "复制链接",
          "取消",
          function()关闭对话框(an)
            if activity.getSharedData("Setting_ADM")=="true" then
              function adm(dlurl)
                this.startActivity(Intent().setAction("android.intent.action.SEND").setType("text/*").putExtra("android.intent.extra.TEXT", dlurl).setClassName("com.dv.adm.pay", "com.dv.adm.pay.AEditor"));
              end
              adm(下载链接)
             else
              downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
              url=Uri.parse(下载链接);
              request=DownloadManager.Request(url);
              request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
              request.setDestinationInExternalPublicDir("Download",文件名);
              request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
              downloadManager.enqueue(request);
              提示("已开始下载，请前往通知栏查看")
            end
          end,
          function()关闭对话框(an)复制文本(下载链接)提示("复制完毕")end,
          function()关闭对话框(an)end)
        end}
      getinfo()
      for i=1,#cont do
        if view.url:find(cont[i].url.text) or cont[i].url.text=="*" then
          加载脚本(view,cont[i].js.text)
        end
        if webView.url:find(cont[i].url.text) and cont[i].element.text~="" then
          屏蔽元素(webView,split(cont[i].element.text,","))
        end
      end
      if not(visibilityweb[3]) then
        visibilityweb[3]=false
      end
      changepar(view,1)
      adp.notifyDataSetChanged()
    end}


end
--[[
  for i=1,#cont do
    
    if view.url:find(cont[i].url.text) or cont[i].url.text=="*" then
      加载脚本(view,cont[i].js.text)
    end
    if webView.url:find(cont[i].url.text) and cont[i].element.text~="" then
      屏蔽元素(webView,split(cont[i].element.text,","))
    end
  --]]
--end

--[


--]]



function removeWebView(i)
  view=weblist[i]
  if view then
    view.stopLoading()
    view.loadDataWithBaseURL(nil, "", "text/html", "utf-8", nil);
    view.clearHistory()
    view.onPause();
    view.removeAllViews();
    webviewp.removeView(view)
    view.destroy()
    _G[weblist[i]]=nil--销毁WebView(G表里面删除)
    weblist[i]=nil--weblist里面删除
    adp.remove(i-1)--移除list里的目标对象
  end
end

function addTab(view)
  local addview=loadlayout({
    View,
    layout_width="1",
    layout_height="1",
    Visibility=8,
  })
  weblist4[view.id]=addview
  view.addView(addview)
end

function addOnLongClick(view)
  view.onTouch=function(v,e)
    weblist4[v.id].x=e.x
    weblist4[v.id].y=e.y+v.getScrollY()
  end
  view.onLongClick=function(v)
    hitTestResult = v.getHitTestResult()

    if (hitTestResult.getType() == WebView.HitTestResult.IMAGE_TYPE or hitTestResult.getType() == WebView.HitTestResult.SRC_IMAGE_ANCHOR_TYPE)then

      local pop=PopupMenu(activity,weblist4[v.id])
      menu=pop.Menu
      menu.add("保存图片").onMenuItemClick=function(a)
        picUrl = hitTestResult.getExtra()
        Http.download(picUrl,"/sdcard/download/pictures/"..os.date("%Y-%m-%d-%H-%M-%S")..".png",function(a)
        end)
        提示("图片已保存于/sdcard/download/pictures/")
      end
      menu.add("保存动态图片").onMenuItemClick=function(a)
        picUrl = hitTestResult.getExtra()
        Http.download(picUrl,"/sdcard/download/pictures/"..os.date("%Y-%m-%d-%H-%M-%S")..".gif",function(a)
        end)
        提示("图片已保存于/sdcard/download/pictures/")
      end
      menu.add("搜狗识图").onMenuItemClick=function(a)
        picUrl = hitTestResult.getExtra()
        v.loadUrl("https://pic.sogou.com/pic/ris_searchList.jsp?statref=home&v=5&ul=1&keyword="..picUrl)
        提示("正在识图....")
      end

      pop.show()--显示
     elseif hitTestResult.getType() == WebView.HitTestResult.SRC_ANCHOR_TYPE or hitTestResult.getType() == WebView.HitTestResult.SRC_IMAGE_ANCHOR_TYPE then

      local pop=PopupMenu(activity,weblist4[v.id])
      menu=pop.Menu
      menu.add("在新窗口打开").onMenuItemClick=function(a)
        webview(hitTestResult.getExtra())
      end
      menu.add("后台打开").onMenuItemClick=function(a)
        webview(hitTestResult.getExtra(),true)
      end
      pop.show()--显示

    end
  end

end

function string2tab(t)
  return load(table.concat({"return ",t},""))()
end

function 写入文件(路径,内容)
  import "java.io.File"
  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w"):write(tostring(内容)):close()
end

function 读取文件(路径)
  return io.open(路径):read("*a")
end
function sethistory(add,add2,is)

  local 数据源=Environment.getExternalStorageDirectory().toString().."/Android/data/"..activity.getPackageName().."/cache/history.table"
  local cache=gethistory()--获取历史记录

  table.insert(cache,{add,add2})
  if is then--清空历史数据
    写入文件(数据源,dump({}))
   else
    写入文件(数据源,dump(cache))
  end
end
function importhistory(t,q)
  local 数据源=Environment.getExternalStorageDirectory().toString().."/Android/data/"..activity.getPackageName().."/cache/history.table"
  if q then--q为是否合并导入，不q就完全覆盖
   else
    写入文件(数据源,dump(string2tab(读取文件(t))))
  end
end
function bakhistory(t)
  写入文件(t.."/history.table",dump(gethistory()))
end
function gethistory()
  import "java.io.File"
  local 数据源=Environment.getExternalStorageDirectory().toString().."/Android/data/"..activity.getPackageName().."/cache/history.table"
  if File(数据源).exists() then--存在就返回table
    local cache=读取文件(数据源)
    local re=string2tab(cache)
    if type(re)=="table" then--判断是否有历史记录
      return re
     else
      return {}
    end
   else
    写入文件(数据源,dump({}))--写入空table
    return {}
  end
end
function CircleButton(view,InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end
uploadMessageAboveL=0
onActivityResult=function(req,res,intent)
  if (res == Activity.RESULT_CANCELED) then
    if(uploadMessageAboveL~=nil )then
      --  uploadMessageAboveL.onReceiveValue(nil);
    end
  end
  local results
  if (res == Activity.RESULT_OK)then
    if(uploadMessageAboveL==nil or type(uploadMessageAboveL)=="number")then
      return;
    end
    if (intent ~= nil) then
      local dataString = intent.getDataString();
      local clipData = intent.getClipData();
      if (clipData ~= nil) then
        results = Uri[clipData.getItemCount()];
        for i = 0,clipData.getItemCount()-1 do
          local item = clipData.getItemAt(i);
          results[i] = item.getUri();
        end
      end
      if (dataString ~= nil) then
        results = Uri[1];
        results[0]=Uri.parse(dataString)
      end
    end
  end
  if(results~=nil)then
    uploadMessageAboveL.onReceiveValue(results);
    uploadMessageAboveL = nil;
  end
end

