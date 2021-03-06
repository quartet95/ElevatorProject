
PROGRAM _CYCLIC
	(* Insert code here *)
	(*ÏÂÁÐ´úÂëÖ»ÊÇÎªÁË²âÊÔ*)
	
	
	LeftTower.Signal_Start_DoorMotor_P := LeftCabin.Key_Open ;
	LeftTower.Signal_Start_DoorMotor_N := LeftCabin.Key_Close ;
	
	RightTower.Signal_Start_DoorMotor_P := RightCabin.Key_Open ;
	RightTower.Signal_Start_DoorMotor_N := RightCabin.Key_Close ;
	
	LeftTower.Signal_Start_CabinMotor_P := Floor1Panel.Key_Up ;
	RightTower.Signal_Start_CabinMotor_P := Floor1Panel.Key_Up ;
	
	LeftTower.Signal_Start_CabinMotor_N := Floor7Panel.Key_Down ;
	RightTower.Signal_Start_CabinMotor_N := Floor7Panel.Key_Down ;

	LeftTower.Signal_Stop_CabinMotor := Floor3Panel.Key_Up ;
	RightTower.Signal_Stop_CabinMotor := Floor3Panel.Key_Up ;
	
	IF LeftCabin.Display_Floor1Selected = UnChecked AND LeftCabin.Key_Floor1 =1 THEN
		LeftCabin.Display_Floor1Selected := Checked;
	END_IF	
	IF LeftCabin.Display_Floor2Selected = UnChecked AND LeftCabin.Key_Floor2 =1 THEN
		LeftCabin.Display_Floor2Selected := Checked;
	END_IF	
	IF LeftCabin.Display_Floor3Selected = UnChecked AND LeftCabin.Key_Floor3 =1 THEN
		LeftCabin.Display_Floor3Selected := Checked;
	END_IF	
	IF LeftCabin.Display_Floor4Selected = UnChecked AND LeftCabin.Key_Floor4 =1 THEN
		LeftCabin.Display_Floor4Selected := Checked;
	END_IF	
	IF LeftCabin.Display_Floor5Selected = UnChecked AND LeftCabin.Key_Floor5 =1 THEN
		LeftCabin.Display_Floor5Selected := Checked;
	END_IF	
	IF LeftCabin.Display_Floor6Selected = UnChecked AND LeftCabin.Key_Floor6 =1 THEN
		LeftCabin.Display_Floor6Selected := Checked;
	END_IF	
	IF LeftCabin.Display_Floor7Selected = UnChecked AND LeftCabin.Key_Floor7 =1 THEN
		LeftCabin.Display_Floor7Selected := Checked;
	END_IF	
	
	IF RightCabin.Display_Floor1Selected = UnChecked AND RightCabin.Key_Floor1 =1 THEN
		RightCabin.Display_Floor1Selected := Checked;
	END_IF	
	IF RightCabin.Display_Floor2Selected = UnChecked AND RightCabin.Key_Floor2 =1 THEN
		RightCabin.Display_Floor2Selected := Checked;
	END_IF	
	IF RightCabin.Display_Floor3Selected = UnChecked AND RightCabin.Key_Floor3 =1 THEN
		RightCabin.Display_Floor3Selected := Checked;
	END_IF	
	IF RightCabin.Display_Floor4Selected = UnChecked AND RightCabin.Key_Floor4 =1 THEN
		RightCabin.Display_Floor4Selected := Checked;
	END_IF	
	IF RightCabin.Display_Floor5Selected = UnChecked AND RightCabin.Key_Floor5 =1 THEN
		RightCabin.Display_Floor5Selected := Checked;
	END_IF	
	IF RightCabin.Display_Floor6Selected = UnChecked AND RightCabin.Key_Floor6 =1 THEN
		RightCabin.Display_Floor6Selected := Checked;
	END_IF	
	IF RightCabin.Display_Floor7Selected = UnChecked AND RightCabin.Key_Floor7 =1 THEN
		RightCabin.Display_Floor7Selected := Checked;
	END_IF	
		
	(*此处插入左电梯目标楼层判断代码*)
	(*下面是左右电梯分工判断*)
	// 当两侧电梯均处于停止状态
	IF LeftTower.Signal_Stop_CabinMotor = 1 AND RightTower.Signal_Stop_CabinMotor = 1 THEN
		IF ABS(Current_Floor_Left - Target_Floor_Left) > ABS(Current_Floor_Right - Target_Floor_Left) THEN
			Target_Floor_Right := Target_Floor_Left; // 将左侧电梯目标值赋给右侧电梯目标
			Target_Floor_Left := Current_Floor_Left; // 将左侧电梯目标赋值为当前位置使其保持停止
			RETURN; // 结束函数
		END_IF
	END_IF
	
	(*此处插入右电梯目标楼层判断代码*)
	
	(*让电梯上下运动起来*)
	IF Target_Floor_Left > 0 AND Target_Floor_Left < 8 AND LeftTower.Sensor_DoorClosed = 1  THEN
		IF LeftCabin.Display_Current_Floor < Target_Floor_Left THEN // 上行
			LeftTower.Signal_Start_CabinMotor_P := 1;
			LeftTower.Signal_Start_CabinMotor_N := 0;
			LeftTower.Signal_Stop_CabinMotor := 0;			
		ELSIF LeftCabin.Display_Current_Floor > Target_Floor_Left THEN // 下行
			LeftTower.Signal_Start_CabinMotor_P := 0;
			LeftTower.Signal_Start_CabinMotor_N := 1;
			LeftTower.Signal_Stop_CabinMotor := 0;
		ELSE // 不动
			LeftTower.Signal_Start_CabinMotor_P := 0;
			LeftTower.Signal_Start_CabinMotor_N := 0;
			LeftTower.Signal_Stop_CabinMotor := 1;
		END_IF
	END_IF
		IF Target_Floor_Right > 0 AND Target_Floor_Right < 8 AND RightTower.Sensor_DoorClosed = 1  THEN
		IF RightCabin.Display_Current_Floor < Target_Floor_Right THEN // 上行
			RightTower.Signal_Start_CabinMotor_P := 1;
			RightTower.Signal_Start_CabinMotor_N := 0;
			RightTower.Signal_Stop_CabinMotor := 0;			
		ELSIF RightCabin.Display_Current_Floor > Target_Floor_Right THEN // 下行
			RightTower.Signal_Start_CabinMotor_P := 0;
			RightTower.Signal_Start_CabinMotor_N := 1;
			RightTower.Signal_Stop_CabinMotor := 0;
		ELSE // 不动
			RightTower.Signal_Start_CabinMotor_P := 0;
			RightTower.Signal_Start_CabinMotor_N := 0;
			RightTower.Signal_Stop_CabinMotor := 1;
		END_IF
	END_IF
	
END_PROGRAM
