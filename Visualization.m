%This software requires the installing of "Mapping Toolbox" addon, this can
%be installed automatically through the matlab interface.

global currentHour;
global play;
global dataSource;
global endTime;

endTime = 25;

setHour(1);
setPlay(true);

%Creates our initial window
fig2 = uifigure("Position", [400 400 280 200]);

text2 = uilabel(fig2, "Position", [90 140 120 30], "Text", "Data Sources:");
box = uibuttongroup(fig2,'Position',[90 60 120 85]);
nButton = uiradiobutton(box, 'Position', [5 60 120 15], 'Text', 'CBE Data');

%Creates the next button in the UI
%line 27 triggers the next function when it detects the button has been
%pushed
nextBtn = uibutton(fig2,"push",...
    "Text", "Next",...
    "Position",[120 20 50 20],...
    "ButtonPushedFcn", @(btn,event) next(nButton, fig2));

function startFunc()
    %Depending on source selected this function can be adapted to select
    %multiple sources
    if getDataSource()==1
        n = ncread('C:\Users\Dads Ravioli\Desktop\Year 3 Work\50011CEMMatlab\data.nc', "ensemble_ozone");
        text = "CBE based data that displaying O^3 in the europeon atmosphere.";
    end
    
    fig = uifigure("Position",[400 350 600 600]); %Creates the new window where the map is displayed
    
    desc = uilabel(fig,... %Creates the description at the top of the map
        "Position", [90 550 595 30],...
        "Text", text);
    
    cycleThru(fig, n) 
end

function displayHour(currentHour, fig, n)
[x] = 30.15:0.1:69.85; % create x value
[y] = -24.85:0.1:44.85; %Create y Value
   
[x, y] = meshgrid(x, y); %Create a grid with the lat and long

%Lines 54 to 64 taken from
%https://cumoodle.coventry.ac.uk/pluginfile.php/3233614/mod_resource/content/2/VisualinationExample.m
map = worldmap('Europe');
land = shaperead('landareas', 'UseGeoCoords', true);
geoshow(gca, land, 'FaceColor', [0.5 0.7 0.5])
lakes = shaperead('worldlakes', 'UseGeoCoords', true);
geoshow(lakes, 'FaceColor', 'blue')
rivers = shaperead('worldrivers', 'UseGeoCoords', true);
geoshow(rivers, 'Color', 'blue')
cities = shaperead('worldcities', 'UseGeoCoords', true);
geoshow(cities, 'Marker', '.', 'Color', 'red')

surfm(x, y, n(:,:,currentHour),'FaceAlpha', 0.5);%Plots the map with the data

mapCopy = copyobj(map, fig);  
close();                  
end

function cycleThru(fig, n)  
    global currentHour
    
    while getPlay()      
        displayHour(currentHour, fig, n); %Shows the data depending on the current hour
        if getHour() == getendTime()   
            currentHour = 1;
        else
            currentHour = currentHour+1;              
        end
        pause(0.7); %Creates a 0.7 second pause between changing hours
    end
end             

function next(nButton, fig)
    if nButton.Value == 1
        setDataSource(1)
    end
    close(fig);    
    startFunc()
end

%Functions to setup Global Variables
function r = getPlay
    global play;
    r = play;
end

function setPlay(val)
    global play;
    play = val;
end

function r = getHour
    global currentHour;
    r = currentHour;
end

function setHour(val)
    global currentHour;
    currentHour = val;
end

function r = getendTime
    global endTime;
    r = endTime;
end

function r = getDataSource
    global DataSource;
    r = DataSource;
end

function setDataSource(val)
    global DataSource;
    DataSource = val;
end

