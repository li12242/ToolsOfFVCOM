function num = getNumInString_fcn(str,directionStr)
    % 字符串中数值筛选
    % directionStr 表示筛选方向：'front'选取字符串首的数值，'back'选取字符串尾部数值

    switch directionStr
        case 'front'
            for j=1:length(str)
                if abs(str(j))>57||abs(str(j))<48
                    str(j+1:end)=[];    % 去掉数字之后的字符
                    break
                end
            end
        case 'back'
            for j=length(str):-1:1
                if abs(str(j))>57||abs(str(j))<48
                    str(1:j)=[];    % 去掉数字之后的字符
                    break
                end
            end
    end
    num = str2double(str);