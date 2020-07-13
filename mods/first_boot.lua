require "import"
--import "mods.muk"
import "mods.zyl"
--this.setSharedData("Theme","Night")


-----这里是启动页的事件-----

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
    text="Chimame Browser";
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
    text="0.200 PreView Virson";
    textColor=primaryc;
    textSize="18sp";
    id="_subtitle";
    gravity="center";
    layout_width="-2";
    layout_height="-2";
    Typeface=字体("product");
    alpha=0;
  };
};
--pcall尝试设置视图
if pcall(function()

    设置视图(layout)--设置视图
  end) then
  --如果可以设置视图
  ti=Ticker()--定时器
  ti.Period=2300
  ti.onTick=function()
    ti.stop()
    activity.newActivity("home",android.R.anim.fade_in,android.R.anim.fade_out)
    activity.finish()
  end
  ti.start()

  --字体动画
   tt = ObjectAnimator.ofFloat(_title, "Y",{activity.height*(3/4), activity.height/2-dp2px(30)})
  tt.setInterpolator(DecelerateInterpolator())
  tt.setDuration(1000)
  at = ObjectAnimator.ofFloat(_title, "alpha", {0, 1})
  at.setDuration(1000)
  tst = ObjectAnimator.ofFloat(_subtitle, "Y",{activity.height*(3/4), activity.height/2+dp2px(30)})
  tst.setInterpolator(DecelerateInterpolator())
  tst.setDuration(1000)
  ast = ObjectAnimator.ofFloat(_subtitle, "alpha", {0, 1})
  ast.setDuration(1000)
  set = AnimatorSet()--动画排序
  set.play(tst).after(tt)
  set.play(ast).after(at)
  set.start()
 else
  --如果不可以设置视图，重新加载此页面以解决问题（19 6-6发现及修复此问题）
  activity.newActivity("mods/first_boot")
  activity.finish()
end
