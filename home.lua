require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.webkit.WebChromeClient"
import "mods.history"
import "mods.browser_function"
import "mods.Chimame_Core"
import "mods.favourites"
import "bmob"
import "mods.download_list"


activity.setTheme(android.R.style.Theme_Material_Light)
--activity.getActionBar().hide()
activity.setContentView(loadlayout("layout/main"))


初始化历史记录数据(true,"history")

weblist={}
weblist2={}
weblist3={}
weblist4={}
--四个表，一个存数据，一个存索引，一个是适配器的数据，还有一个是长按数据的表
visibilityweb={}--万能的

adp=LuaAdapter(activity,weblist2,{
  LinearLayout;--线性布局
  orientation='vertical';--布局方向
  layout_width='fill';--布局宽度
  layout_height='8%h';--布局高度
  padding='15dp';--布局边距
  orientation='horizontal';--水平布局
  gravity='center';--重力居中
  background="#00FFFFFF",
  id="g";
  {
    ImageView;--图片框控件
    layout_width='56dp';--布局宽度
    id="icon";
    src="res/public_black.png",
    layout_height='25dp';--布局高度
  };
  {
    TextView;--文本框控件
    text='';--文本内容
    textSize='16sp';--文本大小
    textColor=textc;--文本颜色
    id="title",
    layout_weight='1';--重力分配
  };


})--线性布局 结束

