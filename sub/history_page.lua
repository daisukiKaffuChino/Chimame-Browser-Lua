require "import"
import "android.widget.*"
import "android.view.*"
import "android.os.*"
import "mods.Chimame_Core"
import "android.graphics.drawable.GradientDrawable"
import "mods.history"


初始化历史记录数据(true,"history")

if (save==true)then
  loadrecord(recordname,recordurl)
end
local recordn=recordname
local recordu=recordurl
反向数据(recordn)
反向数据(recordu)
local oldviewlayout={
  LinearLayout;
  orientation="1";
  id="caa";
  layout_height="fill";
  layout_width="fill";
  gravity="left";
  padding="8dp";
  background=backgroundc;
  {
    RelativeLayout;
    layout_height="48dp";
    gravity="center|center";
    paddingTop="4dp";
    paddingBottom="4dp";
    {
      ImageButton;
      style="?android:attr/buttonBarButtonStyle";
      id="back";
      background="#00000000";
      padding="0dp";
      paddingLeft="2dp";
      paddingRight="2dp";
      layout_marginRight="12dp";
      layout_marginLeft="2dp";
      layout_width="32dp";
      layout_height="fill";
      src="res/twotone_arrow_back_black_24dp.png";
      colorFilter=primaryc;
      layout_centerVertical="true";
    };
    {
      TextView;
      text="历史记录";
      gravity="center";
      layout_width="wrap_content";
      id="title";
      layout_height="fill";
      textSize="20sp";
      layout_toRightOf="back";
      Typeface=字体("product-Bold");
      textColor=primaryc;
      layout_centerVertical="true";
    };
    {
      ImageButton;
      style="?android:attr/buttonBarButtonStyle";
      src="res/delete_sweep_black.png";
      id="delete";
      background="#00000000";
      colorFilter=primaryc;
      padding="0dp";
      paddingLeft="2dp";
      paddingRight="2dp";
      layout_marginRight="2dp";
      layout_width="32dp";
      layout_height="fill";
      layout_alignParentRight="true";
      layout_centerVertical="true";
    };
  };
  {
    ListView;
    paddingTop="3dp";
    id="oldview";
    padding="6dp";
    layout_width="fill";
    fastScrollEnabled=false;
    layout_height="fill";
  };
  {
    TextView;
    id="empty";
    layout_width="fill";
    layout_height="fill";
    text="没有历史记录_(:3」∠❀)_";
    visibility="gone";
    Typeface=字体("product");
    gravity="center";
    textColor=textc;
  };
};
activity.setContentView(loadlayout(oldviewlayout))
oldview.setDividerHeight(0)
if (#recordn==0)then
  oldview.setVisibility(8)
  empty.setVisibility(0)
end
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
    maxHeight='32dp',
    maxWidth='32dp',
    paddingLeft="6dp",
    layout_width='wrap_content',
    layout_height='match_parent',
    layout_column='0',
  },
  {
    TextView,
    id='text',
    textColor=textc,
    textSize='15sp',
    layout_margin='10dp',
    layout_marginRight='16dp',
    ellipsize="end",
    Typeface=字体("product");
    layout_column='1',
    layout_width='match_parent'
  },
  {
    TextView,
    id='text2',
    Visibility=8,
  },
}
  local data={}
  for n=1,#recordn do
    table.insert(data,{
      text={
        Text=recordn[n],
      },
      text2={
        Text=recordu[n],
      },
    })
  end
  adp=LuaAdapter(this,data,item)
  oldview.Adapter=adp
  oldview.onItemClick=function(l,v,c,b)
    activity.setSharedData("history_going",v.Tag.text2.Text)
    activity.finish()
    return true
  end
  back.onClick=function()
    activity.finish()
  end
  delete.onClick=function()
    清除历史记录("history")
    提示("清除成功啦ヾ ^_^♪")
    oldview.setVisibility(8)
    empty.setVisibility(0)
  end