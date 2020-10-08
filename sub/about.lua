require"import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.Color"
import "android.animation.ObjectAnimator"
import "android.animation.ArgbEvaluator"
import "android.animation.ValueAnimator"
import "android.graphics.Typeface"
import "mods.Chimame_Core"
沉浸状态栏()
activity.overridePendingTransition(android.R.anim.slide_in_left,android.R.anim.fade_out)
function GetAppInfo(包名)
  import "android.content.pm.PackageManager"
  local pm = activity.getPackageManager();  
  local pkg = activity.getPackageManager().getPackageInfo(包名, 0);  
  local 版本号 = activity.getPackageManager().getPackageInfo(包名, 0).versionName  
  return 版本号
end
main_layout=
{
  LinearLayout;
  layout_width="fill";
  layout_height="fill";
  Orientation="vertical";

  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="16dp";
    layout_marginTop="20dp";
    layout_marginBottom="0dp";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=backgroundc;
      Radius=dp2px(8)-2;
      layout_margin="2px";
      layout_width="-1";
      layout_height="-1";


      {
        LinearLayout;
        id="ty1";
        layout_width="fill";
        gravity="center|left";
        orientation="horizontal";
        {
          ImageView;
          layout_width="30dp";
          layout_margin="10dp";
          layout_height="30dp";
          src="res/twotone_error_black_24dp.png";
          ColorFilter=secondaryc,

        };
        {
          LinearLayout;
          layout_width="fill";
          layout_marginLeft="10dp";
          layout_marginRight="10dp";
          orientation="vertical";
          {
            TextView;
            text="您正在使用 Chimame Browser的预览版本，功能尚未完善。如有异常请及时进行反馈。";
            Typeface=字体("product-Bold");
            textColor=secondaryc;
            textSize="11sp";
          };

        };
      };

    };

  };
  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="16dp";
    --    layout_marginTop="20dp";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=backgroundc;
      Radius=dp2px(8)-2;
      layout_margin="2px";
      layout_width="-1";
      layout_height="-1";
      {
        LinearLayout;
        layout_width="fill";
        layout_height="fill";
        padding="8dp";
        Orientation="vertical";
        {
          TextView;
          layout_width="100dp";
          layout_height="40dp";
          gravity="center";
          text="开发相关";
          Typeface=字体("product-Bold");
          textColor=primaryc;
          textSize="17dp";
        };
        {
          LinearLayout;
          id="kaifazhe";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_height="30dp";
            layout_margin="10dp";
            layout_marginLeft="12dp";
            src="res/watashi.png";

          };
          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="酷安@得想办法娶了智乃";
              Typeface=字体("product-Bold");
              textColor=textc;
              textSize="15sp";
            };
            {
              TextView;
              text="开发者";
              textColor=textc;
              Typeface=字体("product");
              textSize="12sp";
            };

          };
        };



        --[
        {
          LinearLayout;
          id="ca";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_height="30dp";
            src="res/ca.png";
            layout_marginLeft="12dp";
            ColorFilter=primaryc,
          };

          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="查看在线页";
              Typeface=字体("product-Bold");
              textColor=textc;
              textSize="15sp";
            };
            {
              TextView;
              text="Coolapk";
              textColor=textc;
              Typeface=字体("product");
              textSize="12sp";
            };
          };

        };
        --]]
        --[[
        {
          LinearLayout;
          id="up";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_height="30dp";
            src="res/update.png";
            ColorFilter=primaryc,
          };
          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="检查更新";
              Typeface=字体("product-Bold");
              textColor=textc;
              textSize="15sp";
            };

          };
        };
--]]
        --[[
        {
          LinearLayout;
          id="log";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_height="30dp";
            src="res/log.png";
            ColorFilter=primaryc,
          };
          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="更新日志";
              Typeface=字体("product-Bold");
              textColor=textc;
              textSize="15sp";
            };

          };
        };