function webview(t,q)--创建控件代码
  local view=loadlayout(
  {
    LuaWebView,--浏览器控件
    layout_width="fill",--布局宽度
    layout_height="fill",--布局高度--有人说高度fill不好，开源，你们来吧
    id="webView",
  })

  if q then--q为是否后台添加
   else
    for k,v in pairs(weblist) do
      v.setVisibility(8)--不是添加的控件不显示
    end
    webView=view
    visibilityweb[1]=view
  end
  webviewp.addView(view)--添加控件
  addTab(view)--添加长按项目
  addOnLongClick(view)

  weblist[#weblist+1]=view
  weblist3[view.id]=#weblist--设置一堆数据
  --  view.loadUrl(t or "https://liumingye.github.io/quarkHomePage/index.html?page=search") --正常？的使用fa函数
  if activity.getSharedData("homepage")==nil then
  view.loadUrl("file:///android_asset/via/index.html") 
  else
  view.loadUrl(activity.getSharedData("homepage")) 
  end
  weblist2[#weblist2+1]={icon=view.getFavicon(),title="加载中"}--先添加数据先
  --设置webview
  mSettings(view)

  view.setWebViewClient(getmWebViewClient())
  view.setWebChromeClient(getmWebChromeClient())
  view.setVisibility(0)

end

webview()--先初始化一个WebView




lastclick = os.time() - 2
function onKeyDown(code,event)
  local now = os.time()
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    --监听返回键
    if pop.isShowing() then
      --如果菜单显示，关闭菜单并阻止返回键
      pop.dismiss()
      return true
    end
    if spop.isShowing() then
      spop.dismiss()
      return true
    end
    --[[
  if WebViewlistPop.isShowing() then
      WebViewlistPopDismiss()
      return true
    end
  --]]
    if now - lastclick > 2 then
      --双击退出
      提示("再按一次退出")
      lastclick = now
      return true
    end
  end
end




--按两次返回退出页面
--没加退出webview那些高端玩意，你们来

ftb.onTouch=function(view,event)
  a=event.getAction()&255
  switch a
   case MotionEvent.ACTION_DOWN
    ftb_img.setVisibility(View.GONE)
    sss=ftb.getY()
    ccc=ftb.getX()
    aaa=转分辨率("25dp")
    one_a=ccc-activity.getWidth()*.25
    one_b=sss
    one_c=ccc-activity.getWidth()*.25+转分辨率("50dp")
    one_d=sss+转分辨率("50dp")
    two_a=ccc-math.sqrt((activity.getWidth()*.25)^2/2)
    two_b=sss-math.sqrt((activity.getWidth()*.25)^2/2)
    two_c=ccc-math.sqrt((activity.getWidth()*.25)^2/2)+转分辨率("50dp")
    two_d=sss-math.sqrt((activity.getWidth()*.25)^2/2)+转分辨率("50dp")
    three_a=ccc
    three_b=sss-activity.getWidth()*.25
    three_c=ccc+转分辨率("50dp")
    three_d=sss-activity.getWidth()*.25+转分辨率("50dp")
    four_a=ccc+math.sqrt((activity.getWidth()*.25)^2/2)
    four_b=sss-math.sqrt((activity.getWidth()*.25)^2/2)
    four_c=ccc+math.sqrt((activity.getWidth()*.25)^2/2)+转分辨率("50dp")
    four_d=sss-math.sqrt((activity.getWidth()*.25)^2/2)+转分辨率("50dp")
    five_a=ccc+activity.getWidth()*.25
    five_b=sss
    five_c=ccc+activity.getWidth()*.25+转分辨率("50dp")
    five_d=sss+转分辨率("50dp")
    位移动画(ftb_two,"X",{ccc,ccc-activity.getWidth()*.25},100)
    位移动画(ftb_three,"X",{ccc,ccc+activity.getWidth()*.25},200)
    位移动画(ftb_four,"Y",{sss,sss-activity.getWidth()*.25},150)
    位移动画(ftb_five,"X",{ccc,ccc-math.sqrt((activity.getWidth()*.25)^2/2)},125)
    位移动画(ftb_five,"Y",{sss,sss-math.sqrt((activity.getWidth()*.25)^2/2)},125)
    位移动画(ftb_six,"X",{ccc,ccc+math.sqrt((activity.getWidth()*.25)^2/2)},175)
    位移动画(ftb_six,"Y",{sss,sss-math.sqrt((activity.getWidth()*.25)^2/2)},175)
   case MotionEvent.ACTION_MOVE
    sss_x=event.getX()+ccc
    sss_y=event.getY()+sss
    if sss_x>=one_a and sss_y>=one_b and sss_x<=one_c and sss_y<=one_d then
      ftb_txt.setText("后退")
     elseif sss_x>=two_a and sss_y>=two_b and sss_x<=two_c and sss_y<=two_d then
      ftb_txt.setText("停止")
     elseif sss_x>=three_a and sss_y>=three_b and sss_x<=three_c and sss_y<=three_d then
      ftb_txt.setText("窗口")
     elseif sss_x>=four_a and sss_y>=four_b and sss_x<=four_c and sss_y<=four_d then
      ftb_txt.setText("刷新")
     elseif sss_x>=five_a and sss_y>=five_b and sss_x<=five_c and sss_y<=five_d then
      ftb_txt.setText("前进")
     else
      ftb_txt.setText("")
    end
   case MotionEvent.ACTION_UP
    ftb_img.setVisibility(View.VISIBLE)
    ftb_txt.setText("")
    位移动画(ftb_two,"X",{ccc-activity.getWidth()*.25,ccc},220)
    位移动画(ftb_three,"X",{ccc+activity.getWidth()*.25,ccc},220)
    位移动画(ftb_four,"Y",{sss-activity.getWidth()*.25,sss},220)
    位移动画(ftb_five,"X",{ccc-math.sqrt((activity.getWidth()*.25)^2/2),ccc},220)
    位移动画(ftb_five,"Y",{sss-math.sqrt((activity.getWidth()*.25)^2/2),sss},220)
    位移动画(ftb_six,"X",{ccc+math.sqrt((activity.getWidth()*.25)^2/2),ccc},220)
    位移动画(ftb_six,"Y",{sss-math.sqrt((activity.getWidth()*.25)^2/2),sss},220)
    sss_x=event.getX()+ccc
    sss_y=event.getY()+sss
    if sss_x>=one_a and sss_y>=one_b and sss_x<=one_c and sss_y<=one_d then
      --  showChoose()
      webView.goBack()
     elseif sss_x>=two_a and sss_y>=two_b and sss_x<=two_c and sss_y<=two_d then
      webView.stopLoading()
      -- 提示("没有")
     elseif sss_x>=three_a and sss_y>=three_b and sss_x<=three_c and sss_y<=three_d then
      showChoose()
      --提示("没有")
     elseif sss_x>=four_a and sss_y>=four_b and sss_x<=four_c and sss_y<=four_d then
      --  EmojiPopShow()
      webView.reload()
     elseif sss_x>=five_a and sss_y>=five_b and sss_x<=five_c and sss_y<=five_d then
      webView.goForward()
      -- activity.newActivity("setting")
      --   task(200,function()
      --    activity.finish()
      --   end)
    end
  end
  return true
end


--[[
import "android.view.View$OnFocusChangeListener"
editurl.setOnFocusChangeListener(OnFocusChangeListener{
  onFocusChange=function(v,hasFocus)
    if hasFocus then
      webgo.setVisibility(View.VISIBLE)

     else
      webgo.setVisibility(View.INVISIBLE)
    end
  end})
editurl.setVisibility(View.INVISIBLE)
webgo.setVisibility(View.INVISIBLE)
task(50,function()
  editurl.setVisibility(View.VISIBLE)
end)

--]]


--[



波纹({web_search},"圆黑白自适应")
波纹({edit_close},"圆黑白自适应")
--]]
波纹({上翻},"圆自适应")
波纹({下翻},"圆自适应")
波纹({关闭},"圆自适应")
波纹({top_more},"圆黑白自适应")
波纹({web_safety},"圆黑白自适应")
波纹({bar_layout},"方黑白自适应")
bar_layout.onClick=function()
  task(200,function()
    _topbar.Visibility=0
    topbar.Visibility=8
  end)
end




function ftb_show()
  ftb_two.Visibility=0
  ftb_three.Visibility=0
  ftb_four.Visibility=0
  ftb_five.Visibility=0
  ftb_six.Visibility=0
  ftb.Visibility=0
end

function ftb_hide()
  ftb_two.Visibility=8
  ftb_three.Visibility=8
  ftb_four.Visibility=8
  ftb_five.Visibility=8
  ftb_six.Visibility=8
  ftb.Visibility=8
end






sPopup_layout={
  LinearLayout;
  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="422dp";
    layout_margin="8dp";
    layout_marginTop="0";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=backgroundc;
      Radius=dp2px(8)-2;
      layout_margin="2px";
      layout_width="-1";
      layout_height="-1";
      {
        GridView;
        layout_height="-1";
        layout_width="-1";
        NumColumns=1;
        id="sPopup_list";
      };
    };
  };
};
spop=PopupWindow(activity)
--PopupWindow加载布局
spop.setContentView(loadlayout(sPopup_layout))
spop.setWidth(dp2px(212))
spop.setHeight(-2)

