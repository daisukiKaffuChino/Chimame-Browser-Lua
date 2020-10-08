require "import"
import "mods.Chimame_Core"


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
      layout_height="-2";
      elevation="0";
      background=backgroundc;
      orientation="vertical";
      {
        LinearLayout;
        layout_width="fill";
        layout_height="56dp";
        gravity="center|left";
        {
          LinearLayout;
          orientation="horizontal";
          layout_height="56dp";
          layout_width="56dp";
          gravity="center";
          onClick=function()关闭页面()end;
          {
            ImageView;
            ColorFilter=primaryc;
            src=图标("arrow_back");
            layout_height="32dp";
            layout_width="32dp";
            padding="4dp";
            id="fh";
          };
        };
        {
          TextView;
          textColor=primaryc;
          Typeface=字体("product-Bold");
          id="title";
          paddingLeft="16dp";
          textSize="20sp";
          layout_height="-2";
          layout_width="-2";
        };
      };
    };
    {
      LinearLayout;
      orientation="vertical";
      layout_gravity="center";
      gravity="center";
      layout_height="fill";
      {
        ImageView;
        layout_gravity="center";
        layout_height="180dp";
        src="acg_pic/kidai.png";
        layout_width="180dp";
      };
      {
        TextView;
        text="敬请期待哦( ๑ˊ•̥▵•)੭₎";
        layout_marginTop="10dp";
        textColor=stextc;
        Typeface=字体("product-Bold");
        textSize="14sp";
      };
    };

  };
}
activity.setContentView(loadlayout(layout))