program SpeedWord;
uses crt, windows;
type WS = array [1..201] of String;
var WORD : WS;
	Time : Longint;
procedure TaoBang (x, y, x1, y1 : Byte);
var xi, yi:Byte;
begin
	gotoxy(x1, y1);
	for xi := x1 to x do 
		write('=');
	for yi := y1 to y do 
		begin
			gotoxy(xi, yi);
			write('||');
		end;
	for xi := x-1 downto x1 do 
		begin
			gotoxy(xi, yi);
			write('=')
		end;
	for yi := y downto y1 do 
		begin
			gotoxy(xi, yi);
			write('||');
		end;
end;
procedure INPUT;
var WORDE, WORDV : Text;
	Lang : Shortint;
	i : Byte;
begin
	textcolor(2);
	write('Chon Ngon Ngu Tieng Anh[0], Tieng Viet[1] :');
	readln(Lang);
	while ( (Lang < 0) or ( Lang > 1) ) do 
		begin
			gotoxy(42, 1);
			readln(Lang);
		end;
	if (Lang = 0) then 
		begin
			assign(WORDE, 'WORD.INP'); reset(WORDE);
			for i:=1 to 200 do 
				readln(WORDE, WORD[i]);
		end
			else 
				begin
					assign(WORDV, 'WORD2.INP'); reset(WORDV);
					for i:=1 to 200 do 
						readln(WORDV, WORD[i]);
				end;
end;
procedure GUI;
begin
	TaoBang(97, 23, 4, 1); // Main
	Textcolor(3);
	TaoBang(66, 9, 7, 2); // Next
	Textcolor(14);
	TaoBang(95, 22, 68, 2); // Info
	Textcolor(4); 
	TaoBang(66, 22, 7, 10); //Write Word
	gotoxy(80, 4);
	write('Time:');
	gotoxy(79, 11);
	write('Correct:');
	gotoxy(80, 19);
	write('Wrong:');
end;
procedure WriteW;
var S, S1, S2, S3 : String;
	a : Char;
	Sai, Dung : Boolean;
	Wrong, Correct, xW, TT, STT: Byte;
begin
	Wrong := 0; Correct := 0; 
	randomize;
	gotoxy(12, 5);
	Textcolor(10);
	write('Next: ');
	S1 := WORD[random(199) + 1];        
	S2 := WORD[random(199) + 1];
	S3 := WORD[random(199) + 1];
	while ( GetTickCount - Time <= 60000 ) do 
		begin
			TT := 1; STT := 0; Sai := false;
			S := '';
			gotoxy(82, 14);
			write(Correct);
			gotoxy(82, 20);
			write(Wrong);
			gotoxy(82, 5);
			write(round( ( GetTickCount - Time ) / 1000 ));
			gotoxy(18, 5);
			textcolor(4);
			write(S1, ' ', S2, ' ', S3);
			gotoxy(24, 14);
			//Write Here//
			textcolor(5);
			a := readkey;
			if ( a <> Chr(8) ) then 
				begin
					if ( S1[TT] <> a ) then
						begin
							textcolor(4);
							Sai := true;
						end;
					S := S + a;
					write(a);
					xW:=WhereX;
				end; 	
			if ( a = Chr(8) ) then
			 	begin
			 		textcolor(5);
			 		Sai := false;
			 	end;		
			while ( a <> ' ' ) do 
				begin
					a := readkey;
					xW:=WhereX;
					if ( a <> Chr(8) ) then 
						begin
							inc(TT);
							if ( ( S1[TT] <> a ) and ( Sai = false ) ) then 
								begin
									STT := TT;
									Sai := true;
									textcolor(4);
								end; 
							write(a);
							S:= S + a;
						end
							else 
								if (xW >= 24) then 
									begin
										gotoxy(xW - 1, 14);
										write(' ');
										gotoxy(xW - 1, 14);
										delete(S, length(S), 1);
										dec(TT);
										if ( TT <= STT ) then
											begin
												Sai := false;
												STT := 0;
												textcolor(5);
											end; 
									end;
				end;
			delete(S, length(S), 1);
			if ( S = S1 ) then 
				inc(Correct)
					else 
						inc(Wrong);
			gotoxy(23, 14);
			textcolor(4);
			write('                                           ||');
			textcolor(14);
			write('||                         ||');
			textcolor(2);
			write('||');
			S1 := S2;
			S2 := S3;
			S3 := WORD[random(199) + 1];
			gotoxy(18, 5);
			textcolor(9);
			write('                                                ||');
			textcolor(14);
			write('||                         ||');
			textcolor(2);
			write('||');
		end;
	gotoxy(14, 14);
	Textcolor(14);
	write('Toc Do Cua Ban La ', Correct, 'WPM, Do Chinh Xac La ', Correct / ( Correct + Wrong ) * 100 : 0 : 2, '%'); 
end;
begin
	INPUT; clrscr; 
	GUI;
	gotoxy(24, 12);
	Textcolor(14);
	write('Bam Enter De Bat Dau');
	readln;
	gotoxy(24, 12);
	textcolor(4);
	write('                                          ||');
	textcolor(14);
	write('||                         ||');
	textcolor(2);
	write('||');
	Time:=GetTickCount;
	WriteW;
	gotoxy(14, 15);
	readln;
end.