--]]


      };

    };
  };


  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="16dp";
    layout_marginTop="0";
    id="up_card";
    Visibility=0;
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=backgroundc;
      Radius=dp2px(8)-2;
      layout_margin="2px";
      layout_width="-1";
      layout_height="-1";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        orientation="vertical";
        layout_marginBottom="-10dp";
        padding="24dp";
        
        {
          TextView;
          text="应用更新";
          textColor=primaryc;
          textSize="17dp";
          gravity="center|left";
          Typeface=字体("product-Bold");
        };
        {
          LinearLayout;
          --id="ca";
          layout_width="fill";
          gravity="center|left";
          layout_marginBottom="-10dp";
          layout_marginTop="6dp";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_marginLeft="0dp";
            layout_height="30dp";
            src="res/update.png";
            ColorFilter=primaryc,
          };

          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="正在检查更新...";
              Typeface=字体("product-Bold");
              layout_marginTop="15dp";
              textColor=textc;
              textSize="15sp";
              id="up_tit";
            };
            {
              TextView;
              text="";
              layout_marginTop="5dp";
              textColor=textc;
              Typeface=字体("product");
              textSize="13sp";
              id="up_subtit";
            };
          };

        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          background="#00ffffff";
          layout_gravity="right";
          Elevation="0";
          layout_marginTop="4dp";
          --     onClick=function()浏览器打开("http://mukapp.top/index.php/mdesign.html")end;
          onClick=function()提示("还没写")end;
          {
            LinearLayout;
            layout_width="-1";
            layout_height="-1";
            orientation="horizontal";
            {
              TextView;
              layout_width="-1";
              layout_height="-1";
              textSize="14sp";
              paddingRight="12dp";
              paddingLeft="12dp";
              paddingTop="8dp";
              paddingBottom="8dp";
              Text="更新日志";
              textColor=primaryc;
              id="log";
              gravity="center";
              Typeface=字体("product-Bold");
              BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));



            };
            {
              CardView;
              layout_width="90dp";
              layout_gravity="center";
              layout_height="35dp";
              layout_margin="16dp";
              layout_marginRight="0dp";
              background=primaryc;
              Elevation='1dp';--阴影属性
              id="check_update";
              onClick=function()update()end;
              radius='6dp';--卡片圆角
              {
                LinearLayout;
                layout_width="fill";
                -- layout_gravity="right";
                layout_height="fill";
                gravity="center";
                id="check_update_layout";
                {
                  TextView;
                  text="检查更新";
                  layout_gravity="center";
                  textSize="14dp";
                  Typeface=字体("product-Bold");
                  textColor="#ffffffff";
                };
              };
            };
          };

        };
      };

    };
  };






  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="16dp";
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
        LinearLayout;
        layout_width="fill";
        layout_height="fill";
        Orientation="vertical";
        padding="8dp";
        {
          TextView;
          layout_width="100dp";
          layout_height="40dp";
          gravity="center";
          text="联系反馈";
          Typeface=字体("product-Bold");
          textColor=primaryc;
          textSize="17dp";
        };


        {
          LinearLayout;
          id="mail";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_marginLeft="12dp";
            layout_height="30dp";
            src="res/twotone_email_black_24dp.png";
            ColorFilter=primaryc,
          };
          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="邮件反馈";
              textColor=textc;
              textSize="15sp";
              Typeface=字体("product-Bold");
            };
            {
              TextView;
              text="KonohataMira@outlook.com";
              textColor=textc;
              Typeface=字体("product");
              textSize="12sp";
            };
          };
        };
        --[[
        {
          LinearLayout;
          id="tubiao";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_height="30dp";
            src="res/wx.png";
            ColorFilter=primaryc,
          };
          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="ZYL趣闻分享";
              textColor=textc;
              Typeface=字体("product-Bold");
              textSize="15sp";
            };
            {
              TextView;
              text="公众号";
              textColor=textc;
              Typeface=字体("product");
              textSize="12sp";
            };
          };
        };
--]]
        {
          LinearLayout;
          id="tele";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_height="30dp";
            layout_marginLeft="12dp";
            src="res/tele.png";
            ColorFilter=primaryc,
          };
          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="t.me/ZYLtelegram";
              textColor=textc;
              Typeface=字体("product-Bold");
              textSize="15sp";
            };
            {
              TextView;
              text="TG群组";
              textColor=textc;
              Typeface=字体("product");
              textSize="12sp";
            };
          };
        };
      };




    };
  };

  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="16dp";
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
        LinearLayout;
        layout_width="fill";
        layout_height="fill";
        Orientation="vertical";
        --layout_marginTop="8dp";
        padding="8dp";
        {
          TextView;
          layout_width="100dp";
          layout_height="30dp";
          gravity="center";
          text="开源致谢";
          Typeface=字体("product-Bold");
          textColor=primaryc;
          textSize="17dp";
        };
        {
          TextView;
          layout_width="fill";
          layout_height="20dp";
          gravity="left";
          text="      Chimame Browser的诞生离不开他们的贡献。";
          Typeface=字体("product-Bold");
          textColor=primaryc;
          textSize="12dp";
        };
        --[[
        {
          LinearLayout;
          id="dy";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_height="30dp";
            src="res/dy.png";

          };
          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="dingyi";
              Typeface=字体("product-Bold");
              textColor=textc;
              textSize="15sp";
            };
            {
              TextView;
              text="dingyi浏览器";
              textColor=textc;
              Typeface=字体("product");
              textSize="12sp";
            };
          };
        };
        {
          LinearLayout;
          id="muk";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_height="30dp";
            src="res/muk.png";

          };
          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="MUK";
              Typeface=字体("product-Bold");
              textColor=textc;
              textSize="15sp";
            };
            {
              TextView;
              text="MDesign";
              textColor=textc;
              Typeface=字体("product");
              textSize="12sp";
            };
          };
        };

        {
          LinearLayout;
          id="k2";
          layout_width="fill";
          gravity="center|left";
          orientation="horizontal";
          {
            ImageView;
            layout_width="30dp";
            layout_margin="10dp";
            layout_height="30dp";
            src="res/hlgc.png";
            -- ColorFilter=0xFF8590D2,
          };
          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="10dp";
            layout_marginRight="10dp";
            orientation="vertical";
            {
              TextView;
              text="幻了个城fy";
              textColor=textc;
              Typeface=字体("product-Bold");
              textSize="15sp";
            };
            {
              TextView;
              text="捐赠功能";
              textColor=textc;
              Typeface=字体("product");
              textSize="12sp";
            };
          };
        };
