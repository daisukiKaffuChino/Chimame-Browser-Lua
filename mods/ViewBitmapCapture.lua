require "import"
import "java.io.File"
import "java.io.FileOutputStream"
import "android.os.Build"

import "android.graphics.Canvas"
import "android.graphics.Bitmap"

import "android.renderscript.Allocation"
import "android.renderscript.Element"
import "android.renderscript.RenderScript"
import "android.renderscript.ScriptIntrinsicBlur"


function getblurBitmap(bitmap,radius)
  if bitmap and radius then
    output=Bitmap.createBitmap(bitmap)
    rs=RenderScript.create(this)
    gaussian=ScriptIntrinsicBlur.create(rs, Element.U8_4(rs))
    In=Allocation.createFromBitmap(rs, bitmap)
    Out=Allocation.createFromBitmap(rs, output)
    gaussian.setRadius(radius)
    gaussian.setInput(In)
    gaussian.forEach(Out)
    Out.copyTo(output)
    rs.destroy() 
    return output
   else
    return false
  end
end


function getViewBitmap(view)
  
  if view then
    view.destroyDrawingCache()
    view.setDrawingCacheEnabled(true)
    view.buildDrawingCache()
    return view.getDrawingCache()
   else
    return false
  end
end







function captureLongBitmap(view,height,width)
  
  
  
  
  if Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP then
    提示("正在获取截图\n请稍候")
    
    if height and width then
      bitmap=Bitmap.createBitmap(width,height,Bitmap.Config.RGB_565)
     else
      bitmap=Bitmap.createBitmap(view.width,view.height,Bitmap.Config.RGB_565)
    end
    canvas=Canvas(bitmap)
    view.draw(canvas)
    return bitmap
   else
    
    
    
    return getViewBitmap(webView)
  end
end


function savePicture(fileName,bitmap,msg,shouldPrintIfFinish)
  
  
  
  
  if bitmap and fileName then
    import "java.io.FileOutputStream"
    import "java.io.File"
    import "android.graphics.Bitmap"
    f,e=pcall(function ()
      local fileName=File(tostring(fileName))
      out = FileOutputStream(fileName)
      bitmap.compress(Bitmap.CompressFormat.PNG,90, out)
      out.flush()
      out.close()
    end)
    if not e then
      if shouldPrintIfFinish then
        提示("保存成功，保存在了\n"..fileName)
      end
      if msg then
        print(tostring(msg))
      end
      return true
     else
      if shouldPrintIfFinish then
        提示("保存失败 "..e)
      end
      return false
    end
   else
    if shouldPrintIfFinish then
      提示("保存失败, 没有传入图片")
    end
    return false
  end
end
