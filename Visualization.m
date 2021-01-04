%Creates our initial window
fig2 = uifigure("Position", [400 400 280 200]);

text2 = uilabel(fig2, "Position", [90 140 120 30], "Text", "Data Sources:");
box = uibuttongroup(fig2,'Position',[90 60 120 85]);
nButton = uiradiobutton(box, 'Position', [5 60 120 15], 'Text', 'CBE Data');

%Creates the next button in the UI
%line 23 triggers the next function when it detects the button has been
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
    loop(fig, n) 
end

function loop(fig, n)  
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