--]]



        {
          LinearLayout;
          layout_height="-1";
          orientation="horizontal";
          layout_width="fill";
          {
            LinearLayout;
            layout_width="60dp";
            layout_height="60dp";
            layout_marginLeft="16dp";

            {
              ImageView;
              src="res/muk.png";
              padding="10dp";
            };
          };
          {
            LinearLayout;
            --   layout_width="80dp";
            --  layout_weight="1";
            layout_width="60dp";
            layout_height="60dp";
            {
              ImageView;
              --   layout_weight="1";
              src="res/dy.png";
              padding="10dp";
            };
          };
          {
            LinearLayout;
            --   layout_width="80dp";
            -- layout_weight="1";
            layout_width="60dp";
            layout_height="60dp";
            {
              ImageView;
              --layout_weight="1";
              src="res/akg.png";
              padding="10dp";
              scaleType="fitCenter";
            };
          };
          {
            LinearLayout;
            --   layout_width="80dp";
            -- layout_weight="1";
            layout_width="60dp";
            layout_height="60dp";
            {
              ImageView;
              --layout_weight="1";
              src="res/dmore.png";
              padding="10dp";
              scaleType="fitCenter";
            };
          };
        };
        --    };


        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          background="#00ffffff";
          layout_gravity="right";
          Elevation="0";
          layout_marginTop="4dp";
          layout_marginRight="16dp";
          layout_marginBottom="16dp";
          --     onClick=function()浏览器打开("http://mukapp.top/index.php/mdesign.html")end;
          onClick=function()activity.newActivity("sub/open_source")end;
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textSize="14sp";
            paddingRight="12dp";
            paddingLeft="12dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text="查看详情...";
            textColor=primaryc;
            id="open_detail";
            gravity="center";
            Typeface=字体("product-Bold");
          };
        };


      };



    };
  };

  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="16dp";
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
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        orientation="vertical";
        padding="24dp";
        {
          TextView;
          text="你渴望力量吗？";
          textColor=primaryc;
          textSize="17sp";
          gravity="center|left";
          Typeface=字体("product-Bold");
        };
        {
          TextView;
          text="此项目已开源：请审慎阅读《软件使用许可》以免造成不必要的问题。基于nirenr开源框架Androlua+的浏览器开发实践——为了更优美、更优质的Lua应用，冲鸭！ヾ(❀╹◡╹)ﾉ~";
          textColor=stextc;
          textSize="13sp";
          gravity="center|left";
          Typeface=字体("product");
          layout_marginTop="12dp";
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          background="#00ffffff";
          layout_gravity="right";
          Elevation="0";
          layout_marginTop="4dp";
          --     onClick=function()浏览器打开("http://mukapp.top/index.php/mdesign.html")end;
          onClick=function()浏览器打开("https://github.com/daisukiKaffuChino/Chimame-Browser")end;
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textSize="14sp";
            paddingRight="12dp";
            paddingLeft="12dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text="访问Github…";
            textColor=primaryc;
            id="open_source";
            gravity="center";
            Typeface=字体("product-Bold");
          };
        };
      };
    };
  };

  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="16dp";
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
        LinearLayout;
        id="ty1";
        layout_width="fill";
        gravity="center|left";
        orientation="horizontal";
        {
          ImageView;
          layout_width="30dp";
          layout_margin="10dp";
          layout_height="30dp";
          src="res/lsyy.png";
          -- ColorFilter=primaryc,

        };
        {
          LinearLayout;
          layout_width="fill";
          layout_marginLeft="10dp";
          layout_marginRight="10dp";
          orientation="vertical";
          {
            TextView;
            text="遵循《Android绿色应用公约》(Comply to “Convention of Green Apps for Android”)";
            Typeface=字体("product-Bold");
            textColor=textc;
            textSize="11sp";
          };

        };
      };

    };

  };

  {
    LinearLayout;
    id="ty3";
    layout_width="fill";
    gravity="center|left";
    orientation="horizontal";
    layout_marginLeft="8dp";
    {
      ImageView;
      layout_width="20dp";
      layout_margin="15dp";
      layout_height="20dp";
      src="res/twotone_copyright_black_24dp.png";
      ColorFilter=stextc,
    };
    {
      LinearLayout;
      layout_width="fill";
      layout_marginLeft="3dp";
      layout_marginRight="10dp";
      orientation="vertical";
      {
        TextView;
        text="版权所有©2018-2020 得想办法娶了智乃。保留所有权利。";
        Typeface=字体("product-Bold");
        textColor=textc;
        textSize="11sp";
      };
      {
        TextView;
        text="软件许可使用协议与隐私政策";
        Typeface=字体("product-Bold");
        textColor=primaryc;
        textSize="11sp";
        id="协议";
      };
    };


  };










};




