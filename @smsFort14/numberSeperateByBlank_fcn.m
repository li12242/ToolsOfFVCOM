function num_col = numberSeperateByBlank_fcn(str)
% 提取字符串中由空格隔开的数值
% Get the value seperated by blans in strings

% str 原始字符串
% num_col 提取出来的数值按列排序
% isBlank 代表前一个字符是否为空格 1 = Y；0 = N
% num_contour 字符串中有几个数值

    str=[str,' ']; % 给字符串结尾加上一个空格，每个数值前后都有空格隔开

    isBlank=1;
    num_contour=0;
    for i=1:numel(str)
        if (str(i)~=' ')&&isBlank==0
            isBlank=0;
        elseif (str(i)~=' ')&&isBlank==1
            num_contour=num_contour+1;
            isBlank=0;
        else
            isBlank=1;
        end
    end

    num_col=zeros(num_contour,1);
    num_change_number=1; %转换的第几个数值
    start_mark=1; %数值开始处字符串序号标记

    isBlank=1;
    for i=1:numel(str)
        if (str(i)~=' ')&&isBlank==0
            isBlank=0;
        elseif (str(i)~=' ')&&isBlank==1
            isBlank=0;
            start_mark=i;
        elseif (str(i)==' ')&&isBlank==0
            num_col(num_change_number)=str2double(str(start_mark:i));
            num_change_number=num_change_number+1;
            isBlank=1;
        else
            isBlank=1;
        end
    end