spop.setOutsideTouchable(true)
spop.setBackgroundDrawable(ColorDrawable(0x00000000))

spop.onDismiss=function()
  --消失事件
end

--PopupWindow列表项布局
sPopup_list_item={
  {
    LinearLayout;
    layout_width="-1";
    layout_height="48dp";
    orientation="horizontal";
    {
      ImageView;
      layout_width="24dp";
      layout_margin="10dp";
      layout_height="24dp";
      -- src="res/watashi.png";
      colorFilter=primaryc;
      id="popadp_src";

    };
    {
      LinearLayout;
      layout_width="fill";
      layout_margin="15dp";
      orientation="vertical";
      {
        TextView;
        id="popadp_text";
        textColor=textc;
        layout_width="-1";
        layout_height="-1";
        textSize="14sp";
        gravity="left|center";
        --  paddingLeft="16dp";
        Typeface=字体("product");
      };
    };
  };

  {
    LinearLayout;
    layout_width="-1";
    layout_height="50dp";
    orientation="horizontal";
    {
      ImageView;
      layout_width="24dp";
      layout_margin="10dp";
      layout_height="24dp";
      -- src="res/watashi.png";
      colorFilter=primaryc;
      id="popadp_src";
    };
    {
      LinearLayout;
      layout_width="fill";
      layout_margin="10dp";
      orientation="vertical";
      {
        TextView;
        Typeface=字体("product-Bold");
        layout_width="fill";
        textColor=textc;
        textSize="12sp";
        gravity="left|center";
        id="popadp_text";
      };
      {
        TextView;
        Typeface=字体("product");
        layout_width="fill";
        textColor=stextc;
        gravity="left|center";
        textSize="11sp";
        id="subt";
      };
    };
  };
  --3
  {
    LinearLayout;
    layout_width="-1";
    layout_height="36dp";
    orientation="horizontal";

    {
      ImageView;
      layout_width="18dp";
      layout_margin="4dp";
      layout_marginTop="9dp";
      layout_marginLeft="10dp";
      layout_marginRight="0dp";
      layout_height="18dp";
      -- src="res/watashi.png";
      colorFilter=primaryc;
      --gravity="center";
      id="popadp_src";
      src="res/twotone_arrow_back_black_24dp.png";
    };
    {
      TextView;
      Typeface=字体("product-Bold");
      layout_width="fill";
      textColor=primaryc;
      textSize="13sp";
      layout_margin="10dp";
      gravity="left|center";
      id="popadp_text";
    };
  };

  --4 开关
  {
    LinearLayout;
    layout_width="-1";
    layout_height="48dp";
    orientation="horizontal";
    id="content",
    {
      ImageView;
      layout_width="24dp";
      layout_margin="8dp";
      layout_height="24dp";
      -- src="res/watashi.png";
      colorFilter=primaryc;
      id="icon";
    };
    {
      LinearLayout,
      layout_weight="1",
      layout_marginRight="0";
      layout_margin="13dp";
      orientation="vertical",
      {
        TextView,
        textColor=textc;
        layout_width="-1";
        layout_height="-1";
        textSize="14sp";
        gravity="left|center";
        --  paddingLeft="16dp";
        layout_marginLeft="6dp";
        Typeface=字体("product");
        singleLine=true,
        id="title",

      },
    },
    {
      Switch,
      id="action",
      layout_marginLeft="2dp",
      layout_margin="10dp";
      layout_marginRight="2dp";
      focusable=false,
      clickable=false,
    },
  },



};