bilu=
{
  DrawerLayout;
  id="dr";
  {
    RelativeLayout;
    layout_width="fill";
    layout_height="fill";
    {
      ScrollView;
      layout_width="fill";
      id="bit";
      OverScrollMode=2;
      verticalScrollBarEnabled=false;
      layout_height="fill";
      {
        LinearLayout;
        layout_width="fill";
        layout_height="fill";
        {
          LinearLayout;
          id="mty";
          layout_width="fill";
          layout_height="fill";

        },
      },
    };
    {
      FrameLayout;
      layout_width="fill";
      id="menus";
      --layout_alignParentBottom="true";
      background=backgroundc;
      layout_height="305dp";
      {
        ImageView;
        layout_width="fill";
        id="mn";
        layout_height="230dp";
        scaleType="centerCrop";

      };
      {
        FrameLayout;
        layout_marginTop="24sp";
        layout_width="fill";
        id="gft";
        background="#00000000";
        layout_height="fill";
        {
          LinearLayout;
          layout_width="fill";
          id="reo";
          gravity="center";
          orientation="horizontal";
          layout_height="55dp";
          {
            LinearLayout;
            gravity="center";
            layout_height="fill";
            {
              CardView;
              layout_width="80dp";
              background="#00000000";
              CardElevation="0dp";
              layout_marginLeft="-15dp";
              layout_height="80dp";
              PreventCornerOverlap=false;
              id="wk";
              radius="40dp";
              UseCompatPadding=false;
              {
                ImageView;
                layout_width="fill";
                id="btn";
                layout_margin="-10dp";
                layout_height="fill";
                background="#00000000";
                padding="38dp";
                src=图标("arrow_back");
              };
            };
          };
          {
            TextView;
            layout_width="fill";
            layout_height="fill";
            singleLine=true;
            gravity="center|left";
            layout_weight="1";
            textColor="#FFFFFF";
            layout_marginLeft="-15dp";
          };
          {
            CardView;
            id="bity1",
            layout_width="65dp";
            layout_height="65dp";
            background="#00000000";
            layout_marginRight="-17dp";
            PreventCornerOverlap=false;
            CardElevation="0dp";
            radius="33dp";
            Visibility=8;
            UseCompatPadding=false;
            {
              ImageView;
              layout_width="fill";
              id="btn1";
              layout_margin="-10dp";
              layout_height="fill";
              background="#00000000";
              padding="28dp";

            };
          };

        };
      };
      {
        TextView;
        background="#00000000";
        id="bhj",
        layout_width="fill";
        layout_height="24sp";
      };
    };
    {
      TextView;
      layout_height="224dp";
      id="mbys";
    };
    {
      TextView;
      layout_height="168dp";
      id="mby";
    };
    {
      TextView;
      layout_width="fill";
      id="标题";
      gravity="center|left";
      ellipsize="end";
      text=Html.fromHtml("<strong>关于 Chimame Browser</strong><br>"..GetAppInfo("com.ZYL.chimamebrowser"));
      textColor=primaryc;
      --      singleLine=true;
      textSize="13dp";
      Typeface=字体("product");
      layout_height="56dp";
      layout_marginRight="100dp";
      layout_marginLeft="90dp";
      layout_marginTop="249dp";
    };
  };
  {
    LinearLayout;
    layout_width="fill";
    layout_height="fill";
    gravity="top|right";
    orientation="vertical";
    id="xu";
    {
      CardView;
      layout_marginTop="200dp";
      id="ns";
      background=backgroundc;
      layout_height="90dp";
      radius=dp2px(45);
      CardElevation="8dp";
      layout_marginRight="20dp";
      layout_width="90dp";
      {
        ImageView;
        layout_width="fill";
        id="tass";
        layout_height="fill";
        -- rotation="180";
        scaleType="centerCrop";
        -- src="ic_select_all.png";
      };
    };
  };
};
table.insert(bilu,drawer)
ase=bilu[2][2][2][2]
table.insert(ase,main_layout)
activity.setContentView(loadlayout(bilu))
hsn=this.getResources().getDimensionPixelSize( luajava.bindClass("com.android.internal.R$dimen")().status_bar_height )--获取状态栏高

