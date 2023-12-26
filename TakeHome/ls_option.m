function [Ls] = ls_option(vol,OptData,j)
%load arrays from market dataset
Sask = extractfield(OptData,'Sask');
Sbid = extractfield(OptData,'Sbid');
rf = extractfield(OptData,'rf');
tau = extractfield(OptData,'tau');
Cask = extractfield(OptData,'Callask');
Cbid = extractfield(OptData,'Callbid');

% extract K
k = {OptData.K};
K = zeros(2,500);
for i = 1:numel(k)
    % If the element is a scalar, append it to the K
    if isscalar(k{i})
        K(1,i) = k{i};
    else
        % If the element is an array, append its elements to the K
        K(:,i) = k{i}';
    end
end
K=K';

% extract Cask
cask = {OptData.Callask};
Cask = zeros(2,500);
for i = 1:numel(cask)
    % If the element is a scalar, append it to the K
    if isscalar(cask{i})
        Cask(1,i) = cask{i};
    else
        % If the element is an array, append its elements to the K
        Cask(:,i) = cask{i}';
    end
end
Cask = Cask';
% extract Cbid
cbid = {OptData.Callbid};
Cbid = zeros(2,500);
for i = 1:numel(cbid)
    % If the element is a scalar, append it to the K
    if isscalar(cbid{i})
        Cbid(1,i) = cbid{i};
    else
        % If the element is an array, append its elements to the K
        Cbid(:,i) = cbid{i}';
    end
end
Cbid = Cbid';

% calculate least square for each time period
ls = zeros(1,2);
    for t=1:2      
        if (K(j,t)>0)
            % determine weight
            lambda = 1/(Cask(j,t)-Cbid(j,t))^2;
            %lambda = 1;
            
            % determine stock price
            Sspread = Sask(j) - Sbid(j);
            S = Sbid(j) + Sspread*rand();
            
            % determine market option price
            Cspread = Cask(j,t) - Cbid(j,t);
            C_market = Cbid(j,t) + Cspread*rand();
            
            % determine black-sholes price
            C_model = blsprice(S,K(j,t),rf(t),tau(t),vol);

            ls(t) = lambda*(C_market - C_model).^2;

        end
    end
    Ls = sum(ls);
end