import "android.content.Context"
function 开启防止手机休眠()
  this.getSystemService(Context.POWER_SERVICE).newWakeLock(PowerManager.SCREEN_DIM_WAKE_LOCK, "MyTag").acquire()
end
function 关闭防止手机休眠()
  this.getSystemService(Context.POWER_SERVICE).newWakeLock(PowerManager.SCREEN_DIM_WAKE_LOCK, "MyTag").release()
end


spopadp=LuaMultiAdapter(activity,sPopup_list_item)
sPopup_list.setAdapter(spopadp)
spopadp.add{__type=3,popadp_text="进阶探索",}--添加项目(菜单项)
--[
--spopadp.add{__type=2,popadp_src="res/local_offer_black.png",popadp_text="  网页控制",subt="  不同网页分别配置"}--添加项目(菜单项)
--spopadp.add{__type=2,popadp_src="res/js.png",popadp_text="  全局脚本",subt="  可用扩展与JS仓库"}--添加项目(菜单项)
spopadp.add{__type=1,popadp_src="res/content_cut_black.png",popadp_text="网页长截图",}--添加项目(菜单项)
--spopadp.add{__type=1,popadp_src="res/free_breakfast_black.png",popadp_text="保持唤醒",}--添加项目(菜单项)
spopadp.add{__type=4,
  content={
    --BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz})),
    onClick=function(v)
      local state=not v.getChildAt(2).checked
      mukactivity.setData("Setting_wake",tostring(state))
      local data=spopadp.getData()[3].action
      data.checked=state
      if state then
        开启防止手机休眠()
        -- print("1")
       else
        关闭防止手机休眠()
      end
      spopadp.notifyDataSetChanged()
    end,
  },title="保持唤醒",
  action={
    checked=Boolean.valueOf(mukactivity.getData("Setting_wake")),
  },
  icon="res/free_breakfast_black.png",
}
spopadp.add{__type=1,popadp_src="res/xml_black.png",popadp_text="查看源代码",}--添加项目(菜单项)
spopadp.add{__type=1,popadp_src="res/update_black.png",popadp_text="查看Cookie",}--添加项目(菜单项)
spopadp.add{__type=1,popadp_src="res/import_contacts_black.png",popadp_text="阅读模式",}--添加项目(菜单项)
spopadp.add{__type=1,popadp_src="res/g_translate_black.png",popadp_text="全局翻译",}--添加项目(菜单项)
spopadp.add{__type=1,popadp_src="res/search.png",popadp_text="页内查找",}--添加项目(菜单项)
spopadp.add{__type=1,popadp_src="res/help_black.png",popadp_text="帮助",}--添加项目(菜单项)