color1 = 0xffe71e62;
color2 = 0x00000000;

function vgy(view,color1,color2,times)
  ObjectAnimator.ofInt(view,"backgroundColor",{color1,color2}).setDuration(times).setEvaluator(ArgbEvaluator()).start()
  ObjectAnimator.ofFloat(ns,"alpha",{0,1}).setDuration(300).start()
end

function vgys(view,color1,color2,times)
  ObjectAnimator.ofInt(view,"backgroundColor",{color1,color2}).setDuration(times).setEvaluator(ArgbEvaluator()).start()
  ObjectAnimator.ofFloat(ns,"alpha",{1,0}).setDuration(300).start()
end

function vgys1(view,color1,color2,times)
  ObjectAnimator.ofInt(view,"backgroundColor",{color1,color2}).setDuration(times).setEvaluator(ArgbEvaluator()).start()
end

function vgys2(view,color1,color2,times)
  ObjectAnimator.ofInt(view,"backgroundColor",{color1,color2}).setDuration(times).setEvaluator(ArgbEvaluator()).start()
end

function sdry(e,i)
  ObjectAnimator().ofFloat(ns,"ScaleY",{e,i}).setDuration(300).start()
  ObjectAnimator().ofFloat(ns,"ScaleX",{e,i}).setDuration(300).start()
end

task(100,function()
  ades=menus.getHeight()
  mbt=标题.getY()
  标题.setScaleY(1.6)
  标题.setScaleX(1.6)
  --一定要给滚动父布局
  if mty.getHeight()<=bit.getHeight()-(mby.getHeight()/3)-hsn then
    layoutParams = mty.getLayoutParams();
    layoutParams.setMargins(0,ades,0,0);--4个参数按顺序分别是左上右下
    layoutParams.height =bit.getHeight()-(mby.getHeight()/3)-hsn
    mty.setLayoutParams(layoutParams);
   else
    layoutParams = mty.getLayoutParams();
    layoutParams.setMargins(0,ades,0,0);--4个参数按顺序分别是左上右下
    mty.setLayoutParams(layoutParams);
  end
end)

ase=true

version_sdk = Build.VERSION.SDK

