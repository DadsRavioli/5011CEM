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