function boundaryPlot(obj,h_axe)
    set(h_axe, 'NextPlot', 'add')
    % 绘制开边界
    for i = 1:length(obj.OpenBoundaryPositionXY_cell)
        plot(h_axe, obj.OpenBoundaryPositionXY_cell{i}(:,1),...
            obj.OpenBoundaryPositionXY_cell{i}(:,2),'b')
    end
    % 绘制陆地边界
    for i = 1:length(obj.LandBoundaryPositionXY_cell)
        plot(h_axe, obj.LandBoundaryPositionXY_cell{i}(:,1),...
            obj.LandBoundaryPositionXY_cell{i}(:,2),'k')
    end
end