function bit.onScrollChange(a,b,j,y,u)
  if j==0 then
    --标题.setTextSize(36)
    标题.setTranslationY(-hsn)
    --ObjectAnimator().ofFloat(ns,"TranslationY",{0,xu.getHeight()}).setDuration(500).start()
    --标题.setTextColor(0xFF000000)
    if CoordBottom~=nil then
      CoordBottom()
    end
    if tonumber(version_sdk)>=21 then
      menus.setTranslationZ(0)
      标题.setTranslationZ(0)
    end
    标题.setTranslationY(0)
    --gft.setBackgroundColor(Color.argb(0,231,30,98))
    标题.setScaleY(1.6)
    标题.setScaleX(1.6)
    linearParams = menus.getLayoutParams()
    linearParams.height =mbys.getHeight()+((mby.getHeight()/3)+hsn)
    menus.setLayoutParams(linearParams)
    mn.setTranslationY(0)
    xu.setTranslationY(0)
    标题.setTranslationX(0)
    if not ase then
      ase=true
      background = gft.getBackground();
      backgrounds1 = bhj.getBackground();
      vgy(gft,background.getColor(),color2,1000)
      vgys1(bhj,backgrounds1.getColor(),color2,1500)
      sdry(0,1)
    end
   elseif j > 0 and j <= mbys.getHeight() then
    if tonumber(version_sdk)>=21 then
      menus.setTranslationZ(0)
      标题.setTranslationZ(0)
    end
    scale = j / mbys.getHeight();
    alpha = (255 * scale);
    if CoordProg~=nil then
      CoordProg(scale)
    end
    标题.setTranslationY(-scale*mbys.getHeight())
    xu.setTranslationY(-scale*mbys.getHeight())
    mn.setTranslationY((-j/3))
    标题.setTranslationX(-(scale*(mby.getHeight()/5)))
    标题.setScaleY(1+(0.6*(1-scale)))
    标题.setScaleX(1+(0.6*(1-scale)))
    --gft.setBackgroundColor(Color.argb(alpha,231,30,98))
    linearParams = menus.getLayoutParams()
    linearParams.height =((mbys.getHeight()/4)+hsn)+(mbys.getHeight()-((j/mbys.getHeight())*mbys.getHeight()))
    menus.setLayoutParams(linearParams)

    if j<=mby.getHeight() then
      if not ase then
        ase=true
        background = gft.getBackground();
        backgroundsy1 = bhj.getBackground();
        vgy(gft,background.getColor(),color2,1000)
        vgys1(bhj,backgroundsy1.getColor(),color2,1000)
        sdry(0,1)
      end
     else
      if ase then
        ase=false
        backgrounds = gft.getBackground();
        backgroundsg1 = bhj.getBackground();
        vgys(gft,backgrounds.getColor(),color1,600)
        vgys2(bhj,backgroundsg1.getColor(),color1,600)
        sdry(1,0)
      end
    end

   else
    --标题.setTextSize(18)
    if ase then
      ase=false
      backgrounds = gft.getBackground();
      backgroundss1 = bhj.getBackground();
      vgys(gft,backgrounds.getColor(),color1,600)
      vgys2(bhj,backgroundss1.getColor(),color1,600)
      sdry(1,0)
    end
    标题.setTranslationY(-(mby.getHeight()+(mbys.getHeight()/4)))
    标题.setScaleY(1)
    标题.setScaleX(1)
    mn.setTranslationY(-((mbys.getHeight())/3))
    标题.setX((mby.getHeight()/3))
    if tonumber(version_sdk)>=21 then
      menus.setTranslationZ(8)
      标题.setTranslationZ(8)
    end
    xu.setTranslationY(-mbys.getHeight())
    linearParams = menus.getLayoutParams()
    linearParams.height =(mbys.getHeight()/4)+hsn
    menus.setLayoutParams(linearParams)
    if CoordTop~=nil then
      CoordTop()
    end
    --标题.setTextColor(0xFFFFFFFF)
    --gft.setBackgroundColor(Color.argb(255,231,30,98))
  end
end

--标题.getPaint().setTypeface(Typeface.DEFAULT_BOLD)

dr.setDrawerListener(DrawerLayout.DrawerListener{
  onDrawerSlide=function(v,i)
    btn.setTranslationX(1-i*btn.getWidth())
    if i==1 then
      --sdry(1,0)
      ObjectAnimator().ofFloat(ns,"TranslationY",{0,200,-xu.getHeight()/1.5}).setDuration(800).start()
     elseif i==0 then
      --sdry(0,1)
      ObjectAnimator().ofFloat(ns,"TranslationY",{-xu.getHeight()/1.5,200,50,-30,0}).setDuration(800).start()
    end
  end,
  onDrawerOpened=function(v)
    -- ObjectAnimator().ofFloat(ns,"TranslationX",{0,200,30,50,0}).setDuration(300).start()
  end,
})

--两个菜单按钮

bity1s=function(asr)
  function setTitle(bh)
    if bh~=nil then
      标题.Text=bh
    end
  end

end
bity2s=function(asr)

end


function CoordBackg(mbt)
  if mbt~=nil then
    mn.setImageBitmap(loadbitmap(mbt))
  end
end
function FabImage(mbt)
  if mbt~=nil then
    tass.setImageBitmap(loadbitmap(mbt))
  end
end
function setFabColor(color)
  if color~=nil then
    ns.setBackgroundColor(color)
  end
end
function setTitleColor(color)
  if color~=nil then
    标题.setTextColor(color)
  end
end

function setMenuColor(mct)
  if mct~=nil then
    btn.setColorFilter(mct)


  end
end

function setFabImageColor(color)
  if color~=nil then
    tass.setColorFilter(color)
  end
end







setMenuColor(转0x(primaryc))--设置标题栏图标颜色
--setFabImageColor(0xFFFFFFFF)--设置悬浮按钮图标颜色
--CoordBackg("https://wx4.sinaimg.cn/large/005WsnUygy1gfjq2o3ptrj317t0o3k8g.jpg")--设置标题图片
CoordBackg("acg_pic/about_bkg.png")
FabImage("icon.png")--悬浮按钮图片
--setFabColor(0xFF8BC34A)--悬浮按钮颜色