edt.addTextChangedListener{
    onTextChanged=function(s)
      webView.findAllAsync(edt.text)
    end}




cPopup_layout={
  LinearLayout;

  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="8dp";
    layout_marginTop="0";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=backgroundc;
      Radius=dp2px(8)-2;
      layout_margin="2px";
      layout_width="-1";
      layout_height="-1";

      {
        GridView;
        layout_height="-1";
        layout_width="-1";
        NumColumns=1;
        id="cPopup_list";
      };
    };
  };
};
--PopupWindow
cpop=PopupWindow(activity)
--PopupWindow加载布局
cpop.setContentView(loadlayout(cPopup_layout))
cpop.setWidth(dp2px(192))
cpop.setHeight(-2)

cpop.setOutsideTouchable(true)
cpop.setBackgroundDrawable(ColorDrawable(0x00000000))

cpop.onDismiss=function()
  --消失事件
end

--PopupWindow列表项布局
cPopup_list_item={
  LinearLayout;
  layout_width="-1";
  layout_height="48dp";
  {
    TextView;
    id="popadp_text";
    textColor=textc;
    layout_width="-1";
    layout_height="-1";
    textSize="14sp";
    gravity="left|center";
    paddingLeft="16dp";
    Typeface=字体("product");
  };
};

--PopupWindow列表适配器
cpopadp=LuaAdapter(activity,cPopup_list_item)

cPopup_list.setAdapter(cpopadp)
cpopadp.add{popadp_text="查看已有书签",}--添加项目(菜单项)
cpopadp.add{popadp_text="新建书签",}


--菜单点击事件
cPopup_list.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(parent, v, pos,id)
    cpop.dismiss()
    pop.dismiss()
    if v.Tag.popadp_text.Text=="查看已有书签" then
      showFav()
     else
      addFav()
    end
  end
})



















--PopupWindow列表适配器

Popup_layout={
  LinearLayout;
  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="429dp";
    layout_margin="8dp";
    layout_marginTop="0";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=backgroundc;
      Radius=dp2px(8)-2;
      layout_margin="2px";
      layout_width="-1";
      layout_height="-1";

      {
        GridView;
        layout_height="-1";
        layout_width="-1";
        NumColumns=1;
        id="Popup_list";
      };
    };
  };
};
--PopupWindow
pop=PopupWindow(activity)
--PopupWindow加载布局
pop.setContentView(loadlayout(Popup_layout))
pop.setWidth(dp2px(212))
pop.setHeight(-2)

pop.setOutsideTouchable(true)
pop.setBackgroundDrawable(ColorDrawable(0x00000000))

pop.onDismiss=function()
  --消失事件
end

