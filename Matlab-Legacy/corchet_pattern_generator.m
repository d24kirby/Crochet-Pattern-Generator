% Pattern Generator For Corchet
clear
clc
close all
%% Gather input parameters
img_path = input('Please enter the image filename including extenstion: ','s');
pattern_width = input('Pattern width in decimal inches: ');
pattern_height = input('Pattern height in decimal inches: ');
stitches_4 = input('Number of stiches per 4" square: ');
rows_4 = input('Number of rows of stiches per 4" square: ');

%% Math things for actual pattern
rows = ceil((pattern_height/4)*rows_4 + 1);
cols = ceil((pattern_width/4)*stitches_4 + 1);

%% Image processing
[img,map] = imread(img_path);
img_r = imresize(img, [rows cols]);
if (isempty(map))
    [IMG,map] = rgb2ind(img_r,16);
else
    IMG = img_r;
end
pattern = double(IMG);

%% Plot Stuff
h = figure;
pcolor(flipud(pattern));
ax = gca;
hold on
xAxis = 1:cols;
yAxis = 1:rows;
set(ax,'XTick',xAxis,'YTick',yAxis)

% Obtain the tick mark locations
xtick = get(ax,'XTick'); 
ytick = get(ax,'YTick');

% Obtain the limits of the axis
xlim = get(ax,'Xlim');
ylim = get(ax,'Ylim');

% Create line data
X = repmat(xtick,2,1);
x = repmat(xlim',1,size(ytick,2));
Y = repmat(ytick,2,1);
y = repmat(ylim',1,size(xtick,2));

% Plot line data
plot(X,y,'r',x,Y,'r')

% Remap tick labels for printing
xTickLabels = cell(1,numel(xAxis));  % Empty cell array the same length as xAxis
xTickLabels(5:5:numel(xAxis)) = num2cell(xAxis(5:5:numel(xAxis)));
                                     % Fills in only the values you want
set(ax,'XTickLabel',xTickLabels);   % Update the tick labels

yTickLabels = cell(1,numel(yAxis));  % Empty cell array the same length as xAxis
yTickLabels(5:5:numel(yAxis)) = num2cell(yAxis(5:5:numel(yAxis)));
                                     % Fills in only the values you want
set(ax,'YTickLabel',yTickLabels);   % Update the tick labels

%Set colormap
colormap(map)

%% Make pdf file
set(h,'Units','Inches');
pos = get(h,'Position');
set(h, 'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3) pos(4)]);
saveas(h,'pattern','pdf');
