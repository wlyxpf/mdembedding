%% Using |mdDelay()| and |mdFnn()| to estimate embedding of the Lorenz attractor
% 
% This file contains examples of how to use the functions mdDelay and mdFnn
% on example data from the Lorenz equations. This script was used to
% produce Figure 1 and Figure 2 in the article, but also contains some
% additional examples of calling the functions and plotting the results.
%
% 


%% Load the data and set font size for plots

data = load('lorenz_3d_timeseries.txt');
fontSize = 18;

%% Plot the full Lorenz attractor (Figure 1a in the article)
figure1a = figure;
set(gcf,'color','white')
axes1a = axes('Parent',figure1a);
hold(axes1a,'on');
plot3(data(:,1),data(:,2),data(:,3),'k')
xlabel('x')
ylabel('y')
zlabel('z')
view(axes1a,[67 25]);
set(gca,'FontSize',fontSize,'fontWeight','normal')
print('Figure1a','-dpng')

%% Estimate the time delay and plot only the x-variable
tau = mdDelay(data(:,1), 'maxLag', 25, 'plottype', 'all');
set(gca,'FontSize',fontSize,'fontWeight','normal')
disp('x: tau = ' + string(tau))
estimatedTau = round(tau) % Round tau to get integer value

%% Construct time delayed versions of the x-variable (Figure 1b-d in the aricle)
% To see the effect in the plot we use an exaggerated value of tau
% For illustration purposes: tau = 40
tau = 40;
figure();
set(gcf,'color','white')
% Plot the x variable
subplot(3,1,1), plot(data(:,1),'k')
ylabel('x')
axis([0 2000 min(data(:,1)) max(data(:,1))])
set(gca,'FontSize',fontSize,'fontWeight','normal')
set(findall(gcf,'type','text'),'FontSize',fontSize,'fontWeight','normal')
% Plot the x variable delayed by tau
subplot(3,1,2), plot(data(1 + tau:end,1),'k')
ylabel('x')
axis([0 2000 min(data(:,1)) max(data(:,1))])
set(gca,'FontSize',fontSize,'fontWeight','normal')
set(findall(gcf,'type','text'),'FontSize',fontSize,'fontWeight','normal')
subplot(3,1,3), plot(data(1 + 2 * tau:end,1),'k')
ylabel('x')
xlabel('time')
axis([0 2000 min(data(:,1)) max(data(:,1))])
set(gca,'FontSize',fontSize,'fontWeight','normal')
set(findall(gcf,'type','text'),'FontSize',fontSize,'fontWeight','normal')

%% Reconstruct the attractor based on embedding the time delayed x time series (Figure 1e in the article)
% Visual inspection of the AMI function indicates that the first local
% minimium value is too high a value for tau, since the AMI reaches
% essentially the same level at tau around 13, so we will pick this value.
tau = 13;
% Embedding dimension (from mdFnn, or table 1 in the article).
m = 3;
figure1e = figure();
set(gcf,'color','white')
axes1e = axes('Parent',figure1e);
hold(axes1e,'on');
plot3(data(1:end-(m-1)*tau,1),data(1+tau:end-(m-2)*tau,1),data(1+2*tau:end,1),'k')
xlabel('x')
ylabel('y')
zlabel('z')
view(axes1e,[67 25]);
set(gca,'FontSize',fontSize,'fontWeight','normal')
set(findall(gcf,'type','text'),'FontSize',fontSize,'fontWeight','normal')

%% Estimate time delay and plot AMI using all variables (Figure 2a in article)
tau = mdDelay(data, 'maxLag', 25, 'plottype', 'all');
set(gca,'FontSize',fontSize,'fontWeight','normal')
disp('xyz: tau = ' + string(tau))
print('Figure2a','-dpng')


%% Estimate the embedding dimension (Figure 2b in the article)
[fnnPercent, embeddingDimension] = mdFnn(data, round(tau));
set(gca,'FontSize',fontSize,'fontWeight','normal')
print('Figure2b','-dpng')

%% Alternative method to find time delay using first local minimum criterion
tau = mdDelay(data, 'maxLag', 25, 'plottype', 'all', 'criterion', 'localMin');
set(gca,'FontSize',fontSize,'fontWeight','normal')
disp('xyz: tau = ' + string(tau))

%% Plot the average AMI and standard deviation
tau = mdDelay(data, 'maxLag', 25, 'plottype', 'mean');
set(gca,'FontSize',fontSize,'fontWeight','normal')
disp('xyz: tau = ' + string(tau))

%% Time delay and plot only the y-variable
tau = mdDelay(data(:,2), 'maxLag', 25, 'plottype', 'all');
set(gca,'FontSize',fontSize,'fontWeight','normal')
disp('y: tau = ' + string(tau))


%% Time delay and plot only the z-variable
tau = mdDelay(data(:,3), 'maxLag', 25, 'plottype', 'all');
set(gca,'FontSize',fontSize,'fontWeight','normal')
disp('z: tau = ' + string(tau))


%% Time delay and plot x and y variables
tau = mdDelay(data(:,1:2), 'maxLag', 25, 'plottype', 'all');
set(gca,'FontSize',fontSize,'fontWeight','normal')
disp('xy: tau = ' + string(tau))


%% Time delay and plot x and z variables
tau = mdDelay(data(:,[1,3]), 'maxLag', 25, 'plottype', 'all');
set(gca,'FontSize',fontSize,'fontWeight','normal')
disp('xz: tau = ' + string(tau))


%% Time delay and plot y and z variables
tau = mdDelay(data(:,2:3), 'maxLag', 25, 'plottype', 'all');
set(gca,'FontSize',fontSize,'fontWeight','normal')
disp('yz: tau = ' + string(tau))