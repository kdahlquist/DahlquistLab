filename    = 'GCAT_and_Ontario_Final_Normalized_Data.xls';
sheetname   = 'Master_Sheet';
strain      = 'dHMO1'; %wt, dCIN5, dGLN3, dHMO1, or dZAP1
[a,b]=xlsread(filename,sheetname);

%Identify where in the cell array b does the specified strain and time
%point appear.
strainT15 = strfind(b(1,:),[strain '_LogFC_t15']);
strainT30 = strfind(b(1,:),[strain '_LogFC_t30']);
strainT60 = strfind(b(1,:),[strain '_LogFC_t60']);
strainT90 = strfind(b(1,:),[strain '_LogFC_t90']);
strainT120 = strfind(b(1,:),[strain '_LogFC_t120']);

%Creates an index designating which column of the data array a corresponds 
%to each time point.
ind15 = find(not(cellfun('isempty',strainT15)))-(length(b(1,:))-length(a(1,:)));
ind30 = find(not(cellfun('isempty',strainT30)))-(length(b(1,:))-length(a(1,:)));
ind60 = find(not(cellfun('isempty',strainT60)))-(length(b(1,:))-length(a(1,:)));
ind90 = find(not(cellfun('isempty',strainT90)))-(length(b(1,:))-length(a(1,:)));
ind120 = find(not(cellfun('isempty',strainT120)))-(length(b(1,:))-length(a(1,:)));

alpha = 0.05; %Significance value for statistical test.
n = length(a(:,1)); %Total number of genes.
p = 5; % Number of independent variables.
q = 5; % Number of contraints on the linear model.

% All the columns of array a containing data to be used.
ind = [ind15,ind30,ind60,ind90,ind120];
N = length(ind);

%
% X is the regressor matrix for the full ANOVA model
%
X = zeros(N,p);

% Changes the sequence of indices to start at 1 to construct the regressor
% matrix.
if ind(1)~= 1
ind151 = ind15-ind15(1)+1;
ind301 = ind30-ind30(1)+ind151(end)+1;
ind601 = ind60-ind60(1)+ind301(end)+1;
ind901 = ind90-ind90(1)+ind601(end)+1;
ind1201 = ind120-ind120(1)+ind901(end)+1;

%Set up the regressor matrix for the full ANOVA model.
X(ind151,1) = 1;
X(ind301,2) = 1;
X(ind601,3) = 1;
X(ind901,4) = 1;
X(ind1201,5) = 1;
else 
   X(ind15,1) = 1;
   X(ind30,2) = 1;
   X(ind60,3) = 1;
   X(ind90,4) = 1;
   X(ind120,5) = 1; 
end

out_data = zeros(n,12); %Specify dimensions of output matrix.

nsig = 0;

% Compute the F statistic and p value.
for ii = 1:n
if strcmpi(strain,'wt') == 1
%     Excludes all fold changes that have are an NaN.
    I = find(~isnan(a(ii,ind)));
    ind15x = I(I>=ind15(1)&I<=ind15(end));
    ind30x = I(I>=ind30(1)&I<=ind30(end));
    ind60x = I(I>=ind60(1)&I<=ind60(end));
    ind90x = I(I>=ind90(1)&I<=ind90(end));
    ind120x = I(I>=ind120(1)&I<=ind120(end));
    
    %indx represents the list of columns from which the data will be drawn
    indx = [ind15x,ind30x,ind60x,ind90x,ind120x];
    N = length(indx);
    
%     Adjusts the indices so that they are continuous.
    if N<23
        ind15x = find(ind15x);
        ind30x = find(ind30x)+ind15x(end);
        ind60x = find(ind60x)+ind30x(end);
        ind90x = find(ind90x)+ind60x(end);
        ind120x = find(ind120x)+ind90x(end);
    end

%     Set up the regressor matrix.
    X = zeros(N,p);
    X(ind15x,1) = 1;
    X(ind30x,2) = 1;
    X(ind60x,3) = 1;
    X(ind90x,4) = 1;
    X(ind120x,5) = 1;
else
    indx = ind;
end

    Y = a(ii,indx)'; %Select all the log fold change data corresponding to a particular gene.

    beta = X\Y; %Average log fold change for each time point.

    out_data(ii,1:q) = beta'; %Output the average log fold change.

    s2 = (1/N)*(Y-X*beta)'*(Y-X*beta); %Full model (without contraints)
    s2h = (1/N)*(Y'*Y); %Hypothesized model (with contraints)

    W      = ((N-p)/q)*((s2h-s2)/s2); %F statistic
    pval    = 1-fcdf(W,q,N-p); %P value

    %Output
    out_data(ii,6) = W;
    out_data(ii,7) = pval;
    out_data(ii,8) = s2*N;
    out_data(ii,9) = s2h*N;
end

p1 = out_data(:,7); %P values
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

%Final Output

signif                  = zeros(n,1);
signif(is(1:itestm))    = 1;

out_data(:,10) = qs;
out_data(:,11) = signif;
out_data(:,12) = rs;

eval(['save ' strain '_out_data out_data;']);

out_data_cells{1,1} = 'Systematic Name';
out_data_cells{1,2} = 'Standard Name';
out_data_cells{1,3} = [strain '_t15'];
out_data_cells{1,4} = [strain '_t30'];
out_data_cells{1,5} = [strain '_t60'];
out_data_cells{1,6} = [strain '_t90'];
out_data_cells{1,7} = [strain '_t120'];
out_data_cells{1,8} = 'f stat';
out_data_cells{1,9} = 'p val';
out_data_cells{1,10} = 'SS full';
out_data_cells{1,11} = 'SS hyp';
out_data_cells{1,12} = 'B&H comps';
out_data_cells{1,13} = '? signif ?';
out_data_cells{1,14} = 'B&H rank';
for ii = 1:n
    out_data_cells{1+ii,1} = b{ii+1,1};
    out_data_cells{1+ii,2} = b{ii+1,2};
    for jj = 1:12
        out_data_cells{1+ii,2+jj} = out_data(ii,jj);
    end
end
xlswrite([strain '_one_strain_ANOVA_out_data.xls'],out_data_cells)



