##模块分工
![image](http://images2015.cnblogs.com/blog/897300/201606/897300-20160618112002432-1431124676.png)
##代码模块排列顺序
首先是判断电梯目前是否应该停止，然后判断电梯门开闭，然后再确定电梯的目标楼层，最后再更新各面板和指示灯的显示。
##算法设计（按照代码模块排列顺序）
#1.汪正勇
电梯运行到指定楼层停止，由于这里不用考虑实际情况中的减速情况，要想让电梯停下来，只需要让电机停止工作就可以了。逻辑即为判断当前楼层是否是目标楼层，是就将电机停止信号置1，电机停止，当前楼层不是目标楼层就不动作，判断下一个楼层和目标，依次判断所有目标和当前楼层是否相同，选择是否发出停止信号即可。
#2.吴川
原本是使用梯形图实现，但是后来无法编译通过不能与其他组员的st语言契合，于是改为st。
电梯轿厢在楼层停稳后延迟2秒钟打开电梯门和在电梯门关闭过程中如有人在外面按下与电梯运行方向一致的按钮，则电梯门再次打开
需要保证每次平层时只有一次开关门，防止轿厢一直上升或下降而不执行平层开关门程序，同时也防止电梯一直处于开关门状态。
左右电梯使用不同的计数器计数两次然后清零。在门完全打开时计数，计数到时间就开门。关门的电机运行时如果外部同楼层有按键按下，并且按键的方向与下一时刻目标楼层所在方向一致，那么就开门
自定义变量j1和j2:分别用于左右电梯用于记时打开电梯门
#3.李戈
用的是分情况讨论的方法。分别有当电梯停止且i>=10时使电梯门关闭。
当电梯停止时，若按电梯门开按钮，电梯门在关闭中时，开启电梯门。
当电梯停止时，若按电梯门关按钮，电梯门为开启状态时，关闭电梯门。
自定义变量i1和i2:分别用于左右电梯用于记时关闭电梯门
关门的电机运行时如有人在轿厢内按下开门按钮，则电梯门再次打开
#4.郑君政
根据日常使用经验我们采取了运行方向一致原则和最近距离优先原则，再为了简化算法采取了上层命令优先原则。
算法示例：
IF Current_Floor_Left = 1 THEN  // 当电梯处于1楼的情况下
	……
IF LeftCabin.Key_Floor2 = 1 OR Floor2Panel.Key_Up = 1 THEN  //当电梯井2楼按钮被按下或2楼外部面板的上升按钮被按下
		……
ELSIF LeftCabin.Key_Floor3 = 1 OR Floor3Panel.Key_Up = 1 THEN  // floor 3
……
	……
	END_IF
END_IF;
其中当电梯响应电梯井2楼按钮LeftCabin.Key_Floor2 = 1)或2楼外部面板的上升按钮(Floor2Panel.Key_Up = 1)是运行方向一致原则的体现。IF语句是按顺序从上到下进行条件语句判断，条件语句的前后顺序实质上是一种优先级的排序，将2楼的情况放在3楼前面正是最近距离优先原则的体现。将当前楼层上方的条件语句排在前面，将当前楼层下方的楼层的条件语句排在后面是上层命令优先原则的体现。
#5.熊唐程
电梯上下调度的时候判断左右电梯谁去哪一层楼的时候，是可能出现冲突的，这种冲突只发生在两台电梯都停止的时候，在电梯都停止时，判断左右电梯谁更接近有需要的楼层，然后近者先去，一样近的时候左电梯先行。不会造成左右电梯都出发并到达目的地的情况，合理使用资源。
使用到的硬件接口有左右电梯的电机停止，左右当前楼层，目标楼层。左电梯作为默认电梯先进行判断，两电梯都停止时判断左右电梯离目前左电梯目标楼层远近，右电梯更近则将左电梯目标值赋予右电梯并让左电梯目标值就为左电梯当前楼层值。从而使更近的电梯赶往目的地。
#6.蔡诗旭
算法主要包括两方面：
①.电梯轿厢内数字指示灯的亮起与熄灭
按下按键后数字指示灯的亮起。按键被按下，Key_Floor1从状态0被置为1，并且在Display_Floor1Selected=UnChecked，即指示灯未亮起时，指示灯的状态置为Checked，即亮起。
到达指定楼层后，该楼层按键的熄灭。当Sensor_Floor1Approached=1，即到达指定楼层，并且Sensor_DoorOpened=1，即门被打开时，将该楼层的数字指示灯置为UnChecked，即熄灭。
②.楼层上下行按键指示灯的亮起与熄灭
电梯停在需求楼层后，按键指示灯的熄灭。需要Sensor_Floor1Approached=1 和Sensor_DoorOpened=1 同时成立才能才能熄灭。第一层没有向下按钮，第七层没有向上按钮。
##时间安排
第十五周：6月5日之前提交第一稿，确定算法，试探各个模块之间的契合关系
第十六周：准备考试，巩固机电传动控制的理论知识，为下一周做准备
第十七周：整合代码，整体调试