--悬浮按钮监听事件
--单击
--[[
function onFabClick()
  print("Fab")
end
--长按
function onFabLongClick()
end
--]]
--两个菜单按钮的显示与触发事件
bity1s(true)--设置true显示false隐藏默认不设置隐藏
bity2s(true)

--触发事件


--setTitle("青vvvvbbbbbbb芒用户")--设置标题

--自动置底事件
function CoordBottom()
  setTitleColor(转0x(primaryc))--设置标题颜色
end
--移动置顶事件
function CoordTop()
  setTitleColor(转0x(primaryc))
end
--移动监听事件
function CoordProg(ss)
  setTitleColor(转0x(primaryc))
end

color1=转0x(backgroundc)--标题栏颜色



波纹({kaifazhe},"方自适应")
波纹({ca},"方自适应")
波纹({mail},"方自适应")
波纹({tele},"方自适应")
波纹({k2},"方自适应")
波纹({muk},"方自适应")
波纹({log},"方自适应")
--波纹({up},"方自适应")
波纹({ty1},"方自适应")
波纹({ty2},"方自适应")
波纹({ty3},"方自适应")
波纹({协议},"方自适应")
波纹({btn},"圆自适应")
波纹({open_source},"方自适应")
波纹({open_detail},"方自适应")

btn.onClick=function()
  activity.finish()
end


tele.onClick=function()
  img = ImageView(this)
  img.setImageBitmap(loadbitmap("https://wx4.sinaimg.cn/mw690/005WsnUygy1gb0vn0qnfrj30pm0u776e.jpg"))--设置图片路径

  AlertDialog.Builder(this)
  .setView(img)--设置布局
  .setTitle("二维码")--设置标题
  .setPositiveButton("确定",function(v)--设置积极按钮

  end)

  .show()
end



mail.onClick=function()
  --[
  import "android.content.Intent"
  i = Intent(Intent.ACTION_SEND)
  i.setType("message/rfc822")
  i.putExtra(Intent.EXTRA_EMAIL, {"KonohataMira@outlook.com"})
  i.putExtra(Intent.EXTRA_SUBJECT,"反馈")
  i.putExtra(Intent.EXTRA_TEXT,"请在此输入你要反馈的内容：")
  activity.startActivity(Intent.createChooser(i, "选择一个邮件客户端。"))
end
--]]

--[[

kaifazhe.onClick=function()
  intent=Intent("android.intent.action.VIEW")
  intent.setPackage("com.coolapk.market")
  intent.setData(Uri.parse("coolmarket://u/2492447"))
  intent.addFlags(intent.FLAG_ACTIVITY_NEW_TASK)
  this.startActivity(intent)
end
--[
ca.onClick=function()
  intent=Intent("android.intent.action.VIEW")
  intent.setPackage("com.coolapk.market")
  intent.setData(Uri.parse( "market://details?id="..activity.getPackageName()))
  intent.addFlags(intent.FLAG_ACTIVITY_NEW_TASK)
  this.startActivity(intent)
end

--]
k2.onClick=function()
  intent=Intent("android.intent.action.VIEW")
  intent.setPackage("com.coolapk.market")
  intent.setData(Uri.parse("coolmarket://u/603089"))
  intent.addFlags(intent.FLAG_ACTIVITY_NEW_TASK)
  this.startActivity(intent)
end


muk.onClick=function()
  intent=Intent("android.intent.action.VIEW")
  intent.setPackage("com.coolapk.market")
  intent.setData(Uri.parse("coolmarket://u/1105973"))
  intent.addFlags(intent.FLAG_ACTIVITY_NEW_TASK)
  this.startActivity(intent)
end

--]]

--[[
up.onClick=function()
  包名=this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9)
  版本=tostring(包名.versionName)
  版本号=tonumber(包名.versionCode)
  更新链接="https://sharechain.qq.com/1a88af8f1c733cdc592294f7794cbb4c"
  Http.get(更新链接,nil,"UTF-8",nil,function(code,content,cookie,header)
    if(code==200 and content)then
      content=content:match("\"html_content\":(.-),"):gsub("\\u003C/?.-%>",""):gsub("\\n","\n"):gsub("&nbsp;"," "):gsub("&lt;","<"):gsub("&gt;",">"):gsub("&amp;","&"):gsub("&quot;","\""):gsub("&apos;","'")
      新版本=content:match("【版本】(.-)【版本】")
      新版本号=content:match("【版本号】(.-)【版本号】")
      更新日志=content:match("【更新内容】(.-)【更新内容】")
      --    gxurl=content:match("【下载链接】(.-)【下载链接】")

     else
      Snakebar("连接服务器失败("..code..")")
    end
    --    if 新版本号>tostring(this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9).versionCode) then
    AlertDialog.Builder(this)
    .setTitle("更新下载")
    .setMessage("最新版本："..新版本.."\n更新日志："..更新日志)
    .setPositiveButton("下载更新",function()

    end)
    .setNegativeButton("取消")
    .show()
    -- else
    --    Snakebar("已是最新版本")
    --    end
  end)
