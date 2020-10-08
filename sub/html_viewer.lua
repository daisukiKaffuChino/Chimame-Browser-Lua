require "import"
import "mods.Chimame_Core"

pageurl=...

function onCreate()
  layout={
    LinearLayout;
    layout_height="-1";
    layout_width="-1";
    orientation="vertical";
    background=backgroundc;
    {
      LinearLayout;--标题栏
      orientation="horizontal";
      layout_height="56dp";
      layout_width="-1";
      background=barbackgroundc;
      gravity="center|left";
      id="mActionBar";
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
          id="back";
          onClick=function()关闭页面()end;
        };
      };

      {
        TextView;--标题
        Typeface=字体("product-Bold");
        textSize="20sp";
        Text="网页源代码";
        ellipsize="end";
        layout_marginLeft="16dp";
        SingleLine=true;
        textColor=primaryc;
        id="title";
        layout_weight="1";
      };
      {
        ImageView;
        src="res/twotone_search_black_24dp.png";
        ColorFilter=primaryc;
        layout_width="32dp",
        layout_height="32dp",
        padding="4dp";
        layout_margin="8dp";
        id="search";
        onClick=function()
          _bottombar.Visibility=0
        end;
      };
      {
        TextView;
        id="_more_lay";
        layout_width="0",
        layout_height="0",
        layout_gravity="top";
      };
    };

    {
      RelativeLayout;
      layout_height="-1";
      layout_width="-1";
      id="_root";
      {
        LuaWebView;--主体
        layout_height="-1";
        layout_width="-1";
        id="web";
      };
      {
        LinearLayout;
        layout_height="-1";
        layout_width="-1";
        orientation="vertical";
        background=viewshaderc;
        {
          TextView;
          layout_width="-1";
          layout_height="2dp";
          id="webprogress";
        };
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        gravity="bottom|center";
        id="_bottombar";
        Visibility=8,
        {
          LinearLayout;
          layout_width="fill";
          orientation="horizontal";
          layout_height="44dp";

          {
            LinearLayout;
            gravity="center";
            layout_width="44dp";
            layout_height="44dp";
            id="关闭";
            onClick=function()
              web.findAllAsync("")
              edt.setText(nil)
              _bottombar.Visibility=8
            end,
            {
              ImageView;
              layout_height="22dp";
              src="res/clear_black.png";
              colorFilter=primaryc,--图片颜色
              layout_width="22dp";
            };
          };
          {
            LinearLayout;
            layout_height="fill";
            layout_weight="1";
            orientation="horizontal";
            {
              EditText;
              textColor=textc;
              layout_gravity="center";
              textSize="16sp";
              layout_weight="1";
              layout_marginRight="10dp";
              id="edt";
              hint="页内查找...";
              singleLine=true;
              hintTextColor=stextc;
              BackgroundColor="#00000000";
            };
          };
          {
            LinearLayout;
            gravity="center";
            layout_width="44dp";
            layout_height="44dp";
            id="下翻";
            onClick=function()web.findNext(true)end,
            {
              ImageView;
              layout_height="22dp";
              src="res/arrow_downward_black.png";
              colorFilter=primaryc,--图片颜色
              layout_width="22dp";
            };
          };
          {
            LinearLayout;
            gravity="center";
            layout_width="44dp";
            layout_height="44dp";
            id="上翻";
            onClick=function()web.findNext(false)
            end,
            {
              ImageView;
              layout_height="22dp";
              src="res/arrow_upward_black.png";
              colorFilter=primaryc,--图片颜色
              layout_width="22dp";
            };
          };
        };
      };
    };
  };

  设置视图(layout)

  波纹({back},"圆自适应")
  波纹({上翻},"圆自适应")
  波纹({下翻},"圆自适应")
  波纹({search},"圆自适应")
  波纹({关闭},"圆自适应")

  web.removeView(web.getChildAt(0))

  import "org.jsoup.*"

  web.loadUrl(pageurl)--加载网页

  edt.addTextChangedListener{
    onTextChanged=function(s)
      web.findAllAsync(edt.text)
    end}
  function 设置值(anm)
    import "android.graphics.Paint$Align"
    import "android.graphics.Paint$FontMetrics"
    local myLuaDrawable=LuaDrawable(function(mCanvas,mPaint,mDrawable)

      --获取控件宽和高的最小值
      local r=math.min(mDrawable.getBounds().right,mDrawable.getBounds().bottom)

      --画笔属性
      mPaint.setColor(转0x(primaryc))
      mPaint.setAntiAlias(true)
      mPaint.setStrokeWidth(r/8)
      mPaint.setStyle(Paint.Style.STROKE)
      --mPaint.setStrokeCap(Paint.Cap.ROUND)

      local mPaint2=Paint()
      mPaint2.setColor(转0x(primaryc))
      mPaint2.setAntiAlias(true)
      mPaint2.setStrokeWidth(r/2)
      mPaint2.setStyle(Paint.Style.FILL)
      mPaint2.setTextAlign(Paint.Align.CENTER)
      mPaint2.setTextSize(sp2px(14))

      --圆弧绘制坐标范围:左上坐标,右下坐标

      return function(mCanvas)
        local n=anm*360/100

        local fontMetrics = mPaint2.getFontMetrics();
        local top = fontMetrics.top;--为基线到字体上边框的距离,即上图中的top
        local bottom = fontMetrics.bottom;--为基线到字体下边框的距离,即上图中的bottom

        local baseLineY =r/2 - top/2 - bottom/2

        if anm==100 then
          mCanvas.drawText("完成",r/2,baseLineY,mPaint2);
         else
          mCanvas.drawText(tostring(anm),r/2,baseLineY,mPaint2);
        end

        mCanvas.drawArc(RectF(r/8/2,r/8/2,r-r/8/2,r-r/8/2),-90,n,false,mPaint)

        --mDrawable.invalidateSelf()
      end
    end)
  end


  --PopupWindow

  import "com.lua.*"

  静态渐变(转0x(primaryc)-转0x("#9f000000"),转0x(primaryc),webprogress,"横")

  web.setWebChromeClient(LuaWebChrome(LuaWebChrome.IWebChrine{
    onProgressChanged=function(view, newProgress)
      设置值(newProgress)
      local lpm=webprogress.getLayoutParams()
      lpm.width=newProgress*(activity.Width/100)
      webprogress.setLayoutParams(lpm)
    end,
  }));

  web.setWebViewClient{
    shouldOverrideUrlLoading=function(view,url)

    end,
    onPageStarted=function(view,url,favicon)
      控件可见(webprogress)
      wurl=url
      --网页加载

    end,
    onPageFinished=function(view,url)
      控件隐藏(webprogress)
    end
  }

  web.getSettings().setSupportZoom(true);
  web.getSettings().setBuiltInZoomControls(true);
  web.getSettings().setDefaultFontSize(14);
  web.getSettings().setDisplayZoomControls(false);
  web.getSettings().setUseWideViewPort(true);
  web.getSettings().setLoadWithOverviewMode(true);
  web.getSettings().setJavaScriptEnabled(true);
  web.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
  web.getSettings().setAllowFileAccess(true);
  web.getSettings().setAppCacheEnabled(true);
  web.getSettings().setDomStorageEnabled(true);
  web.getSettings().setDatabaseEnabled(true);


end

