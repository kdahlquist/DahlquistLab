%% User must input filename, sheetname, and strains for comparison
filename = 'GCAT_and_Ontario_Final_Normalized_Data.xls'; % Name of input file
sheetname  = 'Master_Sheet'; % Name of sheet in input file containing data to analyze
% % If one of the two strains you are working on is the wildtype, keep that
% % wildtype as strain 1.
strain1    = 'wt'; %Here should be wt, dCIN5, dGLN3, dHMO1, or dZAP1
% % Select strain 2 to be one of the other strains you would like to
% % compare with the first strain.
strain2    = 'dZAP1'; %Here should be dCIN5, dGLN3, dHMO1, or dZAP1

%% User no longer has to adjust any code from here on

%Determine if the user would like to see plots for each gene with an
%unadjusted p-value < 0.05.
disp('Do you want to view plots for each gene with an unadjusted p-value < 0.05?')
graph = input('If yes, enter "1". If no, enter "0". ');

%Input data from  Excel file
[a,b]=xlsread(filename,sheetname);
%
% a = numerical data from sheet in matrix form
% b = character data from sheet in cell array form
%
%

%Identify where in the cell array ''b'' does the first strain ''strain1'' and the specified time point appear.
T15S1 = strfind(b(1,:),[strain1 '_LogFC_t15']); %15 minutes
T30S1 = strfind(b(1,:),[strain1 '_LogFC_t30']); %30 minutes
T60S1 = strfind(b(1,:),[strain1 '_LogFC_t60']); %60 minutes
T90S1 = strfind(b(1,:),[strain1 '_LogFC_t90']); %90 minutes
T120S1 = strfind(b(1,:),[strain1 '_LogFC_t120']); %120 minutes

%Identify where in the cell array ''b'' does the second strain ''strain2'' and the specified time point appear.
T15S2 = strfind(b(1,:),[strain2 '_LogFC_t15']); %15 minutes
T30S2 = strfind(b(1,:),[strain2 '_LogFC_t30']); %30 minutes
T60S2 = strfind(b(1,:),[strain2 '_LogFC_t60']); %60 minutes
T90S2 = strfind(b(1,:),[strain2 '_LogFC_t90']); %90 minutes
T120S2 = strfind(b(1,:),[strain2 '_LogFC_t120']); %120 minutes

%Create an index designating which column of the data array ''a'' corresponds to each time point for the first strain ''strain1''.
ind15S1 = find(not(cellfun('isempty',T15S1)))-(length(b(1,:))-length(a(1,:))); %15 minutes
ind30S1 = find(not(cellfun('isempty',T30S1)))-(length(b(1,:))-length(a(1,:))); %30 minutes
ind60S1 = find(not(cellfun('isempty',T60S1)))-(length(b(1,:))-length(a(1,:))); %60 minutes
ind90S1 = find(not(cellfun('isempty',T90S1)))-(length(b(1,:))-length(a(1,:))); %90 minutes
ind120S1 = find(not(cellfun('isempty',T120S1)))-(length(b(1,:))-length(a(1,:))); %120 minutes

%Combine all data column indices into one array
indS1   = [ind15S1,ind30S1,ind60S1,ind90S1,ind120S1];

%Create an index designating which column of the data array ''a'' corresponds to each time point for the second strain ''strain2''.
ind15S2 = find(not(cellfun('isempty',T15S2)))-(length(b(1,:))-length(a(1,:))); %15 minutes
ind30S2 = find(not(cellfun('isempty',T30S2)))-(length(b(1,:))-length(a(1,:))); %30 minutes
ind60S2 = find(not(cellfun('isempty',T60S2)))-(length(b(1,:))-length(a(1,:))); %60 minutes
ind90S2 = find(not(cellfun('isempty',T90S2)))-(length(b(1,:))-length(a(1,:))); %90 minutes
ind120S2 = find(not(cellfun('isempty',T120S2)))-(length(b(1,:))-length(a(1,:))); %120 minutes