end
--]]

log.onClick=function()
  rizhi=[==[
没有
]==]
  双按钮对话框("更新日志",rizhi,"确定","",function()关闭对话框(an)end)

end



function 用户协议()
  if 全局主题值=="Day" then
    bwz=0x3f000000
   else
    bwz=0x3fffffff
  end

  local gd2 = GradientDrawable()
  gd2.setColor(转0x(backgroundc))--填充
  local radius=dp2px(16)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      LinearLayout;
      orientation="vertical";
      layout_width="-1";
      layout_height="-2";
      Elevation="4dp";
      BackgroundDrawable=gd2;
      id="ztbj";
      {
        TextView;
        layout_width="-1";
        layout_height="-2";
        textSize="20sp";
        layout_marginTop="24dp";
        layout_marginLeft="24dp";
        layout_marginRight="24dp";
        Text="服务说明";
        Typeface=字体("product-Bold");
        textColor=primaryc;
      };
      {
        ScrollView;
        layout_width="-1";
        layout_height="-1";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          orientation="vertical";
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="14sp";
            layout_marginTop="8dp";
            layout_marginLeft="24dp";
            layout_marginRight="24dp";
            --layout_marginBottom="8dp";
            Typeface=字体("product-Bold");
            Text="欢迎使用Chimame Browser，请阅读：";
            textColor=textc;
          };
          {
            LinearLayout;
            layout_width="-1";
            layout_height="-1";
            {
              TextView;
              layout_width="-2";
              layout_height="-2";
              textSize="14sp";
              --layout_marginTop="8dp";
              layout_marginLeft="24dp";
              layout_marginRight="4dp";
              --layout_marginBottom="8dp";
              Typeface=字体("product-Bold");
              Text="软件使用许可";
              textColor=secondaryc;
              onClick=function()
                activity.newActivity("sub/agreement",{1})
              end;
              background=波纹2("方",secondaryc);
            };
            {
              TextView;
              layout_width="-2";
              layout_height="-2";
              textSize="14sp";
              Typeface=字体("product-Bold");
              Text="和";
              textColor=textc;
            };
            {
              TextView;
              layout_width="-2";
              layout_height="-2";
              textSize="14sp";
              --layout_marginTop="8dp";
              layout_marginLeft="4dp";
              layout_marginRight="24dp";
              --layout_marginBottom="8dp";
              Typeface=字体("product-Bold");
              Text="隐私政策";
              onClick=function()
                activity.newActivity("sub/agreement",{2})
              end;
              textColor=secondaryc;
              background=波纹2("方",secondaryc);
            };
          };
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="14sp";
            --layout_marginTop="8dp";
            layout_marginLeft="24dp";
            layout_marginRight="24dp";
            layout_marginBottom="8dp";
            Typeface=字体("product-Bold");
            Text="您已同意上述协议。开发者保留随时更改条款而不提前通知的权利。";
            textColor=textc;
          };
        };
      };
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="-1";
        layout_height="-2";
        gravity="right|center";

        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          background=secondaryc;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=function()
            关闭对话框()
            activity.setSharedData("fake_agreement",true)
            --   提示("使用愉快~")
          end;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            paddingRight="16dp";
            paddingLeft="16dp";
            Typeface=字体("product-Bold");
            paddingTop="8dp";
            paddingBottom="8dp";
            Text="确认";
            textColor=backgroundc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  -- dl.setCancelable(false)
  an=dl.show()
  local window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  local wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);

end

--用户协议()

协议.onClick=function()
  用户协议()
end

import "bmob"
function update()
当前版本=tonumber((this.getPackageManager().getPackageInfo(this.getPackageName(),64).versionCode)) 
  local b=bmob("bf11b7c1f7ea2c8ff5411be4c800dd23","3648bc00f69d0082481bc07e2d0aa432")
  b:query("CBmessage",function(code,json)
    if code~=-1 and code>=200 and code<400 then
      --print(dump(json))
      if (json.results[1].last_versioncode>当前版本)then
      --判断远程的版本是否大于软件内部的版本，大于则进行更新
        up_tit.setText("发现新版本:"..json.results[1].last_versionname)
        up_subtit.setText(json.results[1].updatelog)
        else
        up_tit.setText("已经是最新了")
        up_card.Visibility=8
      end
    end
  end)
end

update()