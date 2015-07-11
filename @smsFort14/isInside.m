function isIn = isInside(obj, boundary, position)
boundary = boundary(1:10:end, :);
delta   = boundary - repmat(position, size(boundary,1), 1);
delta_f = delta([2:end,1], :);
temp    = sqrt(sum(delta.^2, 2)) .* sqrt(sum(delta_f.^2,2));
temp    = sum(delta.*delta_f,2)./temp;
theta   = acos(temp);
isIn = ~(sum(theta) == 0);
end