--PopupWindow列表项布局
Popup_list_item={
  {
    LinearLayout;
    layout_width="-1";
    layout_height="48dp";
    orientation="horizontal";
    {
      ImageView;
      layout_width="24dp";
      layout_margin="8dp";
      layout_marginTop="9dp";
      layout_height="24dp";
      -- src="res/watashi.png";
      colorFilter=primaryc;
      id="popadp_src";

    };
    {
      LinearLayout;
      layout_width="fill";
      layout_margin="13dp";
      orientation="vertical";
      {
        TextView;
        id="popadp_text";
        textColor=textc;
        layout_width="-1";
        layout_height="-1";
        textSize="14sp";
        gravity="left|center";
        --  paddingLeft="16dp";
        Typeface=字体("product");
      };
    };
  };

  {
    LinearLayout;
    layout_width="-1";
    layout_height="50dp";
    orientation="horizontal";
    {
      ImageView;
      layout_width="24dp";
      layout_margin="8dp";
      layout_height="24dp";
      -- src="res/watashi.png";
      colorFilter=primaryc;
      id="popadp_src";
    };
    {
      LinearLayout;
      layout_width="fill";
      layout_margin="8dp";
      orientation="vertical";
      {
        TextView;
        Typeface=字体("product-Bold");
        layout_width="fill";
        textColor=textc;
        textSize="12sp";
        gravity="left|center";
        id="popadp_text";
      };
      {
        TextView;
        Typeface=字体("product");
        layout_width="fill";
        textColor=stextc;
        gravity="left|center";
        textSize="11sp";
        id="subt";
      };
    };
  };
  {
    LinearLayout;
    layout_width="-1";
    layout_height="36dp";
    orientation="horizontal";
    {
      TextView;
      Typeface=字体("product-Bold");
      layout_width="fill";
      textColor=primaryc;
      textSize="13sp";
      layout_margin="10dp";
      gravity="left|center";
      id="popadp_text";
    };
  };

  --4 tools
  {
    LinearLayout;
    layout_width="-1";
    -- Elevation="3dp";
    layout_height="50dp";
    orientation="horizontal";
    backgroundColor=backgroundc;

    gravity="center";
    -- layout_gravity="center|bottom";
    --id="bmwhole";
    {
      LinearLayout;
      layout_width="65dp";
      layout_marginTop="-1dp";
      layout_marginLeft="0dp";
      orientation="vertical";
      gravity="center|left";
      layout_gravity="center|left";
      layout_height="-1";
      BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
      onClick=function()
        if cpop.isShowing() then
          cpop.dismiss()
          return true
         else
          cpop.showAsDropDown(topbar)
        end

      end;
      {
        ImageView;--影像视图
        ColorFilter=primaryc;
        -- src="icon.png";
        layout_height="26dp";--高度
        --layout_margin="20dp";
        --layout_marginLeft="15dp";
        layout_marginTop="0dp";--边顶
        layout_width="26dp";--宽度
        layout_gravity="center";
        id="src1";
        -- backgroundColor="#00000000";--背景色

      };
      {
        TextView;
        layout_gravity="center";
        text="书签";
        textSize="10sp";
        Typeface=字体("product");
        layout_marginTop="2dp";
        textColor=stextc;
        id="popadp_text";
      };
    };
    {
      LinearLayout;
      layout_marginTop="-1dp";
      layout_width="68dp";
      layout_height="-1";
      layout_marginLeft="0dp";
      orientation="vertical";
      gravity="center|left";
      layout_gravity="center|left";
      BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
      onClick=function()
        activity.newActivity("sub/history_page")
        pop.dismiss()
        --展示历史记录()
      end;
      {
        ImageView;--影像视图
        ColorFilter=primaryc;
        -- src="drawable/b.png";
        layout_height="26dp";--高度
        layout_marginTop="0dp";--边顶
        layout_width="26dp";--宽度
        layout_gravity="center";
        id="src2";
        backgroundColor="#00000000";--背景色
      };
      {
        TextView;
        layout_gravity="center";
        text="历史";
        textSize="10sp";
        Typeface=字体("product");
        layout_marginTop="2dp";
        textColor=stextc;
        id="popadp_text";
      };
    };
    {
      LinearLayout;
      layout_marginTop="-1dp";
      layout_width="65dp";
      layout_marginLeft="0dp";
      orientation="vertical";
      gravity="center|right";
      layout_gravity="center|right";
      layout_height="-1";
      BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
      onClick=function()
        下载内容()
        pop.dismiss()
      end;
      {
        ImageView;--影像视图
        --src="drawable/d.png";
        layout_height="26dp";--高度
        --layout_margin="20dp";
        ColorFilter=primaryc;
        --layout_marginLeft="15dp";
        layout_marginTop="0dp";--边顶
        layout_width="26dp";--宽度
        id="src3";
        layout_gravity="center";
        backgroundColor="#00000000";--背景色
      };
      {
        TextView;
        layout_gravity="center";
        text="下载";
        textSize="10sp";
        Typeface=字体("product");
        layout_marginTop="2dp";
        textColor=stextc;
        id="popadp_text";
      };
    };
    --[[
  {
    LinearLayout;
    id="src3";
    layout_width="50dp";
    layout_marginLeft="0dp";
    orientation="vertical";
    gravity="center|right";
    layout_gravity="center|right";
    layout_height="-1";
    {
      ImageView;--影像视图
     -- src="drawable/c.png";
      layout_height="30dp";--高度
      ColorFilter=primaryc;
      layout_marginTop="0dp";--边顶
      layout_width="30dp";--宽度
      layout_gravity="center";
      backgroundColor="#00000000";--背景色
    };
  };
--]]
  };


  --5 开关
  {
    LinearLayout;
    layout_width="-1";
    layout_height="48dp";
    orientation="horizontal";
    id="content",
    {
      ImageView;
      layout_width="24dp";
      layout_margin="8dp";
      layout_height="24dp";
      -- src="res/watashi.png";
      colorFilter=primaryc;
      id="icon";
    };
    {
      LinearLayout,
      layout_weight="1",
      layout_marginRight="0";
      layout_margin="13dp";
      orientation="vertical",
      {
        TextView,
        textColor=textc;
        layout_width="-1";
        layout_height="-1";
        textSize="14sp";
        gravity="left|center";
        --  paddingLeft="16dp";
        Typeface=字体("product");
        singleLine=true,
        id="title",

      },
    },
    {
      Switch,
      id="action",
      layout_marginLeft="2dp",
      layout_margin="10dp";
      layout_marginRight="2dp";
      focusable=false,
      clickable=false,
    },
  },


};



