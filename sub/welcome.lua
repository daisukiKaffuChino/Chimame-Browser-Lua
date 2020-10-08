require "import"
import "android.widget.*"
import "android.view.*"
import "mods.Chimame_Core"
function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    --监听阻止返回键
    return true
  end
end
layout={
  LinearLayout;
  layout_width="-1";
  layout_height="-1";
  gravity="center";
  orientation="vertical";
  id="_";
  {
    ImageView;
    layout_width="100dp";
    layout_marginTop="-130dp";
    src="icon.png";
  };
  {
    TextView;
    text="欢迎使用\nChimame Browser";
    textColor=primaryc;
    textSize="24sp";
    id="_title";
    gravity="center";
    layout_width="-2";
    layout_height="-2";
    Typeface=字体("product-Bold");
  };

  {
    TextView;
    text="Featherweight\nModular\nFree compilation";
    textColor=primaryc;
    textSize="18sp";
    id="_subtitle";
    gravity="center";
    layout_width="-2";
    layout_height="-2";
    Typeface=字体("product");
    alpha=0;
  };
  {
    TextView;
    text="重新设计的架构，让我们开启全新体验吧";
    textColor=primaryc;
    textSize="16sp";
    id="hajimema";
    gravity="center";
    layout_width="-2";
    layout_height="-2";
    Typeface=字体("product");
    alpha=0;
  };
  {
    ProgressBar;--默认圆圈
    id="进度条";
    layout_marginBottom="-400dp";
  };
};
--pcall尝试设置视图
if pcall(function()
    设置视图(layout)--设置视图
  end) then
  --如果可以设置视图
  ti=Ticker()--定时器
  ti.Period=2000
  ti.onTick=function()
    ti.stop()
    -- activity.newActivity("home",android.R.anim.fade_in,android.R.anim.fade_out)
    --activity.finish()
  end
  ti.start()

  --字体动画
  tt = ObjectAnimator.ofFloat(_title, "Y",{activity.height*(3/8), activity.height/6-dp2px(30)})
  tt.setInterpolator(DecelerateInterpolator())
  tt.setDuration(1000)
  at = ObjectAnimator.ofFloat(_title, "alpha", {0, 1})
  at.setDuration(1000)

  tst = ObjectAnimator.ofFloat(_subtitle, "Y",{activity.height*(3/4), activity.height/2.8+dp2px(30)})
  tst.setInterpolator(DecelerateInterpolator())
  tst.setDuration(1000)
  ast = ObjectAnimator.ofFloat(_subtitle, "alpha", {0, 1})
  ast.setDuration(1000)

  btt = ObjectAnimator.ofFloat(hajimema, "Y",{activity.height*(3/4), activity.height/1.7-dp2px(30)})
  btt.setInterpolator(DecelerateInterpolator())
  btt.setDuration(1000)
  bat = ObjectAnimator.ofFloat(hajimema, "alpha", {0, 1})
  bat.setDuration(1000)
  set = AnimatorSet()--动画排序
  set.play(tst).after(tt)
  set.play(ast).after(at)
  set.play(btt).after(tst)
  set.play(bat).after(ast)
  set.start()
 else
  --如果不可以设置视图，重新加载此页面以解决问题（19 6-6发现及修复此问题）
  activity.newActivity("sub/welcome")
  activity.finish()
end


进度条.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(转0x(primaryc),PorterDuff.Mode.SRC_ATOP))


task(6500,function()
  进度条.setVisibility(View.INVISIBLE)

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
            Text="点击“同意”即代表您同意上述协议。";
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
          radius="2dp";
          background="#00000000";
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginBottom="24dp";
          Elevation="0";
          onClick=function()
            os.exit()
          end;
          {
            TextView;
            layout_width="-1";
            layout_height="-2";
            textSize="16sp";
            Typeface=字体("product-Bold");
            paddingRight="16dp";
            paddingLeft="16dp";
            paddingTop="8dp";
            paddingBottom="8dp";
            Text="退出";
            textColor=stextc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-2";
          layout_height="-2";
          radius="4dp";
          background=primaryc;
          layout_marginTop="8dp";
          layout_marginLeft="8dp";
          layout_marginRight="24dp";
          layout_marginBottom="24dp";
          Elevation="1dp";
          onClick=function()
            关闭对话框()            
            activity.setSharedData("agreement",true)
            activity.newActivity("home",android.R.anim.fade_in,android.R.anim.fade_out)
            activity.finish()
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
            Text="同意";
            textColor=backgroundc;
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
      
    };
  };

  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  dl.setCancelable(false)
  an=dl.show()
  local window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  local wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
end)

提示("正在释放资源")


--]]