%Combine all data column indices into one array
indS2   = [ind15S2,ind30S2,ind60S2,ind90S2,ind120S2];
N = length(indS1)+length(indS2);

alpha = 0.05; %Significance value for statistical test.
n = length(a(:,1)); %Total number of genes.
p = 10; % Number of time points multiplied by the number of strains.
q = 5; % p/number of strains

if strcmpi(strain1,'wt') == 0
    indS1x   = find(indS1);
    i0 = ind15S1(1);
    i1 = indS1x(end);
    i2 = indS2(1);
    
    %Create new indices without any breaks so as to properly construct the
    %regressor matrices X and Xh.
    ind151 = find(ind15S1);
    ind301 = ind30S1-i0+1;
    ind601 = ind60S1-i0+1;
    ind901 = ind90S1-i0+1;
    ind1201 = ind120S1-i0+1;
    
    ind1 = [ind151,ind301,ind601,ind901,ind1201];
    
    ind152 = ind15S2-i2+1+i1;
    ind302 = ind30S2-i2+1+i1;
    ind602 = ind60S2-i2+1+i1;
    ind902 = ind90S2-i2+1+i1;
    ind1202 = ind120S2-i2+1+i1;
    
    ind2 = [ind152,ind302,ind602,ind902,ind1202];
    
    %Length of each array of indices
    n151 = length(ind151);
    n301 = length(ind301);
    n601 = length(ind601);
    n901 = length(ind901);
    n1201 = length(ind1201);
    n152 = length(ind152);
    n302 = length(ind302);
    n602 = length(ind602);
    n902 = length(ind902);
    n1202 = length(ind1202);
    
    %ts1 and ts2 are arrays of time points reflecting the number of
    %replicates in the data for ''strain1'' and ''strain2'', respectively.
    %This will be necessary to later plot the linear model for each gene.
    ts1 = [ones(n151,1)*15;ones(n301,1)*30;ones(n601,1)*60;ones(n901,1)*90;ones(n1201,1)*120];
    ts2 = [ones(n152,1)*15;ones(n302,1)*30;ones(n602,1)*60;ones(n902,1)*90;ones(n1202,1)*120];
    t   = [ts1;ts2];
    [tsort,is] = sort(t); %tsort contains the sorted list of time points after combining arrays ts1 and ts2.
    
    % X and Xh are regressor matrices for the full and hypothesized
    % models, respectively
    
    X   = zeros(N,p);
    Xh  = zeros(N,p-q);
    
    Xh(ind151,1) = 1;
    Xh(ind301,2) = 1;
    Xh(ind601,3) = 1;
    Xh(ind901,4) = 1;
    Xh(ind1201,5) = 1;
    Xh(ind152,1) = 1;
    Xh(ind302,2) = 1;
    Xh(ind602,3) = 1;
    Xh(ind902,4) = 1;
    Xh(ind1202,5) = 1;
    
    X(ind151,1) = 1;
    X(ind301,2) = 1;
    X(ind601,3) = 1;
    X(ind901,4) = 1;
    X(ind1201,5) = 1;
    X(ind152,6) = 1;
    X(ind302,7) = 1;
    X(ind602,8) = 1;
    X(ind902,9) = 1;
    X(ind1202,10) = 1;
end
%
% out_data includes
%
out_data = zeros(n,12);
nsig = 0;

