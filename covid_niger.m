function covid_niger()
% This function read in the data and makes a gif of the data of Covid cases
% In Niger West-Africa

%First column is the total number of cases 
%Second column is the number of active cases 
%Thrid column is the number of death 
DATA = xlsread('COVID_NIGER.xlsx');
[rows, columns] = size(DATA);

%Set the colors that will be used to plot the data
colors = ['r','b','k'];

%Set the initial date 
month = "March";
year = 2020;
day = 15;
date = strcat(month, " ",num2str(day)," ",num2str(year));

% Scatter the first point 
scatter(0,0,'filled','b')
axis([0 40 0 700])
title("Evolution of COVID-19 cases in Niger from March 15 to April 19 "+newline+date)
hold on

for j = 2:rows 
   
    for i = 1:columns-1
        %for ecah column scatter and plot the number of cases
        %versus the number of days passed the initial date
        
        p(i)= scatter(j,DATA(j,i),'filled',colors(i));
        hold on
        plot([j-1; j],[DATA(j-1,i);DATA(j,i)],colors(i))
        hold on
    end 
    
    %Set the date 
    if day< 31
        day = day+1;
    else 
        day = 1;
        month = "April";
    end 
    date = strcat(month, " ",num2str(day)," ",num2str(year));
    
    legend([p(1) p(2) p(3)],'Total cases','Active cases', 'Deaths');
    title("Evolution of COVID-19 cases in Niger from March 15 to April 19 "+newline+date)
    xlabel('Number of Days passed March 15')
   
    
    frame = getframe(gcf); % saves the current figure
    im{j} = frame2im(frame); % stores it in the list "im"
end
filename = 'Covid_Niger_gif.gif'; % will save to "Current Folder"
gif_time = 0.01; % roughly the number of seconds for each frame of gif

for f = 2:length(im)
    
    [A,map] = rgb2ind(im{f},256);
    if f == 2
        imwrite(A,map,filename,"gif","LoopCount",Inf,"DelayTime",gif_time);
    else
        imwrite(A,map,filename,"gif","WriteMode","append","DelayTime",gif_time);
    end
    
end

end
