require "import"
import "android.widget.*"
import "android.view.*"
import "mods.Chimame_Core"
import "android.widget.PopupMenu"
import "android.widget.CircleImageView"
import "android.app.AlertDialog"
import "android.widget.TextView"
import "android.view.Gravity"
import "android.R$menu"
import "android.widget.EditText"
import "android.widget.ListView"
import "android.R$layout"
import "android.widget.LinearLayout"
import "android.R$id"
import "android.widget.FrameLayout"
import "android.widget.ImageView"
import "com.androlua.LuaAdapter"
import"mods.control_function"
w=this.width

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
          text="网页控制";
          paddingLeft="16dp";
          textSize="20sp";
          layout_height="-2";
          layout_width="-2";
        };
        {
          LinearLayout;
          orientation="horizontal";
          layout_height="56dp";
          layout_width="fill";
          layout_marginRight="16dp";
          gravity="center|right";
          onClick=function()帮助()end;
          {
            ImageView;
            ColorFilter=primaryc;
            src="res/help_black.png";
            layout_height="32dp";
            layout_width="32dp";
            padding="4dp";
            id="help";
          };
        };
        -- };
      };
    };
    {
      FrameLayout;
      layout_width="fill";
      layout_height="fill";
      {
        ListView;
        layout_width="fill";
        layout_height="fill";
        dividerHeight="0";
        id="DAVRS";
      },

      {
        CardView;
        elevation="3dp";
        id="add";
        layout_height="55dp";
        layout_gravity="bottom|right";
        radius=dp2px(28);
        layout_margin="25dp";
        CardBackgroundColor=primaryc;
        layout_width="120dp";
        {
          LinearLayout;
          id="ty1";
          layout_width="fill";
          gravity="center";
          -- layout_marginLeft="20dp";
          layout_height="fill";
          orientation="horizontal";
          {
            ImageView;
            layout_width="26dp";
            id="ftb_img";
            layout_height="26dp";
            layout_marginLeft="20dp";
            layout_gravity="center";
            --elevation="2dp";
            src="res/add_black.png";
            colorFilter="#ffffffff";
          };

          {
            LinearLayout;
            layout_width="fill";
            layout_marginLeft="0dp";
            -- layout_marginRight="10dp";
            gravity="center|left";
            layout_height="fill";
            orientation="vertical";
            {
              TextView;
              text="添加";
              Typeface=字体("product-Bold");
              textColor="#ffffffff";
              textSize="15sp";
              layout_marginLeft="15dp";
              gravity="center|left";
            };
          };
        };
      };
    };
  };
}
activity.setContentView(loadlayout(layout))

item={
  LinearLayout;
  gravity="center";
  layout_width="fill";
  layout_height="-1";
  orientation="horizontal";

  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_marginLeft="16dp";
    layout_marginRight="16dp";
    layout_marginTop="8dp";
    layout_marginBottom="8dp";
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
        gravity="center";
        layout_width="fill";
        layout_height="-1";
        orientation="horizontal";
        {
          ImageView;
          layout_height="25dp";
          src="res/twotone_explore_black_24dp.png";
          --padding="10dp";
          layout_width="25dp";
          layout_marginLeft="10dp";
          colorFilter=primaryc;
        };
        {
          LinearLayout;
          layout_width="fill";
          layout_height="80dp";
          orientation="vertical";
          layout_marginLeft="20dp";
          {
            TextView;
            id="url";
            layout_height="40dp";
            layout_width="fill";
            textColor=textc,
            gravity="left|bottom",
            textSize="16sp",
            singleLine=true,

          };
          {
            TextView;
            id="element";
            layout_height="40dp";
            layout_width="fill";
            textColor=stextc,
            Typeface=字体("product");
            gravity="left",
            textSize="13sp",
            singleLine=true,
          };
        };
      };
    };
  };
};
function controlrefresh()
  adapter=LuaAdapter(this,cont,item)
  DAVRS.Adapter=adapter
end
controlrefresh()


