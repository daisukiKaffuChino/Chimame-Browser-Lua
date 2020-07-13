require "import"
import "android.R$id"
import "android.widget.CircleImageView"
import "android.view.ViewGroup"
import "android.view.View"
import "android.graphics.drawable.GradientDrawable"
import "android.view.WindowManager"
import "com.nirenr.Color"
import "android.graphics.Color"
import "java.io.File"
 
  
cjson=require("cjson")
function 写入文件(路径,内容)
  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w"):write(tostring(内容)):close()
end
if File("/sdcard/Chimame Browser/").exists() then
 else
  File("/sdcard/Chimame Browser/").mkdir()
end
if File("sdcard/Chimame Browser/PageControl/").exists() then
 else
  File("/sdcard/Chimame Browser/PageControl/").mkdir()
end
软件基本数据="sdcard/Chimame Browser/PageControl/"
网页控制=软件基本数据.."StoreData.json"
if File(网页控制).exists() == false then
  写入文件(网页控制,"[]")
end
function control()
  a=io.open(网页控制):read("*a")
  cont=cjson.decode(a)
end
function split(str,split_char)
  local Lines = {}
  str = str..split_char
  for i in str:gmatch("(.-)"..split_char.."(.-)") do
    Lines[#Lines + 1] = i
  end
  return Lines
end
function 加载脚本(id,js)
  if js==nil then
   else
    id.evaluateJavascript("(function() {"..js.."})()",nil)
  end
end
function 屏蔽元素(id,table)
  for i,V in pairs(table) do
    加载脚本(id,[[var remove=n=>{n.split(",").forEach(v=>{if(v.indexOf("@ID(")==0){document.getElementById(v.substring(4,v.length-1)).style.display="none"}else{for(let e of document.getElementsByClassName(v))e.style.display="none"}})}
remove("]]..V..[[")]])
  end
end
control()


function 状态栏高度()
  local h=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)
  return h
end
function 弹窗圆角(控件,背景色,上角度,下角度)
  if not 上角度 then
    上角度=25
  end
  if not 下角度 then
    下角度=0
  end
  控件.setBackgroundDrawable(GradientDrawable()
  .setShape(GradientDrawable.RECTANGLE)
  .setColor(背景色)
  .setCornerRadii({上角度,上角度,上角度,上角度,下角度,下角度,下角度,下角度}))
end

