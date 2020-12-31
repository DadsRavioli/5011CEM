[X] = 30.15:0.1:69.85; % create X value
[Y] = -24.85:0.1:44.85;% create Y values

Z = ncread('C:\Users\Dads Ravioli\Desktop\Year 3 Work\50011CEMMatlab\data.nc', 'ensemble_ozone');
%% Create a display of the data from the NetCDF files like this
[X,Y] = meshgrid(X, Y);

figure(1);
clf
% Create the map
worldmap('Europe'); % set the part of the earth to show

load coastlines
plotm(coastlat,coastlon)

land = shaperead('landareas', 'UseGeoCoords', true);
geoshow(gca, land, 'FaceColor', [0.5 0.7 0.5])

lakes = shaperead('worldlakes', 'UseGeoCoords', true);
geoshow(lakes, 'FaceColor', 'blue')

rivers = shaperead('worldrivers', 'UseGeoCoords', true);
geoshow(rivers, 'Color', 'blue')

cities = shaperead('worldcities', 'UseGeoCoords', true);
geoshow(cities, 'Marker', '.', 'Color', 'red')

surfm(X, Y, Z, Z, Z, Z, Z, Z, Z, Z, Z, 'EdgeColor', 'none',...
    'FaceAlpha', 0.5) 

%% Plot contour map
% [X,Y] = meshgrid(X, Y); % this calculation has been carried out above
% already
clf

% creating the map
worldmap('Europe'); % set the part of the earth to show
load coastlines
plotm(coastlat,coastlon)

land = shaperead('landareas', 'UseGeoCoords', true);
geoshow(gca, land, 'FaceColor', [0.5 0.7 0.5])

lakes = shaperead('worldlakes', 'UseGeoCoords', true);
geoshow(lakes, 'FaceColor', 'blue')

rivers = shaperead('worldrivers', 'UseGeoCoords', true);
geoshow(rivers, 'Color', 'blue')

cities = shaperead('worldcities', 'UseGeoCoords', true);
geoshow(cities, 'Marker', '.', 'Color', 'red')

% display the data
NumContours = 10;
contourfm(X, Y, Z, NumContours)

Plots = findobj(gca,'Type','Axes');
Plots.SortMethod = 'depth';