for ii=1:n
    if strcmpi(strain1,'wt') == 1
        %     Excludes all fold changes that have are an NaN.
        I = find(~isnan(a(ii,indS1)));
        ind15x = I(I>=ind15S1(1)&I<=ind15S1(end));
        ind30x = I(I>=ind30S1(1)&I<=ind30S1(end));
        ind60x = I(I>=ind60S1(1)&I<=ind60S1(end));
        ind90x = I(I>=ind90S1(1)&I<=ind90S1(end));
        ind120x = I(I>=ind120S1(1)&I<=ind120S1(end));
        
        %indx represents the list of columns from which the data will be drawn
        indx = [ind15x,ind30x,ind60x,ind90x,ind120x];
        c = length(indx);
        
        if c<23
            ind15x = find(ind15x);
            ind30x = find(ind30x)+ind15x(end);
            ind60x = find(ind60x)+ind30x(end);
            ind90x = find(ind90x)+ind60x(end);
            ind120x = find(ind120x)+ind90x(end);
        end
        
        indX = find(indx);
        i1 = indX(end);
        i2 = indS2(1);
        
        ind152m = ind15S2-i2+1+i1;
        ind302m = ind30S2-i2+1+i1;
        ind602m = ind60S2-i2+1+i1;
        ind902m = ind90S2-i2+1+i1;
        ind1202m = ind120S2-i2+1+i1;
        
        indm = [ind152m,ind302m,ind602m,ind902m,ind1202m];
        
        N = length(indx)+length(indm);
        
        % X and Xh are regressor matrices for the fulll and hypothesized
        % mdoels, respectively
        X   = zeros(N,p);
        Xh  = zeros(N,p-q);
        
        Xh(ind15x,1) = 1;
        Xh(ind30x,2) = 1;
        Xh(ind60x,3) = 1;
        Xh(ind90x,4) = 1;
        Xh(ind120x,5) = 1;
        Xh(ind152m,1) = 1;
        Xh(ind302m,2) = 1;
        Xh(ind602m,3) = 1;
        Xh(ind902m,4) = 1;
        Xh(ind1202m,5) = 1;
        
        X(ind15x,1) = 1;
        X(ind30x,2) = 1;
        X(ind60x,3) = 1;
        X(ind90x,4) = 1;
        X(ind120x,5) = 1;
        X(ind152m,6) = 1;
        X(ind302m,7) = 1;
        X(ind602m,8) = 1;
        X(ind902m,9) = 1;
        X(ind1202m,10) = 1;
        
        %Length of each array of indices
        n151 = length(ind15x);
        n301 = length(ind30x);
        n601 = length(ind60x);
        n901 = length(ind90x);
        n1201 = length(ind120x);
        n152 = length(ind152m);
        n302 = length(ind302m);
        n602 = length(ind602m);
        n902 = length(ind902m);
        n1202 = length(ind1202m);
        
        %ts1 and ts2 are arrays of time points reflecting the number of
        %replicates in the data for ''strain1'' and ''strain2'', respectively.
        %This will be necessary to later plot the linear model for each gene.
        ts1 = [ones(n151,1)*15;ones(n301,1)*30;ones(n601,1)*60;ones(n901,1)*90;ones(n1201,1)*120];
        ts2 = [ones(n152,1)*15;ones(n302,1)*30;ones(n602,1)*60;ones(n902,1)*90;ones(n1202,1)*120];
        t   = [ts1;ts2];
        [tsort,is] = sort(t); %tsort contains the sorted list of time points after combining arrays ts1 and ts2.
        
    else
        indx = indS1;
    end
    
    Ys1 = a(ii,indx)'; %Data for a gene for the first strain
    Ys2 = a(ii,indS2)'; %Data for a gene for the second strain
    Y   = [Ys1;Ys2];
    
    beta    = X\Y; %Average log fold change for each time point in the full model.
    betah   = Xh\Y; %Average log fold change for each time point in the hypothesized model.
    
    out_data(ii,1:10) = beta';
    out_data(ii,11:15) = betah';
    
    s2 = (1/N)*(Y-X*beta)'*(Y-X*beta); %Sum of squares of error in the full model
    s2h = (1/N)*(Y-Xh*betah)'*(Y-Xh*betah); %Sum of squares of error in the hypothesized model
    
    W       = ((N-p)/q)*((s2h-s2)/s2); % F statistic
    pval    = 1-fcdf(W,q,N-p); %P value
    
    out_data(ii,16) = W;
    out_data(ii,17) = pval;
    out_data(ii,18) = s2*N;
    out_data(ii,19) = s2h*N;
    
    if strcmpi(strain1,'wt') == 1
        Ym1 = X(indx,1:5)*beta(1:5,1);
        Ym2 = X(indm,6:10)*beta(6:10,1);
    else
        Ym1 = X(ind1,1:5)*beta(1:5,1);
        Ym2 = X(ind2,6:10)*beta(6:10,1);
    end
    Yh  = Xh*betah; %Model based on null hypothesis that both genes exhibit the same dynamics
    
    if graph == 1
    %Graph the expression profile of each gene as determined by the general
    %linear model.
    
    pause on
    if pval<0.05
        figure(1),plot(ts1,Ys1,'ro'),hold on,plot(ts2,Ys2,'mo'),plot(ts1,Ym1,'r','LineWidth',2),plot(ts2,Ym2,'m','LineWidth',2),...
            plot(tsort,Yh(is),'k','LineWidth',2),title([b{ii+1,1} '/' b{ii+1,2},'   W = ',num2str(W),' pval = ',num2str(pval)]),...
            xlabel('time, minutes'),ylabel('log fold change'),...
            legend([strain1 ' data'],[strain2 ' data'],[strain1 ' model'],[strain2 ' model'],'hypothesized model'),drawnow
        hold off
        nsig = nsig + 1;
        [ii,nsig]
        drawnow
        pause
    end
    end
