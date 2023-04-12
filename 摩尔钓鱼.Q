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

// 天气代码
sunny = 1 // 晴天
rainy = 0 // 雨天

// 鱼饵代码
bait_1 = 1 // 初级鱼饵
bait_2 = 2 // 中级鱼饵
bait_3 = 3 // 高级鱼饵


// 初始化本次钓鱼基本信息
//confPath = "D:\develop\workspace\anjian\fishLog.txt" // 日志文件全路径


// 这里是每次钓鱼要更改的地方
placeCode = JIAYUAN                  // 钓鱼点代码
rodGrade = ROD_2                     // 鱼竿等级
weather  = sunny
bait = bait_1

// 根据不同的鱼饵等级输出到不同的日志文件
confPath = "D:\develop\workspace\anjian\fishLog.txt" // 定义日志文件全路径
if bait = bait_1 then
	confPath = "D:\develop\workspace\anjian\fishLog_bait1.txt" // 日志文件全路径
elseif bait = bait_2 then
	confPath = "D:\develop\workspace\anjian\fishLog.txt" // 日志文件全路径
elseif bait = bait_3 then
	confPath = "D:\develop\workspace\anjian\fishLog_bait3.txt" // 日志文件全路径
endif

// 鱼咬钩后，根据鱼竿等级不同执行不同的估算遛鱼时间
walkFishTime = 2000 // 定义变量
if rodGrade = ROD_1 then
	walkFishTime = 2250 // 小号鱼竿等级1，遛鱼估算时间为2250
elseif rodGrade = ROD_2 then
	walkFishTime = 2125  // 不大不小的号，鱼竿等级2，遛鱼估算时间2125
elseif rodGrade = ROD_3 then
	walkFishTime = 2000  // 大号鱼竿等级3，遛鱼估算时间为2000
endif

dateTime = Plugin.Sys.GetDateTime() // 得到操作系统日期和时间 格式： 2023/4/11
inf = "=============> "
inf = inf & dateTime     
inf = inf & " weatherCode = " & weather       
inf = inf & " placeCode = " & placeCode
inf= inf & " rod grade = " & rodGrade
inf = inf & " <============="
Call Plugin.File.WriteFileEx(confPath, inf) 


For i = 0 To 2000
	s1 = Plugin.Sys.GetTime()  // 从操作系统启动到目前的毫秒数，记录循环的开始时间
	
	Delay 600
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
	Delay walkFishTime    // 等待鱼进圈，大号鱼竿等级3：设置为2000 小号鱼竿等级1：2200-2300，2250即可
	KeyPress "Space", 1 // 收钩
	Delay 1000
	LeftClick 1// 点掉收获界面
	Delay 500
	LeftClick 1
	Delay 500
	
	// 日志处理逻辑
	s2 = Plugin.Sys.GetTime()// 从操作系统启动到目前的毫秒数
	s = s2 - s1            // 钓鱼时间
	waitingTime = wait2 - wait1//等待鱼上钩的时间
	dateTime = Plugin.Sys.GetDateTime()
	
	inf = i & " "& dateTime & " fishing time: " & s &  " ms"  // 本次钓鱼总时间
	inf = inf & " waiting time: " & waitingTime & " ms "// 等待鱼上钩的时间
	inf = inf & "getLegendFish: " & "undefined"// 本次是否得到传说鱼 
	inf = inf & " full: " & "undefined"  // 当前钓鱼点是否拉满
	Call Plugin.File.WriteFileEx(confPath, inf)
Next