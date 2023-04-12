MoveTo 1486, 627
LeftClick 1
Delay 50
KeyPress "F11", 1//全屏



// 定义常数
// 钓鱼点代码
ZHAOZE = 1                // 迷雾沼泽
JINGJI = 2                // 荆棘丛林
JIAYUAN = 3               // 家园
XUESHAN = 4               // 雪山
SHATAN = 5                // 阳光沙滩，菩提处

// 鱼竿等级
ROD_1 = 1
ROD_2 = 2
ROD_3 = 3



confPath = "D:\develop\workspace\anjian\fishLog.txt" // 日志文件全路径
dateTime = Plugin.Sys.GetDateTime() // 得到操作系统日期和时间 格式： 2023/4/11
placeCode = ZHAOZE                   // 钓鱼点代码
rodGrade = ROD_3                     // 鱼竿等级

// 初始化本次钓鱼基本信息
inf = "=====> "
inf = inf & dateTime                  
inf = inf & "placeCode = " & placeCode
inf = inf & " 我开始钓鱼啦 " & " <====="
Call Plugin.File.WriteFileEx(confPath, inf) 



For i = 0 To 2000

	//s = 0
	//inf = "日期：" & dateTime & "  " & "当前i=" & i & "本次循环运行时间" & s & "毫秒"
	//Call Plugin.File.WriteFileEx(confPath, inf)// 文件不存在的话，创建并写入字符串inf的内容；文件存在的话，在末尾写入inf的内容
	
	
	s1 = Plugin.Sys.GetTime()  // 从操作系统启动到目前的毫秒数，记录循环的开始时间
	Delay 1000
	KeyPress "Space", 1//抛钩

	wait1 = Plugin.Sys.GetTime() // 记录等待鱼上钩的时间
	// 等待鱼上钩
	Do While True
		FindColorEx 1612,708,1698,791,"9DFEFF",0,0.9,intX,intY
		If intX > 0 And intY > 0 Then 
			Exit Do
		End If
	Loop
	wait2 = Plugin.Sys.GetTime()

	KeyPress "Space", 1  // 鱼上钩
	Delay 2250    // 等待鱼进圈，大号2000；小号2200-2300，2250即可
	KeyPress "Space", 1 // 收钩
	Delay 1000
	LeftClick 1// 点掉收获界面
	Delay 500
	LeftClick 1
	
	// 日志处理逻辑
	s2 = Plugin.Sys.GetTime()// 从操作系统启动到目前的毫秒数
	s = s2 - s1            // 钓鱼时间
	waitingTime = wait2 - wait1  //等待鱼上钩的时间

	//xs = int(s / 1000 / 60 / 60)      // 得到小时数
	//fz = int( s / 1000 /60 ) - xs * 60  // 分钟
	//m = Clng(s / 1000) - fz * 60 - xs * 60 * 60// 秒
	
	inf = i & " fishing time: " & s &  "ms"  // 本次钓鱼总时间
	inf = inf & " waiting time: " & waitingTime // 等待鱼上钩的时间
	inf = inf & "getLegendFish:" & "undefined"  // 本次是否得到传说鱼
	Call Plugin.File.WriteFileEx(confPath, inf) 
	
Next