end

p1 = out_data(:,17); %P values
q1 = (alpha/n)*[1:n]';

[ps,is] = sort(p1); %Sort the p values.

tests   = ps<=q1;
itests  = find(tests==1);
itestm  = max(itests);

qs = zeros(size(q1));
rs = qs;
for ii = 1:n
    qs(is(ii)) = ps(ii)*n/ii; % Perform B&H Correction
    rs(is(ii)) = ii;
end

signif                  = zeros(n,1);
signif(is(1:itestm))    = 1; % Specify whether or not the corrected p value is significant

% Output all data

out_data(:,20) = qs;
out_data(:,21) = signif;
out_data(:,22) = rs;

eval(['save ' strain1 '_' strain2 '_out_data out_data;']);

out_data_cells{1,1} = 'Systematic Name';
out_data_cells{1,2} = 'Standard Name';
out_data_cells{1,3} = [strain1 '_t15'];
out_data_cells{1,4} = [strain1 '_t30'];
out_data_cells{1,5} = [strain1 '_t60'];
out_data_cells{1,6} = [strain1 '_t90'];
out_data_cells{1,7} = [strain1 '_t120'];
out_data_cells{1,8} = [strain2 '_t15'];
out_data_cells{1,9} = [strain2 '_t30'];
out_data_cells{1,10} = [strain2 '_t60'];
out_data_cells{1,11} = [strain2 '_t90'];
out_data_cells{1,12} = [strain2 '_t120'];
out_data_cells{1,13} = 'hyp_t15';
out_data_cells{1,14} = 'hyp_t30';
out_data_cells{1,15} = 'hyp_t60';
out_data_cells{1,16} = 'hyp_t90';
out_data_cells{1,17} = 'hyp_t120';
out_data_cells{1,18} = 'f stat';
out_data_cells{1,19} = 'p val';
out_data_cells{1,20} = 'SS full';
out_data_cells{1,21} = 'SS hyp';
out_data_cells{1,22} = 'B&H comps';
out_data_cells{1,23} = '? signif ?';
out_data_cells{1,24} = 'B&H rank';
for ii = 1:n
    out_data_cells{1+ii,1} = b{ii+1,1};
    out_data_cells{1+ii,2} = b{ii+1,2};
    for jj = 1:22
        out_data_cells{1+ii,2+jj} = out_data(ii,jj);
    end
end
xlswrite([strain1 '_' strain2 '_ANOVA_out_data.xls'],out_data_cells)