popadp=LuaMultiAdapter(activity,Popup_list_item)

Popup_list.setAdapter(popadp)
--
popadp.add{__type=3,popadp_text="菜单",}--添加项目(菜单项)
popadp.add{__type=4,src1="res/bookmark.png",src3="res/newsave.png",src2="res/access_time_black.png",}
popadp.add{__type=2,popadp_src="res/toys_black.png",popadp_text="  进阶选项",subt="  灵魂所在的实用功能"}--添加项目(菜单项)
popadp.add{__type=2,popadp_src="res/nodejs.png",popadp_text="  调试与扩展插件",subt="  配置Js脚本控制网页"}

popadp.add{__type=2,popadp_src="res/settings_black.png",popadp_text="  设置",subt="  包含功能与主题配置"}--添加项目(菜单项)
popadp.add{__type=1,popadp_src="res/twotone_open_in_new_black_24dp.png",popadp_text="其它浏览器打开",}--添加项目(菜单项)
popadp.add{popadp_src="res/eject_black.png",popadp_text="复制链接",}--添加项目(菜单项)
popadp.add{__type=5,
  content={
    --BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz})),
    onClick=function(v)
      local state=not v.getChildAt(2).checked
      mukactivity.setData("Setting_fltbtn",tostring(state))
      local data=popadp.getData()[8].action
      data.checked=state
      if state then
        --提示("待开发，咕咕咕")
        activity.setSharedData("Setting_fltbtn",state)
        -- print(activity.getSharedData("Setting_Boot_Img"))

        ftb_two.Visibility=8
        ftb_three.Visibility=8
        ftb_four.Visibility=8
        ftb_five.Visibility=8
        ftb_six.Visibility=8
        ftb.Visibility=8
       else
        activity.setSharedData("Setting_fltbtn",false)
        ftb_two.Visibility=0
        ftb_three.Visibility=0
        ftb_four.Visibility=0
        ftb_five.Visibility=0
        ftb_six.Visibility=0
        ftb.Visibility=0
      end
      popadp.notifyDataSetChanged()
    end,
  },title="隐藏悬浮球",
  action={
    checked=Boolean.valueOf(mukactivity.getData("Setting_fltbtn")),
  },
  icon="res/visibility_off_black.png",
}