function ControlPopShow()
  InputLayout={
    LinearLayout;
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      MEditText
      {
        textSize="14sp",
        id="urledit";
        hint="域名或URL";
        textColor=textc;
        HintTextColor=stextc;
        --SingleLine=true;
        layout_width="-1";
        layout_height="-2";
        --  text=source[id].url.text;
      };
      layout_margin="24dp";
      --layout_marginTop="16dp";
      layout_marginBottom="0";
    };
    {
      MEditText
      {
        textSize="14sp",
        id="elementedit";
        hint=[[删除元素(class或ID),填写ID使用#ID,用","分隔]];
        textColor=textc;
        HintTextColor=stextc;
        --SingleLine=true;
        layout_width="-1";
        layout_height="-2";
        --  text=source[id].element.text;
      };
      layout_margin="24dp";
      --layout_marginTop="16dp";
      layout_marginBottom="0";
    };
    --[[
      {
        EditText;
        id="jsedit";
        hint="填写要注入的js脚本";
        text=source[id].js.text;
        layout_marginTop="5dp";
        layout_width="80%w";
        layout_gravity="center",
        background="#00000000";
      };
    --]]
    {
      MEditText
      {
        textSize="14sp",
        id="jsedit";
        hint="填写要注入的js脚本";
        textColor=textc;
        HintTextColor=stextc;
        --SingleLine=true;
        layout_width="-1";
        layout_height="-2";
        --   text=source[id].js.text;
      };
      layout_margin="24dp";
      --layout_marginTop="16dp";
      layout_marginBottom="0";
    };
  };
  local dl=AlertDialog.Builder(activity)
  .setTitle("添加网页控制项目")
  .setView(loadlayout(InputLayout))
  .setPositiveButton("添加",{
    onClick=function()
      local urlmode=urledit.Text
      if #urlmode>7 then
        urlmode=urlmode:match("//(.-)/")
       elseif urlmode=="*" then
        urlmode="*"
       else
        urlmode=urlmode
      end
      local elementmode=elementedit.Text
      table.insert(cont,1,{
        url={
          text=urlmode,
        },
        element={
          text=elementmode,
        },
        js={
          text=jsedit.Text,
        },
      })
      NEWFILE=cjson.encode(cont)
      写入文件(网页控制,NEWFILE)
      controlrefresh()
    end})
  .setNegativeButton("取消",nil)
  .create()
  local dl =dl.show()
  local pw=dl.getWindow()
  .setGravity(Gravity.BOTTOM)
  弹窗圆角(pw,转0x(backgroundc))
  local lp=pw.getAttributes()
  lp.width=w
  pw.setAttributes(lp)
  pw.setDimAmount(0.35)
end

add.onClick=function ()
  ControlPopShow()
end

波纹({fh},"圆自适应")
波纹({help},"圆自适应")
波纹({ty1},"方白")

function 帮助()
  双按钮对话框(" 网页控制 帮助",
  "        网页控制有两个功能,元素删除与Js注入。\n\n        元素删除可以用来删除网页上各种的元素,如顶栏,图片,文字,链接等等。元素删除只需填写元素的class(类名)即可将其删除,如元素只有ID而没有class,则可以使用@ID(填写元素的ID)的方法将其删除。\n\n        Js注入则是对网页注入一段Javascript脚本。通过脚本可以实现一些特别的(针对性的)效果。",
  "我知道了",
  "取消",
  function()关闭对话框(an)end,
  function()关闭对话框(an)end)
end


DAVRS.onItemClick=function(adp,view,pos,id)
  source=cont
  pop=PopupMenu(activity,view.tag.url)
  menu=pop.Menu
  menu.add("删除").onMenuItemClick=function(a)
    table.remove(cont,id)
    NEWFILE=cjson.encode(cont)
    写入文件(网页控制,NEWFILE)
    controlrefresh()
  end
  menu.add("编辑").onMenuItemClick=function(a)
    InputLayout={
      LinearLayout;
      orientation="vertical";
      Focusable=true,
      FocusableInTouchMode=true,

      {
        MEditText
        {
          textSize="14sp",
          id="urledit";
          hint="域名或URL";
          textColor=textc;
          HintTextColor=stextc;
          --SingleLine=true;
          layout_width="-1";
          layout_height="-2";
          text=source[id].url.text;
        };
        layout_margin="24dp";
        --layout_marginTop="16dp";
        layout_marginBottom="0";
      };
      {
        MEditText
        {
          textSize="14sp",
          id="elementedit";
          hint=[[删除元素(class或ID),填写ID使用#ID,用","分隔]];
          textColor=textc;
          HintTextColor=stextc;
          --SingleLine=true;
          layout_width="-1";
          layout_height="-2";
          text=source[id].element.text;
        };
        layout_margin="24dp";
        --layout_marginTop="16dp";
        layout_marginBottom="0";
      };
      --[[
      {
        EditText;
        id="jsedit";
        hint="填写要注入的js脚本";
        text=source[id].js.text;
        layout_marginTop="5dp";
        layout_width="80%w";
        layout_gravity="center",
        background="#00000000";
      };
    --]]
      {
        MEditText
        {
          textSize="14sp",
          id="jsedit";
          hint="填写要注入的js脚本";
          textColor=textc;
          HintTextColor=stextc;
          --SingleLine=true;
          layout_width="-1";
          layout_height="-2";
          text=source[id].js.text;
        };
        layout_margin="24dp";
        --layout_marginTop="16dp";
        layout_marginBottom="0";
      };



    };
    local dl=AlertDialog.Builder(activity)
    .setTitle("添加网页控制项目")
    .setView(loadlayout(InputLayout))
    .setPositiveButton("添加",{
      onClick=function()
        table.remove(cont,id)
        NEWFILE=cjson.encode(cont)
        写入文件(网页控制,NEWFILE)
        table.insert(cont,1,{
          url={
            text=urledit.text,
          },
          element={
            text=elementedit.text,
          },
          js={
            text=jsedit.text,
          },
        })
        NEWFILE=cjson.encode(cont)
        写入文件(网页控制,NEWFILE)
        controlrefresh()
      end})
    .setNegativeButton("取消",nil)
    .create()
    local dl =dl.show()
    local pw=dl.getWindow()
    .setGravity(Gravity.BOTTOM)
    弹窗圆角(pw,转0x(backgroundc))
    local lp=pw.getAttributes()
    lp.width=w
    pw.setAttributes(lp)
    pw.setDimAmount(0.35)
  end
  pop.show()
  return true
end




