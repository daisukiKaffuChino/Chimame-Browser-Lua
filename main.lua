--Apache 2.0


require "import"
import "mods.Chimame_Core"
--this.setSharedData("Theme","Day")


function onNewIntent(intent)
onNewIntent_Web()
end


if activity.getSharedData("agreement") then
-- print (mukactivity.getData("Setting_Boot_Image"))

-- print(activity.getSharedData("Setting_Boot_Img"))
if not activity.getSharedData("Setting_Boot_Img") then
  activity.newActivity("mods/first_boot")--boot
 activity.finish()  
  else
  activity.newActivity("home")
  activity.finish()
  end
  
  else
 -- this.setSharedData("Theme","Day")
  activity.newActivity("sub/welcome")
  activity.finish()
  end


--activity.newActivity("sub/login")
--activity.newActivity("sub/setting")
--activity.newActivity("sub/bmob_user")
--activity.newActivity("sub/theme")
--print("111")
--activity.newActivity("sub/welcome")
--activity.newActivity("sub/web_control")
--activity.newActivity("sub/error_sign")
--activity.newActivity("sub/about")
--activity.newActivity("sub/agreement")
--activity.newActivity("mlua/mlua_handbook")