--]]
--[[
popadp.add{popadp_text="网页长截图",}--添加项目(菜单项)
popadp.add{popadp_text="保持唤醒",}--添加项目(菜单项)
popadp.add{popadp_text="查看源代码",}--添加项目(菜单项)
popadp.add{popadp_text="查看Cookie",}--添加项目(菜单项)
popadp.add{popadp_text="阅读模式",}--添加项目(菜单项)
--]]
--popadp.add{__type=1,popadp_src="res/save.png",popadp_text="下载内容",}--添加项目(菜单项)
--popadp.add{__type=1,popadp_src="res/access_time_black.png",popadp_text="历史记录",}--添加项目(菜单项)
--popadp.add{__type=1,popadp_src="res/bookmark.png",popadp_text="书签",}--添加项目(菜单项)
popadp.add{__type=1,popadp_src="res/twotone_exit_to_app_black_24dp.png",popadp_text="退出",}--添加项目(菜单项)

--菜单点击事件
Popup_list.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(parent, v, pos,id)
    if v.Tag.popadp_text.Text=="  进阶选项" then
      pop.dismiss()
      spop.showAsDropDown(top_more)
      --  topbar.Visibility=8
     elseif v.Tag.popadp_text.Text=="  设置" then
      pop.dismiss()
      activity.newActivity("sub/setting")
     elseif v.Tag.popadp_text.Text=="其它浏览器打开" then
      pop.dismiss()
      local text=webView.getUrl()
      intent=Intent(Intent.ACTION_SEND);
      intent.setType("text/plain");
      intent.putExtra(Intent.EXTRA_SUBJECT, "Go!");
      intent.putExtra(Intent.EXTRA_TEXT, text);
      intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      activity.startActivity(Intent.createChooser(intent,"打开方式:"));
     elseif v.Tag.popadp_text.Text=="复制链接" then
      pop.dismiss()
      复制文本(webView.getUrl())
      提示("复制完毕")
     elseif v.Tag.popadp_text.Text=="退出" then
      activity.finish()
     elseif v.Tag.popadp_text.Text=="  调试与扩展插件" then
      pop.dismiss()
      --提示()
      activity.newActivity("sub/web_control")
      --elseif v.Tag.popadp_text.Text=="退出" then
      --pop.dismiss()

    end
  end
})

--[

--]]

top_more.onClick=function()
  pop.showAsDropDown(top_more)
end

--activity.newActivity("welcome")



function getinfo()
  wurl=webView.getUrl()
  if wurl=="file:///android_asset/via/index.html" then
    web_safety.setImageBitmap(loadbitmap(图标("https")))
    web_safety.setColorFilter(0xff4CAF50)
   else
    if wurl:sub(1,8)=="https://" then
      web_safety.setImageBitmap(loadbitmap(图标("https")))
      web_safety.setColorFilter(0xff4CAF50)
     else
      web_safety.setColorFilter(转0x(stextc))
      web_safety.setImageBitmap(loadbitmap(图标("info")))
    end
  end
end






function onActivityResult(req, res, intent)
  --print( req)
  --print( res)
  --print( intent)
  switch req
   case 1
    主题是否更改(2)
    -- getuserinfo()
   case 2
    -- getuserinfo()
    print("case 2")
  end
end



intent_going()
--接受回调


function onResume()
  history_going()
end




if activity.getSharedData("Setting_fltbtn")==true then
  ftb_hide()
 else
  ftb_show()
end