require "import"
import "mods.Chimame_Core"
import "bmob"
import "cjson"


local b=bmob("bf11b7c1f7ea2c8ff5411be4c800dd23","3648bc00f69d0082481bc07e2d0aa432")
local id="bf11b7c1f7ea2c8ff5411be4c800dd23" --Application ID
local key="3648bc00f69d0082481bc07e2d0aa432" --REST API Key

local ok="登录成功，欢迎回来" --登陆成功提示
local bad="登录失败" --登陆失败提示
local zcok="注册成功，欢迎萌新" --注册成功提示
local bad1="信息填写不完整" --登陆信息不全
local bad2="信息有误,重新输入" --信息输入错误
local bad3="用户名已存在" --用户名已存在
local bad4="邮箱已存在" --邮箱已存在
local bad5="必须输入有效邮箱" --非有效邮箱
local bad6="邮箱或用户名不存在" --邮箱或用户名不存在
local bad7="检查信息是否输入完整" --提示检查信息是否输入完整



layout={
  RelativeLayout;
  layout_width="-1";
  background=backgroundc;
  layout_height="-1";
  {
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    orientation="vertical";
    {
      LinearLayout;
      layout_width="-1";
      layout_height="56dp";
      gravity="center|left";
      id="mActionBar";
      background="#00000000";
      {
        LinearLayout;
        orientation="horizontal";
        layout_height="56dp";
        layout_width="56dp";
        gravity="center";
        {
          ImageView;
          ColorFilter=primaryc;
          src=图标("arrow_back");
          layout_height="32dp";
          layout_width="32dp";
          padding="4dp";
          id="fh";
          onClick=function()关闭页面()end;
        };
      };
      {
        RelativeLayout;
        layout_height="-1";
        layout_width="-1";
        layout_marginRight="72dp";
        layout_marginLeft="16dp";
        {
          LinearLayout;
          layout_height="-1";
          layout_width="-1";
          {
            LinearLayout;
            layout_width="-1";
            layout_height="-1";
            layout_weight="1";
            gravity="center";
            id="jc1";
            onClick=function()jcpage(0)end;
            {
              TextView;
              layout_width="-2";
              layout_height="-2";
              Text="登录";
              Typeface=字体("product-Bold");
              textSize="16sp";
              textColor=primaryc;
            };
          };
          {
            LinearLayout;
            layout_width="-1";
            layout_height="-1";
            layout_weight="1";
            gravity="center";
            id="jc2";
            onClick=function()jcpage(1)end;
            {
              TextView;
              layout_width="-2";
              layout_height="-2";
              Text="注册";
              Typeface=字体("product-Bold");
              textSize="16sp";
              textColor=stextc;
            };
          };
        };
        {
          LinearLayout;
          layout_height="8dp";
          layout_width=(activity.getWidth()-dp2px(56*2+16*2))/2;
          id="page_scroll";
          layout_alignParentBottom="true";
          Gravity="center";
          --background=textc;
          {
            CardView;
            background=primaryc;
            elevation="0";
            radius="4dp";
            layout_height="8dp";
            layout_marginTop="4dp";
            layout_width="32dp";
          };
        };
      };
    };
    {
      PageView;
      layout_height="-1";
      layout_width="-1";
      id="jc";
      pages={
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          orientation="vertical";
          gravity="center";
          {
            MEditText
            {
              textSize="14sp",
              id="edit1",
              hint="用户名/邮箱";
              textColor=textc;
              HintTextColor=stextc;
              SingleLine=true;
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginLeft="64dp";
            layout_marginRight="64dp";
            layout_margin="16dp";
            layout_marginBottom="0";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="edit2",
              hint="密码";
              textColor=textc;
              HintTextColor=stextc;
              SingleLine=true;
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginLeft="64dp";
            layout_marginRight="64dp";
            layout_margin="16dp";
            layout_marginBottom="8dp";
          };
          {
            CardView;
            layout_width="-1";
            layout_height="-2";
            Radius="8dp";
            layout_marginTop="16dp";
            layout_marginLeft="64dp";
            layout_marginRight="64dp";
            layout_marginBottom="8dp";
            cardElevation="0dp";
            layout_marginBottom="56dp";
            backgroundColor=转0x(secondaryc)-0xde000000;
            {
              TextView;
              layout_width="-1";
              layout_height="-1";
              textSize="16sp";
              paddingRight="21dp";
              paddingLeft="21dp";
              paddingTop="12dp";
              paddingBottom="12dp";
              Text="登录";
              textColor=textc;
              id="button";
              gravity="center";
              Typeface=字体("product-Bold");
            };
          };
        };

        {
          LinearLayout;--Page2
          layout_width="-1";
          layout_height="-1";
          orientation="vertical";
          gravity="center";
          {
            MEditText
            {
              textSize="14sp",
              id="textID",
              hint="用户名";
              textColor=textc;
              HintTextColor=stextc;
              SingleLine=true;
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginLeft="64dp";
            layout_marginRight="64dp";
            layout_margin="16dp";
            layout_marginBottom="0";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="textPass",
              hint="密码";
              textColor=textc;
              HintTextColor=stextc;
              SingleLine=true;
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginLeft="64dp";
            layout_marginRight="64dp";
            layout_margin="16dp";
            layout_marginBottom="0";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="textPassRe",
              hint="确认密码";
              textColor=textc;
              HintTextColor=stextc;
              SingleLine=true;
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginLeft="64dp";
            layout_marginRight="64dp";
            layout_margin="16dp";
            layout_marginBottom="0";
          };
          {
            MEditText
            {
              textSize="14sp",
              id="textMail",
              hint="邮箱(也能用来登录哦)";
              textColor=textc;
              HintTextColor=stextc;
              SingleLine=true;
              layout_width="-1";
              layout_height="-2";
            };
            layout_marginLeft="64dp";
            layout_marginRight="64dp";
            layout_margin="16dp";
            layout_marginBottom="8dp";
          };
          {
            CardView;
            layout_width="-1";
            layout_height="-2";
            Radius="8dp";
            layout_marginTop="16dp";
            layout_marginLeft="64dp";
            layout_marginRight="64dp";
            layout_marginBottom="8dp";
            layout_marginBottom="56dp";
            cardElevation="0dp";
            backgroundColor=转0x(secondaryc)-0xde000000;
            {
              TextView;
              layout_width="-1";
              layout_height="-1";
              textSize="16sp";
              paddingRight="21dp";
              paddingLeft="21dp";
              paddingTop="12dp";
              paddingBottom="12dp";
              Text="注册";
              textColor=textc;
              id="button2";
              gravity="center";
              Typeface=字体("product-Bold");
            };
          };
        };
      };
    };
  };

}

activity.setContentView(loadlayout(layout))

import "android.text.InputType"
import "android.text.method.PasswordTransformationMethod"

idc={textPassRe,edit2,textPass}
for i=1,#idc do
  idc[i].setInputType(InputType.TYPE_TEXT_VARIATION_PASSWORD)
  idc[i].setTransformationMethod( PasswordTransformationMethod());
end

activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_ALT_FOCUSABLE_IM)

