classdef smsFort14 < handle
    % 读取 fort.14 网格信息
    properties(SetAccess = private)
        pointNum                            % 节点个数
        elementNum                          % 单元个数
        PointPositionXY                     % xy坐标，double[ ?x2]
        PointDepth                          % 水深正值，double[ ?x1 ]
        ElementComponent                    % 组成每个单元节点序号，double[ ?x3 ]
        OpenBoundarySerial_cell             % 开边界节点序号，double[ ?x1]
        LandBoundarySerial_cell             % 陆边界节点序号，double[ ?x1]
        OpenBoundaryPositionXY_cell         % 开边界坐标，double[ ?x2]
        LandBoundaryPositionXY_cell         % 陆边界坐标，double[ ?x2]
    end
    
    properties(SetAccess = private, GetAccess = private)
        openBoundaryNum
        landBoundaryNum
%         OpenBoundarySerial_cell
%         LandBoundarySerial_cell
    end
    
    methods
        function obj = smsFort14(filename)
            import FVCOM.smsFort14
            global fig
            
            fig = fopen(filename,'r');
            %try
            fgets(fig);
            str = fgets(fig);
            s = smsFort14.numberSeperateByBlank_fcn(str);
            obj.elementNum = s(1);
            obj.pointNum = s(2);
            %得到fort.14中点的个数
            point_data=fscanf(fig,'%d %f %f %f\n',[4,obj.pointNum]);
            point_data=point_data';

            obj.PointPositionXY=point_data(:,[2,3]);
            obj.PointDepth=point_data(:,4);
            %得到所有节点信息
            ele_data = fscanf(fig,'%d %d %d %d %d\n',[5,obj.elementNum]);
            ele_data=ele_data';
            obj.ElementComponent = ele_data(:,[3,4,5]);
            %得到所有单元信息
            open_boundary_str=fgets(fig);
            % fgetl(fig);
            % 获得开边界总条数
            obj.openBoundaryNum = smsFort14.getNumInString_fcn(open_boundary_str,'front');
            % obj.openBoundaryNum = openBoundaryNum;
            obj.OpenBoundarySerial_cell = cell(obj.openBoundaryNum,1);
            obj.OpenBoundaryPositionXY_cell = cell(obj.openBoundaryNum,1);
            fgets(fig); 
            % 获得所有开边界的节点总数，例如：
            % '91 = Total number of open boundary nodes'

            obj.OpenBoundarySerial_cell = smsFort14.readFort14Boundary_fcn(obj.openBoundaryNum);


            land_boundary_str=fgets(fig);
            % 获得路边界总条数，例如
            % '6 = Number of land boundaries'
            obj.landBoundaryNum = smsFort14.getNumInString_fcn(land_boundary_str,'front'); % 陆边界的个数
            % obj.landBoundaryNum = landBoundaryNum;
            fgets(fig);         % 获得所有陆边界的节点总数
            obj.LandBoundarySerial_cell = smsFort14.readFort14Boundary_fcn(obj.landBoundaryNum);
            obj.LandBoundaryPositionXY_cell = cell(obj.landBoundaryNum,1);
            fclose(fig);
            
            for i = 1:obj.openBoundaryNum
                obj.OpenBoundaryPositionXY_cell{i} = point_data(obj.OpenBoundarySerial_cell{i},[2,3]);
            end
            for i = 1:obj.landBoundaryNum
                obj.LandBoundaryPositionXY_cell{i} = point_data(obj.LandBoundarySerial_cell{i},[2,3]);
            end
        end
        
        % plot boundaries on spicific axes
        boundaryPlot(obj,h_axe)
        
%         % judge point inside or outside
%         isIn = isInside(obj, boundary, position)
    end
    methods(Static)
        num_col = numberSeperateByBlank_fcn(str)
        % 提取字符串中由空格隔开的数值
        % Get the value seperated by blans in strings
        
        num = getNumInString_fcn(str,directionStr)
        % 字符串中数值筛选
        % directionStr 表示筛选方向：'front'选取字符串首的数值，'back'选取字符串尾部数值
        
        BoundarySerial_cell = readFort14Boundary_fcn(BoundaryNum)
        % 读取 fort.14 边界信息，格式为：
    end
end