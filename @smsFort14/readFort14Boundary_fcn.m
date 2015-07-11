function BoundarySerial_cell = readFort14Boundary_fcn(BoundaryNum)
% 读取 fort.14 边界信息，格式为：
% 2 10 = Number of nodes for land boundary 1
% 398
% 411
% 2 10 = Number of nodes for land boundary 2
% 381
% 398
% ……
    import FVCOM.smsFort14
    global fig

    if BoundaryNum==0
        BoundarySerial_cell=[];
        return
    end

    BoundarySerial_cell = cell(BoundaryNum,1);
    for i=1:BoundaryNum
        str=fgets(fig);
        % 获得第i条开边界的节点总数，例如
        % '91 = Number of nodes for open boundary 1'
        num = smsFort14.getNumInString_fcn(str,'front'); %第i条开边界的节点总数
        BoundarySerial_cell{i}=zeros(num,1);
        for j=1:num
            temp=fscanf(fig,'%d\n',1);
%             temp=str2double(temp);
            BoundarySerial_cell{i}(j)=temp;
        end
    end