--波纹({fh,jc1,jc2},"圆",primaryc)
--波纹({button,button2},"方",secondaryc)
波纹({fh},"圆自适应")
波纹({jc1},"方自适应")
波纹({jc2},"方自适应")
波纹({button},"方白")
波纹({button2},"方白")


function jcpage(z)
  jc.showPage(z)
end

jc.setOnPageChangeListener(PageView.OnPageChangeListener{
  onPageScrolled=function(a,b,c)
    local w=(activity.getWidth()-dp2px(56*2+2*16))/2
    local wd=c*((activity.getWidth()-dp2px(56*2+2*16))/activity.getWidth())/2
    if a==0 then
      page_scroll.setX(wd)
    end
    if a==1 then
      page_scroll.setX(wd+w)
    end
  end,
  onPageSelected=function(v)
    local x=primaryc
    local c=stextc
    local c1=c
    local c2=c
    if v==0 then
      c1=x
    end
    if v==1 then
      c2=x
    end
    jc1.getChildAt(0).setTextColor(转0x(c1))
    jc2.getChildAt(0).setTextColor(转0x(c2))
  end
})



set=import "android.provider.Settings"
dev = set.System.getString(this.getContentResolver(), "android_id")



button.onClick = function()
  b:login(edit1.getText(),edit2.getText(),function(code,json)
    if (json.email)or(json.username) == edit1.getText() then
      activity.setSharedData("zh",edit1.Text)
      activity.setSharedData("mm",edit2.Text)
      local d={}--创建查询表
      d.where={}--创建查询位置表
      d.where.user=activity.getSharedData("zh")--定位于之前记录的登陆账户信息
      b:query("ChimameBrowser",d,function(code,j)
        if code~=-1 and code>=200 and code<400 then--如果查到当前账户
          if j.results[1]==nil then--如果在系统内未查到当前用户信息
            --创建账户及初始余额
            local bb={}--创建信息表
            bb.user= activity.getSharedData("zh")--信息表内填写初始昵称
            bb.donate="0"
            bb.header=""--信息表内填写初始头像
            bb.level="1"
            bb.devID=dev
            b:insert("Chimame Browser",bb,function(code)end)--将信息表嵌入云端数据库
          end
         else
          提示("本地网络或服务器异常")
        end
      end)
      提示(ok)
      activity.finish()
     else
      提示(bad)
      if (json:find"109") then
        提示(bad1)
      end
    end
  end)
end

button2.onClick = function()
  if (textID.Text or textPass.Text or textMail.Text or textPass.Text or textPassRe.Text)=="" then
    提示("请填写完整信息")
   elseif textPass.Text~=textPassRe.Text then
    提示("两次密码不一致")
   elseif #textPass.Text<6 then
    提示("密码过短")
   else
    b:sign(tostring(textID.getText()),tostring(textPass.getText()),tostring(textMail.getText()),function(code,json)
      if (dump(json):find"createdAt")then
        提示(zcok)
        local bb={}--创建信息表
        bb.user=textID.Text
        bb.donate="0"
        bb.header=""
        bb.level="1"
        bb.devID=dev
        bb.Fav="0"
        b:insert("ChimameBrowser",bb,function(code)end)--将信息表嵌入云端数据库
       else
        if (json:find"Bad Request") then
          提示(bad2)
        end
        if (json:find"202") then
          提示(bad3)
        end
        if (json:find"203") then
          提示(bad4)
        end
        if (json:find"204") then
          提示(bad5)
        end
        if (json:find"205") then
          提示(bad6)
        end
        if (json:find"301") then
          提示(bad7)
        end
      end
    end)
  end
end

